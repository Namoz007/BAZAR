import 'package:flutter/material.dart';

class LoginFields extends StatefulWidget {
  TextEditingController emailController;
  TextEditingController passwordController;
  LoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please,return input email!";
            }

            if(!value.contains('@')){
              return "Please,return input @ element to email!";
            }

            return null;
          },
          controller: widget.emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: "E-mail",
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please,return input password";
            }

            if(value.length < 6){
              return "Password min length 6!";
            }

            return null;
          },
          controller: widget.passwordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
      ],
    );
  }
}
