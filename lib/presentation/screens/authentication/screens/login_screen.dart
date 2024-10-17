import 'package:flutter/material.dart';
import 'package:online_bazar/presentation/screens/authentication/screens/registration_screen.dart';

import '../../../widgets/authentication_widgets/forgot_password.dart';
import '../../../widgets/authentication_widgets/login_button.dart';
import '../../../widgets/authentication_widgets/login_fields.dart';
import '../../../widgets/authentication_widgets/title_words.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                TitleWords(
                    firstWord: 'Welcome to BAZAR',
                    secondWord: "Sign into continue"),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: LoginFields(
                    emailController: _emailController,
                    passwordController: _passwordControler,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LoginButton(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordControler,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ForgotPassword(),
                      barrierDismissible: false,
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xFF40BFFF),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(color: Colors.grey,fontSize: 12,),
                      children: [
                        TextSpan(
                          text:" Register",
                          style: TextStyle(color: Color(0xFF40BFFF),fontSize: 13,fontWeight: FontWeight.bold,)
                        )
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
