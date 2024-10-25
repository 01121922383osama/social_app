import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

customShowtoast(BuildContext context,
    {required String message, Color color = Colors.black87}) {
  showToast(
    message,
    context: context,
    backgroundColor: color,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.bottom,
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}
