import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text field controllers
  //email controller
  TextEditingController emailController = TextEditingController();
  //password controller
  TextEditingController passwordController = TextEditingController();

  //login function
  void login() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //todo: login interface.
              //spacings
              const SizedBox(height: 100),
              //logo
              Icon(Icons.chat,
                  size: 80, color: Theme.of(context).colorScheme.primary),

              //spacings
              const SizedBox(height: 50),
              //welcome back message
              Text(
                "Welcome Back to PChat!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              //spacings
              const SizedBox(height: 20),
              //email field
              TheTextField(
                controller: emailController,
                hinText: "Email",
                obscureText: false,
              ),
              //password field
              TheTextField(
                  controller: passwordController,
                  hinText: "Password",
                  obscureText: true),
              //spacings.
              const SizedBox(height: 10),
              //login button
              TheButton(
                buttonText: "login",
                onTap: login,
              ),

              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  Text(
                    "Register Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
