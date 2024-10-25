import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/Routes/name_routes.dart';
import '../../../../core/extension/navgator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_showtoast.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../cubit/Toggle/toggle.dart';
import '../cubit/auth_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              customShowtoast(context,
                  message: 'Register Successfully', color: Colors.green);
              context.pushNamedAndRemoveUntil(pageRoute: NameRoutes.app);
            }
            if (state is AuthFailure) {
              customShowtoast(context,
                  message: state.errorMessage, color: Colors.red);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Center(
                  child: FaIcon(
                    FontAwesomeIcons.facebook,
                    size: 70,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextfield(
                  hintText: 'Email',
                  controller: context.read<AuthCubit>().emailSignUp,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 25),
                BlocBuilder<AuthObsecureCubit, bool>(
                  builder: (context, obsecure) {
                    return CustomTextfield(
                      hintText: 'Password',
                      controller: context.read<AuthCubit>().passwordSignUp,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      obsecure: obsecure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<AuthObsecureCubit>().change();
                        },
                        icon: Icon(
                            obsecure ? Icons.visibility_off : Icons.visibility),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),
                BlocBuilder<AuthObsecureCubit, bool>(
                  builder: (context, obsecure) {
                    return CustomTextfield(
                      hintText: 'Re-Password',
                      controller: context.read<AuthCubit>().rePasswordSignUp,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      obsecure: obsecure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<AuthObsecureCubit>().change();
                        },
                        icon: Icon(
                            obsecure ? Icons.visibility_off : Icons.visibility),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),
                state is AuthLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButtonWidget(
                        color: Colors.blue.withOpacity(0.5),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          final pass = context.read<AuthCubit>().passwordSignUp;
                          final rePass =
                              context.read<AuthCubit>().rePasswordSignUp;
                          if (pass.text.trim() != rePass.text.trim()) {
                            customShowtoast(context,
                                message: 'Password Not Match',
                                color: Colors.red);
                          } else if (context
                              .read<AuthCubit>()
                              .emailSignUp
                              .text
                              .isEmpty) {
                            customShowtoast(
                              context,
                              message: 'Email is Empty',
                              color: Colors.red,
                            );
                          } else if (context
                              .read<AuthCubit>()
                              .passwordSignUp
                              .text
                              .trim()
                              .isEmpty) {
                            customShowtoast(
                              context,
                              message: 'Password is Empty',
                              color: Colors.red,
                            );
                          } else if (context
                              .read<AuthCubit>()
                              .rePasswordSignUp
                              .text
                              .trim()
                              .isEmpty) {
                            customShowtoast(
                              context,
                              message: 'Re-Password is Empty',
                              color: Colors.red,
                            );
                          } else {
                            context
                                .read<AuthCubit>()
                                .register(
                                  email: context
                                      .read<AuthCubit>()
                                      .emailSignUp
                                      .text,
                                  password: context
                                      .read<AuthCubit>()
                                      .passwordSignUp
                                      .text,
                                )
                                .then((value) {
                              if (context.mounted) {
                                customShowtoast(
                                  context,
                                  message: 'Register Success',
                                  color: Colors.green,
                                );
                                context.read<AuthCubit>().close();
                              }
                            }).onError((value, error) {
                              if (context.mounted) {
                                customShowtoast(
                                  context,
                                  message: value.toString(),
                                  color: Colors.red,
                                );
                              }
                            });
                          }
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
