import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final int columns;
  final List<Widget> children;
  final WrapAlignment alignment;

  const ResponsiveGrid({
    super.key,
    required this.columns,
    required this.children,
    this.alignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    if (columns == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
            .map((child) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: child,
                ))
            .toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (16 * (columns - 1))) / columns;

        return Wrap(
          alignment: alignment,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 16,
          runSpacing: 20,
          children: children
              .map((child) => SizedBox(
                    width: itemWidth,
                    child: child,
                  ))
              .toList(),
        );
      },
    );
  }
}
