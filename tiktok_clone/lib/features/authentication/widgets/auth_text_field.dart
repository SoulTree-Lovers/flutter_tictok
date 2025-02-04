
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final VoidCallback onEditingComplete;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onEditingComplete,
    this.errorText,
  });


  @override
  Widget build(BuildContext context) {
    return TextField(
      onEditingComplete: onEditingComplete,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText ?? null,
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      cursorColor: Theme.of(context).primaryColor,
    );
  }
}
