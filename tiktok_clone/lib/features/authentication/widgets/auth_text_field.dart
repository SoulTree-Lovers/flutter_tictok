
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final VoidCallback onEditingComplete;
  final bool isEmailTextField;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final Widget? suffix;
  final bool isObsecureText;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onEditingComplete,
    required this.isEmailTextField,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.isObsecureText = false,
  });


  @override
  Widget build(BuildContext context) {
    return TextField(
      onEditingComplete: onEditingComplete,
      keyboardType: isEmailTextField ? TextInputType.emailAddress : TextInputType.text,
      autocorrect: false,
      controller: controller,
      obscureText: isObsecureText,
      decoration: InputDecoration(
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
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
