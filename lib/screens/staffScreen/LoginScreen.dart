import 'package:example_menu/screens/staffScreen/StaffBottomBar.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import '../../services/imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showLoading = false;

  bool showPassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();

  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(restourantName),
      ),
      body: CustomPaint(
        painter: MyBackground(),
        child: Container(
          width: double.infinity,
          child: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > horizontalLayout) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: double.infinity,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.6,
                    height: constraints.maxHeight,
                    child: const LogoImage(),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxHeight,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * .4,
                          ),

                          CustomTextField(
                            controller: emailController,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            labelText: "E-Mail ",
                            validator: (value) {
                              String pattern = r'\w+@\w+\.\w+';
                              RegExp regex = RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return 'Enter your email';
                              } else {
                                if (!regex.hasMatch(emailController.text)) {
                                  return 'Invalid Email Address format';
                                }
                                return null;
                              }
                            },
                          ),
                          CustomTextField(
                            onChanged: (val) {
                              setState(() => pass = val);
                            },
                            controller: password,
                            obscureText: showPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              } else {
                                return null;
                              }
                            },
                          ),

                          TextButton(
                            onPressed: () async {

                              setState(() => showLoading = true);
                              await AuthService()
                                  .loginWithEmailAndPassword(
                                  email: email, password: password.text)
                                  .then((state) {
                                setState(() => showLoading = false);
                               // Navigator.of(context).pushNamed(AppDirector.id);
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return StaffBottomBar();
                                }));

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

                            child: const Text('Log In'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.5,
                      child: const LogoImage()),
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.4,
                    child:  SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            labelText: "E-Mail ",
                            controller: emailController,

                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            validator: (value) {
                              String pattern = r'\w+@\w+\.\w+';
                              RegExp regex = RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return 'Enter your email';
                              } else {
                                if (!regex.hasMatch(emailController.text)) {
                                  return 'Invalid Email Address format';
                                }
                                return null;
                              }
                            },
                          ),
                          CustomTextField(
                            controller: password,
                            obscureText: showPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextButton(
                            onPressed: () async {

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

                            child: const Text('Log In'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          })),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/staffHomePage");
      },
      child: const Text('Login'),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(restourantLogo);
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: "PASSWORD",
    );
  }
}

class UsernameTextField extends StatelessWidget {
  final TextEditingController controller;

  UsernameTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
    );
  }
}
