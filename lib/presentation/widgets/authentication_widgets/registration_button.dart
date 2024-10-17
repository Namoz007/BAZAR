import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/register_request_model.dart';
import '../../screens/authentication/bloc/authentication_bloc.dart';
import '../../screens/authentication/bloc/authentication_bloc_event.dart';
import '../../screens/authentication/bloc/authentication_bloc_state.dart';
import '../../screens/main_page/screens/main_page.dart';

class RegistrationButton extends StatefulWidget {
  GlobalKey<FormState> formKey;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  RegistrationButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegistrationButton> createState() => _RegistrationButtonState();
}

class _RegistrationButtonState extends State<RegistrationButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.formKey.currentState!.validate()) {
          context.read<AuthenticationBloc>().add(
                SignUpUserAuthenticationBlocEvent(
                  model: RegisterRequestModel(
                    fullName: widget.nameController.text,
                    email: widget.emailController.text,
                    password: widget.passwordController.text,
                  ),
                ),
              );
        }
      },
      child: Container(
        width: double.infinity,
        height: 57,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF40BFFF),
        ),
        alignment: Alignment.center,
        child: BlocConsumer<AuthenticationBloc, AuthenticationBlocState>(
            listener: (context, state) {
          if (state is ErrorAuthenticationBlocState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red,),
                ),
              ),
            );
          }

          if (state is AuthenticatedUserAuthenticationBlocState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false);
          }
        }, builder: (context, state) {
          if (state is LoadingAuthenticationBlocState) {
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          }
          return const Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}
