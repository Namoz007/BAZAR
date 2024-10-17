import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/details/app_details.dart';
import '../../../domain/entities/user_model.dart';
import '../../screens/authentication/bloc/authentication_bloc.dart';
import '../../screens/authentication/bloc/authentication_bloc_event.dart';
import '../../screens/authentication/screens/splash_screen.dart';

class ProfileDetails extends StatefulWidget {
  UserModel model;
  ProfileDetails({super.key,required this.model,});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey,),
                image: DecorationImage(image: AppDetails.model!.imgUrl == null ? const AssetImage("assets/images/person.jpg") : NetworkImage(AppDetails.model!.imgUrl.toString(),),fit: BoxFit.cover),
              ),
            ),
          ),
          
          const SizedBox(height: 20,),
          
          ListTile(
            leading: const Icon(Icons.female),
            title: const Text("Gender",style: TextStyle(fontWeight: FontWeight.bold,),),
            trailing: Text(widget.model.gender == null || widget.model.gender!.isEmpty ? "not know" : widget.model.gender.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey,),),
          ),

          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text("Birthday",style: TextStyle(fontWeight: FontWeight.bold,),),
            trailing: Text(widget.model.birthday == null ? "not know": "${widget.model.birthday!.day}-${widget.model.birthday!.month}-${widget.model.birthday!.year}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey,),),
          ),

          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Email',style: TextStyle(fontWeight: FontWeight.bold,),),
            trailing: Text(widget.model.email,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey,),),
          ),

          ListTile(
            leading: const Icon(Icons.phone_android_outlined),
            title: const Text("Phone Number",style: TextStyle(fontWeight: FontWeight.bold,),),
            trailing: Text(widget.model.phoneNumber == null || widget.model.phoneNumber!.isEmpty ? "not know": widget.model.phoneNumber.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey,),),
          ),
          
          ListTile(
            onTap: (){
              context.read<AuthenticationBloc>().add(LogOutAuthenticationBlocEvent());
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SplashScreen(),), (root) => false);
            },
            leading: const Icon(Icons.logout),
            title: const Text("Log Out",style: TextStyle(fontWeight: FontWeight.bold,),),
            trailing: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
