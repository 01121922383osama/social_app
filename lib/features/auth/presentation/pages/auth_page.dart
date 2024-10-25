import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/Toggle/toggle.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<AuthToggle, int>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 80),
                    CupertinoSlidingSegmentedControl(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.all(10),
                      thumbColor: Colors.white,
                      groupValue: state,
                      children: const {
                        0: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black),
                        ),
                        1: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.black),
                        ),
                      },
                      onValueChanged: (value) {
                        context.read<AuthToggle>().toggle(value!);
                      },
                    ),
                    state == 0 ? const SignInPage() : const SignUpPage(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
