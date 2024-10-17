import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main_page/screens/main_page.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_bloc_event.dart';
import '../bloc/authentication_bloc_state.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(LoggedUserAuthenticationBlocEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc,AuthenticationBlocState>(
        listener: (context, state) {
          if(state is ErrorAuthenticationBlocState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message,),),);
          }

          if(state is UnAuthenticatedUserAuthenticationBlocState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }

          if(state is AuthenticatedUserAuthenticationBlocState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
          }

        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svgs/icons/logo.svg"),
              const SizedBox(height: 20,),
              const Text('BAZARuz',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 22,),)
            ],
          ),
        ),
      ),
    );
  }
}
