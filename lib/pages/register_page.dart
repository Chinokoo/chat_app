import 'package:chat_app/auth/firebase_auth_service.dart';
import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text field controllers
  //email controller
  TextEditingController emailController = TextEditingController();
  //password controller
  TextEditingController passwordController = TextEditingController();
  //confirm password controller
  TextEditingController confirmPasswordController = TextEditingController();

  //register a user function
  void register(BuildContext context) {
    //get auth service
    final authService = AuthService();

    if (passwordController.text == confirmPasswordController.text) {
      try {
        authService.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords do not match!"),
        ),
      );
    }

    //todo: add error handling.
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
                "Create an account!",
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
              //confirm password field
              TheTextField(
                  controller: confirmPasswordController,
                  hinText: "Confirm Password",
                  obscureText: true),
              //spacings.
              const SizedBox(height: 10),
              //login button
              TheButton(
                buttonText: "register",
                onTap: () => register(context),
              ),

              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login here",
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
