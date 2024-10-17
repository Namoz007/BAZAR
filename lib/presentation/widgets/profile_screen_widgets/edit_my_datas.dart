import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:img_picker/img_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/utils/details/app_details.dart';
import '../../../data/models/user_model.dart';
import '../../screens/profile_screen/bloc/user_bloc/user_bloc.dart';
import '../../screens/profile_screen/bloc/user_bloc/user_bloc_event.dart';

class EditMyDatas extends StatefulWidget {
  const EditMyDatas({super.key});

  @override
  State<EditMyDatas> createState() => _EditMyDatasState();
}

class _EditMyDatasState extends State<EditMyDatas> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumber = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? gender;
  DateTime? birthday;
  File? img;

  @override
  void initState() {
    super.initState();
    _nameController.text = AppDetails.model!.fullName;
    _phoneNumber.text = AppDetails.model!.phoneNumber ?? '';
    birthday = AppDetails.model!.birthday;
    gender = AppDetails.model?.gender;
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '+### (##) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<UserBloc>().add(
                            EditUserBlocEvent(
                              model: UserDetails(
                                id: AppDetails.model!.id,
                                email: AppDetails.model!.email,
                                fullName: _nameController.text,
                                gender: gender,
                                birthday: birthday,
                                imgUrl: AppDetails.model!.imgUrl,
                                phoneNumber:
                                    maskFormatter.getMaskedText().isEmpty
                                        ? AppDetails.model!.phoneNumber
                                        : maskFormatter.getMaskedText(),
                              ),
                              file: img,
                            ),
                          );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Done"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async{
                      final data = await _picker.pickImage(source: ImageSource.camera);
                      if(data != null){
                        img = File(data.path);
                      }
                    },
                    child: const Icon(Icons.camera_alt,size: 50,),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AppDetails.model!.imgUrl == null ? const AssetImage("assets/images/person.jpg") : NetworkImage(AppDetails.model!.imgUrl!,),fit: BoxFit.cover,)
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () async{
                      final data = await _picker.pickImage(source: ImageSource.gallery);
                      if(data != null){
                        img = File(data.path);
                      }
                    },
                    child: const Icon(Icons.image,size: 50,),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Name"),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please,return input full name";
                }

                return null;
              },
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Gender",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                DropdownButton(
                  hint: Text(
                      "${gender == null || gender!.isEmpty ? "Gender" : gender}"),
                  items: const [
                    DropdownMenuItem(
                      value: "Man",
                      child: Text("Man"),
                    ),
                    DropdownMenuItem(
                      value: "Woman",
                      child: Text("Woman"),
                    ),
                    DropdownMenuItem(
                      value: "Other",
                      child: Text("Other"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your Birthday",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final data = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (data != null) {
                      setState(() {
                        birthday = data;
                      });
                    }
                  },
                  child: birthday == null
                      ? const Text(
                          "Not know",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "${birthday!.day}-${birthday!.month}-${birthday!.year}"),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              inputFormatters: [maskFormatter],
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Phone numbers",
                  prefixIcon: const Icon(Icons.phone)),
            ),
          ],
        ),
      ),
    );
  }
}
