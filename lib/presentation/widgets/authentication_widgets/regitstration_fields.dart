import 'package:flutter/material.dart';

import 'login_fields.dart';

class RegistrationFields extends StatefulWidget {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  RegistrationFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegistrationFields> createState() => _RegitstrationFieldsState();
}

class _RegitstrationFieldsState extends State<RegistrationFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please,return input full name";
            }

            return null;
          },
          controller: widget.nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: "Full Name",
            prefixIcon: const Icon(Icons.person,),
          ),
        ),
        const SizedBox(height: 16,),
        LoginFields(
          emailController: widget.emailController,
          passwordController: widget.passwordController,
        ),
        const SizedBox(height: 16,),

        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please return input password";
            }

            if(widget.passwordController.text != value){
              return "Password and confirm password not the same";
            }

            return null;
          },
          controller: widget.confirmPasswordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: "Confirm Password",
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
      ],
    );
  }
}
