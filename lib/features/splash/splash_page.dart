import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/Routes/name_routes.dart';
import '../../core/extension/navgator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        if (mounted) {
          context.pushNamedAndRemoveUntil(
            pageRoute: FirebaseAuth.instance.currentUser == null
                ? NameRoutes.auth
                : NameRoutes.app,
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Social App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          FaIcon(
            FontAwesomeIcons.squareFacebook,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(height: 10),
          Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ],
      ),
    );
  }
}
