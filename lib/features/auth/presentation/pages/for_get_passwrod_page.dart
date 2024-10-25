import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/widgets/custom_button.dart';
import 'package:social_app/core/widgets/custom_showtoast.dart';
import 'package:social_app/core/widgets/custom_textfield.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_cubit.dart';

class ForGetPasswrodPage extends StatelessWidget {
  const ForGetPasswrodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextfield(
                    hintText: 'Email',
                    controller: context.read<AuthCubit>().forgetEmail,
                  ),
                  const SizedBox(height: 25),
                  CustomButtonWidget(
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (context.read<AuthCubit>().forgetEmail.text.isEmpty) {
                        customShowtoast(
                          context,
                          message: 'Please enter your email',
                        );
                      } else {
                        context.read<AuthCubit>().forgetPassword(
                              email: context.read<AuthCubit>().forgetEmail.text,
                            );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
