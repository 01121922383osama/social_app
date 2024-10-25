import 'package:flutter/material.dart';

class BuildDescriptionWidget extends StatelessWidget {
  final String description;
  const BuildDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(15),
      child: Text(
        description,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
