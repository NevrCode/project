import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData iconData;
  final Color border;
  final Color bg;
  final Color icon;
  const IconBox({
    super.key,
    required this.iconData,
    this.border = const Color.fromARGB(255, 255, 255, 255),
    this.bg = Colors.white,
    this.icon = const Color.fromARGB(255, 238, 204, 11),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(12),
        color: bg,
      ),
      height: 70,
      width: 70,
      child: Center(
        child: Icon(
          iconData,
          color: icon,
          size: 35,
        ),
      ),
    );
  }
}
