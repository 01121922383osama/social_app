import 'package:flutter/material.dart';
import '../anim/to_left.dart';

extension QueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
}

extension NavigatorToPage on BuildContext {
  void push({required Widget widget}) {
    Navigator.push(
      this,
      ToLeft(child: widget),
    );
  }

  void pushReplacement({required Widget widget}) {
    Navigator.pushReplacement(
      this,
      ToLeft(child: widget),
    );
  }

  void pushAndRemoveUntil({required Widget widget}) {
    Navigator.pushAndRemoveUntil(
      this,
      ToLeft(child: widget),
      (route) => false,
    );
  }

  void pop() {
    Navigator.pop(this);
  }

  void pushNamed({required String pageRoute}) {
    Navigator.pushNamed(this, pageRoute);
  }

  void pushReplacementNamed({required String pageRoute}) {
    Navigator.pushReplacementNamed(
      this,
      pageRoute,
    );
  }

  void pushNamedAndRemoveUntil({required String pageRoute}) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      pageRoute,
      (route) => false,
    );
  }
}
