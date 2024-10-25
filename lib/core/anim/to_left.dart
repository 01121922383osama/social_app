import 'package:flutter/material.dart';

class ToLeft extends PageRouteBuilder {
  final Widget child;

  ToLeft({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
