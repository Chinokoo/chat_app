import 'package:chat_app/errors/error_handler.dart';
import 'package:chat_app/services/auth/firebase_auth_service.dart';
import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

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
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();
    //logging in
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ErrorHandler.showError(context, 'An error occurred: ${e.toString()}');
    }
  }

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
                "Welcome Back to LChat!",
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
                onTap: () => login(context),
              ),

              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
