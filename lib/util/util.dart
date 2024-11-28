import 'package:flutter/material.dart';

class CostumText extends StatelessWidget {
  final String data;
  final Color color;
  final double size;
  final TextAlign? align;

  const CostumText({
    super.key,
    required this.data,
    this.color = Colors.black,
    this.size = 16,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: "Gotham-regular",
        fontSize: size,
        color: color,
        overflow: TextOverflow.clip,
      ),
      textAlign: align ?? TextAlign.start,
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Color overlay;
  final Color color;
  final double radius;
  final double width;
  final double height;
  final double elevation;
  final Widget child;

  const MyButton({
    super.key,
    required this.onTap,
    this.overlay = const Color.fromARGB(73, 255, 235, 59),
    this.color = const Color.fromARGB(255, 102, 102, 102),
    this.height = 100,
    this.width = 100,
    this.radius = 12,
    this.elevation = 3,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(overlay),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius))),
        fixedSize: WidgetStatePropertyAll(Size(width, height)),
        padding: WidgetStatePropertyAll(const EdgeInsets.fromLTRB(0, 0, 0, 0)),
        backgroundColor: WidgetStatePropertyAll(color),
        elevation: WidgetStatePropertyAll(elevation),
      ),
      child: child,
    );
  }
}
