import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/login_request_model.dart';
import '../../screens/authentication/bloc/authentication_bloc.dart';
import '../../screens/authentication/bloc/authentication_bloc_event.dart';
import '../../screens/authentication/bloc/authentication_bloc_state.dart';
import '../../screens/main_page/screens/main_page.dart';

class LoginButton extends StatefulWidget {
  GlobalKey<FormState> formKey;
  TextEditingController emailController;
  TextEditingController passwordController;
  LoginButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.formKey.currentState!.validate()) {
          context.read<AuthenticationBloc>().add(
                LoginUserAuthenticationBlocEvent(
                  model: LoginRequestModel(
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
            print(state);
            if (state is AuthenticatedUserAuthenticationBlocState) {
              print('ishladi bu');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false,
              );
            }

            if (state is ErrorAuthenticationBlocState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAuthenticationBlocState) {
              return const CircularProgressIndicator(
                color: Colors.red,
              );
            }
            return const Text(
              "Sign In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
