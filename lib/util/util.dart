import 'package:flutter/material.dart';

class CostumText extends StatelessWidget {
  final String data;
  final Color color;
  final double size;

  const CostumText({
    super.key,
    required this.data,
    this.color = Colors.black,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontFamily: "Gotham-regular",
          fontSize: size,
          color: color,
          overflow: TextOverflow.clip),
    );
  }
}
