import 'package:flutter/material.dart';

class TheTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hinText;
  final bool obscureText;
  const TheTextField(
      {super.key,
      required this.controller,
      required this.hinText,
      required this.obscureText});

  @override
  State<TheTextField> createState() => _TheTextFieldState();
}

class _TheTextFieldState extends State<TheTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          hintText: widget.hinText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
        ),
        controller: widget.controller,
        obscureText: widget.obscureText,
      ),
    );
  }
}
