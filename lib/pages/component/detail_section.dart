import 'package:flutter/material.dart';

class DetailSection extends StatelessWidget {
  final String attributeName;
  final String attributeValue;
  const DetailSection({
    super.key,
    required this.attributeName,
    required this.attributeValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            attributeName,
            style: const TextStyle(
              fontFamily: "Gotham-regular",
              fontSize: 16,
            ),
          ),
          Text(
            attributeValue,
            style: const TextStyle(
              fontFamily: "Gotham-regular",
              fontSize: 16,
            ),
          ),
          // Icon(
          //   Icons.history,
          //   size: 30,
          //   color:
          //       const Color.fromARGB(255, 102, 102, 102),
          // )
        ],
      ),
    );
  }
}
