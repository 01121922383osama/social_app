import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:social_app/features/setting/presentation/widgets/setting_details.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          if (state is SettingSuccess) {
            final userData = state.userModel;
            return SettingDetails(user: userData);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
