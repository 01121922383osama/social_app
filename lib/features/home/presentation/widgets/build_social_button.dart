import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildSocialButton extends StatelessWidget {
  final IconData iconData;
  final void Function()? onPressed;
  final String text;
  const BuildSocialButton({
    super.key,
    this.iconData = FontAwesomeIcons.heart,
    this.onPressed,
    this.text = 'Like',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(iconData),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
