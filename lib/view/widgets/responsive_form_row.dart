import 'package:flutter/material.dart';

class ResponsiveFormRow extends StatelessWidget {
  final List<Widget> fields;
  final double breakpoint;

  const ResponsiveFormRow({
    Key? key,
    required this.fields,
    this.breakpoint = 600, // You can adjust this as needed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 1000;

    if (isSmallScreen) {
      return Column(
        children: fields.map((field) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: field,
          );
        }).toList(),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map((field) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 16),
              child: field,
            ),
          );
        }).toList(),
      );
    }
  }
}
