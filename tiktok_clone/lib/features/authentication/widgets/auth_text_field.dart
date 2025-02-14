
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? errorText;
  final VoidCallback onEditingComplete;
  final bool isEmailTextField;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final Widget? suffix;
  final bool isObsecureText;
  final bool readOnly;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.onEditingComplete,
    required this.isEmailTextField,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.isObsecureText = false,
    this.readOnly = false,
  });


  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      onEditingComplete: onEditingComplete,
      keyboardType: isEmailTextField ? TextInputType.emailAddress : TextInputType.text,
      autocorrect: false,
      controller: controller,
      obscureText: isObsecureText,
      decoration: InputDecoration(
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText ?? "",
        errorText: errorText,
        hintStyle: TextStyle(
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
