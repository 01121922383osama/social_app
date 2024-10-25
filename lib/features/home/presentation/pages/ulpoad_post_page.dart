import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/extension/navgator.dart';
import 'package:social_app/core/widgets/custom_button.dart';
import 'package:social_app/core/widgets/custom_showtoast.dart';
import 'package:social_app/core/widgets/custom_textfield.dart';
import 'package:social_app/core/widgets/show_progress.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/home/data/models/post.dart';
import 'package:social_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/features/setting/presentation/cubit/UploadeImage/ulpoade_image_cubit.dart';
import 'package:uuid/uuid.dart';

class UlpoadPostPage extends StatefulWidget {
  final UserModel userModel;
  const UlpoadPostPage({super.key, required this.userModel});

  @override
  State<UlpoadPostPage> createState() => _UlpoadPostPageState();
}

class _UlpoadPostPageState extends State<UlpoadPostPage> {
  final _descriptionController = TextEditingController();
  XFile? _imagePost;
  void pickImage({ImageSource source = ImageSource.gallery}) {
    ImagePicker().pickImage(source: source).then((value) {
      setState(() {
        _imagePost = value;
      });
    });
  }

  void chooeImage() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Post'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.userModel.photoUrl!,
                    ),
                    radius: 35,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.userModel.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextfield(
                  controller: _descriptionController,
                  hintText: 'Description',
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Container(
                  width: context.width,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                  ),
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(context.width * 0.5, 50),
                      animationDuration: const Duration(seconds: 1),
                      backgroundColor: _imagePost == null
                          ? null
                          : Colors.green.withOpacity(0.5),
                    ),
                    onPressed: chooeImage,
                    child: const FaIcon(
                      FontAwesomeIcons.image,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
                  if (state is HomeLoading) {
                    ShowProgress.showLoadingOverlay(context);
                  }
                  if (state is HomeSuccess) {
                    ShowProgress.removeOverlay();
                    _descriptionController.clear();
                    _imagePost = null;
                    context.pop();
                    customShowtoast(
                      context,
                      message: 'Post Successfully',
                      color: Colors.green,
                    );
                  }
                  if (state is HomeFailure) {
                    ShowProgress.removeOverlay();
                    customShowtoast(context, message: state.errorMessage);
                  }
                }, builder: (context, state) {
                  return CustomButtonWidget(
                    color: Colors.white.withOpacity(0.2),
                    onPressed: () async {
                      final imageUrl = await context
                          .read<UlpoadeImageCubit>()
                          .ulpoadImage(
                              userId: const Uuid().v4(),
                              file: File(_imagePost!.path),
                              path: 'posts_image');
                      final post = PostModel(
                        id: const Uuid().v4(),
                        name: widget.userModel.name,
                        userImage: widget.userModel.photoUrl!,
                        postDate: DateTime.now(),
                        description: _descriptionController.text.trim(),
                        imagePost: imageUrl,
                        likes: <num>[],
                      );
                      if (_imagePost != null) {
                        if (context.mounted) {
                          await context
                              .read<HomeCubit>()
                              .uploadPost(post: post);
                        }
                      }
                    },
                    child: state is HomeLoading
                        ? const CircularProgressIndicator.adaptive()
                        : const Text(
                            'Post',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
