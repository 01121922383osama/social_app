import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/config/Routes/name_routes.dart';
import 'package:social_app/core/extension/navgator.dart';
import 'package:social_app/features/setting/presentation/cubit/setting_cubit.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_showtoast.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../cubit/Toggle/toggle.dart';
import '../cubit/auth_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.pushNamedAndRemoveUntil(pageRoute: NameRoutes.app);
            }
            if (state is AuthFailure) {
              customShowtoast(
                context,
                message: state.errorMessage,
                color: Colors.red,
              );
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
                  controller: context.read<AuthCubit>().emailSignIn,
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
                      controller: context.read<AuthCubit>().passwordSignIn,
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
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text('For Forget Password?'),
                    onPressed: () {
                      context.pushNamed(pageRoute: NameRoutes.forGetPasswrod);
                    },
                  ),
                ),
                const SizedBox(height: 15),
                CustomButtonWidget(
                  color: Colors.blue.withOpacity(0.5),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {
                    if (context.read<AuthCubit>().emailSignIn.text.isEmpty) {
                      customShowtoast(
                        context,
                        message: 'Please Enter Email',
                        color: Colors.red,
                      );
                    } else if (context
                        .read<AuthCubit>()
                        .passwordSignIn
                        .text
                        .isEmpty) {
                      customShowtoast(
                        context,
                        message: 'Please Enter Passwrod',
                        color: Colors.red,
                      );
                    } else {
                      context
                          .read<AuthCubit>()
                          .login(
                            email: context.read<AuthCubit>().emailSignIn.text,
                            password:
                                context.read<AuthCubit>().passwordSignIn.text,
                          )
                          .then((value) {
                        if (context.mounted) {
                          context.read<SettingCubit>().getUserData();
                          customShowtoast(
                            context,
                            message: 'Login Success',
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
                const SizedBox(height: 25),
                CustomButtonWidget(
                  color: Colors.blue.withOpacity(0.5),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Google',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 5),
                      FaIcon(
                        FontAwesomeIcons.google,
                        size: 35,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {
                    context.read<AuthCubit>().loginWithGoogle();
                    if (context.mounted) {
                      customShowtoast(
                        context,
                        message: 'Login Success',
                        color: Colors.green,
                      );
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
