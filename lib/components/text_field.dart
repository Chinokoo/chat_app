import 'package:flutter/material.dart';

class TheTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hinText;
  final bool obscureText;
  final FocusNode? focusNode;
  const TheTextField(
      {super.key,
      this.focusNode,
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
        controller: widget.controller,
        obscureText: widget.obscureText,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          hintText: widget.hinText,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
        ),
      ),
    );
  }
}
