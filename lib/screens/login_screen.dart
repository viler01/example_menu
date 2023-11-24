import '../services/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);
  static const id = 'LoginScreen';
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();

  bool showLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();

  bool showPassword = true;

  static const double padding_horizontal = 15;
  static const double padding_vertical = 10;

  String email = '';

  @override
  Widget build(BuildContext context) {
    return showLoading
        ? const LoadingScreen()
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Piaceri Carnali '),

      ),

            backgroundColor: Colors.white,
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: padding_horizontal,
                                    vertical: padding_vertical),
                                child: TextFormField(

                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      String pattern = r'\w+@\w+\.\w+';
                                      RegExp regex = RegExp(pattern);
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your email';
                                      } else {
                                        if (!regex
                                            .hasMatch(emailController.text)) {
                                          return 'Invalid Email Address format';
                                        }
                                        return null;
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: padding_horizontal,
                                    vertical: padding_vertical),
                                child: TextFormField(

                                  controller: password,
                                  obscureText: showPassword,
                                  textAlign: TextAlign.center,

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              CupertinoButton(

                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  setState(() => showLoading = true);
                                  await AuthService()
                                      .loginWithEmailAndPassword(
                                          email: email, password: password.text)
                                      .then((state) {
                                    setState(() => showLoading = false);
                                    Navigator.of(context)
                                        .pushReplacementNamed(AppDirector.id);
                                    if (state == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Not authenticated, please check email and password'),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: const Text('Accedi'),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
