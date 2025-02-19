import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/viewmodels/login_view_model.dart';
import 'package:tictok_clone/features/authentication/widgets/form_button.dart';

import '../onboarding/interests_screen.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  ConsumerState<LoginFormScreen> createState() => LoginFormScreenState();
}

class LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> _formData = {
    "email": "",
    "password": "",
  };

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        
        ref.read(loginProvider.notifier).login(_formData["email"]!, _formData["password"]!, context);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _formData["email"] = value;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _formData["password"] = value;
                  }
                },
              ),
              Gaps.v28,
              FormButton(
                disabled: false,
                onTap: _onSubmitTap,
                text: "Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
