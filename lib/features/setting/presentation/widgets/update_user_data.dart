import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/extension/navgator.dart';
import 'package:social_app/core/widgets/custom_button.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/setting/presentation/cubit/UpdateUser/update_user_setting_cubit.dart';
import 'package:social_app/features/setting/presentation/cubit/UploadeImage/ulpoade_image_cubit.dart';
import 'package:social_app/features/setting/presentation/cubit/setting_cubit.dart';

class UpdateUserData extends StatefulWidget {
  final UserModel user;
  const UpdateUserData({super.key, required this.user});

  @override
  State<UpdateUserData> createState() => _UpdateUserDataState();
}

class _UpdateUserDataState extends State<UpdateUserData> {
  TextEditingController? _nameConroller;
  XFile? image;
  String? _imageUrl;
  @override
  void initState() {
    super.initState();
    _nameConroller = TextEditingController(text: widget.user.name);
  }

  void pickImage({ImageSource source = ImageSource.gallery}) {
    ImagePicker().pickImage(source: source).then((value) {
      setState(() {
        image = value;
      });
    });
  }

  @override
  void dispose() {
    _nameConroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User Data'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: image == null
                        ? NetworkImage(widget.user.photoUrl!)
                        : FileImage(File(image!.path)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Choose Image'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CupertinoDialogAction(
                                      child: const Text('Camera'),
                                      onPressed: () {
                                        pickImage(source: ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: const Text('Gallery'),
                                      onPressed: () {
                                        pickImage();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _nameConroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              CustomButtonWidget(
                color: Colors.indigoAccent.shade700,
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (image != null) {
                    final imageUrl =
                        await context.read<UlpoadeImageCubit>().ulpoadImage(
                              userId: widget.user.email!,
                              file: File(image!.path),
                              path: 'user_image',
                            );
                    setState(() {
                      _imageUrl = imageUrl;
                    });
                  }
                  if (context.mounted) {
                    context
                        .read<UpdateUserSettingCubit>()
                        .updateUserData(
                          user: UserModel(
                            userId: widget.user.userId,
                            name: _nameConroller!.text.trim(),
                            email: widget.user.email,
                            photoUrl: _imageUrl ?? widget.user.photoUrl,
                          ),
                        )
                        .then((value) {
                      if (context.mounted) {
                        context.read<SettingCubit>().getUserData();
                        context.pop();
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
