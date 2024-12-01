import 'package:flutter/material.dart';

import '../../util/util.dart';

class DetailDescription extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String attribute;
  final String value;
  const DetailDescription({
    super.key,
    required this.attribute,
    required this.value,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Flexible(
            child: CostumText(
              data: attribute,
              color: const Color.fromARGB(255, 99, 99, 99),
            ),
          ),
          Flexible(
            child: CostumText(
              data: value,
              color: const Color.fromARGB(255, 37, 37, 37),
              align: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
