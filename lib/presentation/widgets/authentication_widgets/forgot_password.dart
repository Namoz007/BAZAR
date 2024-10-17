import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/authentication/bloc/authentication_bloc.dart';
import '../../screens/authentication/bloc/authentication_bloc_event.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter your email to reset your password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please,enter email!";
                }
                if (!value.contains('@')) {
                  return "Email format not true!";
                }

                return null;
              },
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "E-mail",
                prefixIcon: const Icon(
                  Icons.email,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            if(_formKey.currentState!.validate()){
              context.read<AuthenticationBloc>().add(ResetPasswordUserAuthenticationBlocEvent(email: _emailController.text));
              Navigator.pop(context);
            }
          },
          child: const Text("Send"),
        ),
      ],
    );
  }
}
