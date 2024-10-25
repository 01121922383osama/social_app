import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final BorderSide borderSide;
  final double height;
  final double width;
  final Color color;
  const CustomButtonWidget({
    super.key,
    this.onPressed,
    required this.child,
    this.borderSide = BorderSide.none,
    this.height = 60,
    this.width = 250,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: AlignmentDirectional.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: Size(width, height),
        animationDuration: const Duration(seconds: 1),
        overlayColor: Colors.indigoAccent.withOpacity(0.5),
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
