import 'package:example_menu/GlobalVariable.dart';
import 'package:flutter/material.dart';
import 'package:example_menu/widgets/GeneralWidget/CustomTextField.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          child: SafeArea(
              child: LayoutBuilder(
              builder: (context, constraints){
                if( constraints.maxWidth > horizontalLayout){
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: double.infinity,),
                      SizedBox(
                        width: constraints.maxWidth*0.6,
                        height: constraints.maxHeight,
                        child: const LogoImage(),
                      ),
                      SizedBox(
                        width: constraints.maxWidth*0.4,
                        height: constraints.maxHeight,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: constraints.maxHeight*.4,),
                              UsernameTextField(),
                              PasswordTextField(),
                              LoginButton(),
                            ],
                          ),
                        ),
                      ),

                    ],
                  );
                }else{
                  return Column(
                    children: [
                      SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight*0.5,
                          child: const LogoImage()
                      ),
                      SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight*0.4,
                        child: const SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UsernameTextField(),
                              PasswordTextField(),
                              LoginButton(),
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
        onPressed: (){
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
  const UsernameTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: "USERNAME",
    );
  }
}


