import 'package:flutter/material.dart';
import 'package:social_app/features/auth/presentation/pages/for_get_passwrod_page.dart';

import '../../core/anim/to_left.dart';
import '../../features/app/presentation/pages/app_page.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/setting/presentation/pages/setting_page.dart';
import '../../features/splash/splash_page.dart';
import 'name_routes.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NameRoutes.splash:
        return ToLeft(child: const SplashPage());
      case NameRoutes.app:
        return ToLeft(child: const AppPage());
      case NameRoutes.auth:
        return ToLeft(child: const AuthPage());
      case NameRoutes.home:
        return ToLeft(child: const HomePage());
      case NameRoutes.chat:
        return ToLeft(child: const ChatPage());
      case NameRoutes.setting:
        return ToLeft(child: const SettingPage());
      case NameRoutes.forGetPasswrod:
        return ToLeft(child: const ForGetPasswrodPage());
      default:
        return onUnknownRoute(settings)!;
    }
  }

  static Route? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Unknown Route'),
          ),
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
