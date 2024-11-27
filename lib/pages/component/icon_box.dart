import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData iconData;
  const IconBox({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 255, 254, 250),
      ),
      height: 70,
      width: 70,
      child: Center(
        child: Icon(
          iconData,
          color: const Color.fromARGB(255, 48, 48, 48),
          size: 35,
        ),
      ),
    );
  }
}
