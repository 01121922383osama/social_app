import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubit/trigger/trigger_cubit.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../setting/presentation/pages/setting_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TriggerCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _pages[state],
          bottomNavigationBar: NavigationBar(
            elevation: 0,
            selectedIndex: state,
            onDestinationSelected: (value) {
              context.read<TriggerCubit>().trigger(page: value);
            },
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            animationDuration: const Duration(milliseconds: 500),
            destinations: const [
              NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.house),
                label: 'Home',
              ),
              NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.solidMessage),
                label: 'Chat',
              ),
              NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.userGear),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

List<Widget> _pages = [
  const HomePage(),
  const ChatPage(),
  const SettingPage(),
];
