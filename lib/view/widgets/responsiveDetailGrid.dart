// // import 'package:flutter/material.dart';
// //
// // class ResponsiveDetailGrid extends StatelessWidget {
// //   final Map<String, String> items;
// //   final double breakpoint;
// //
// //   const ResponsiveDetailGrid({
// //     super.key,
// //     required this.items,
// //     this.breakpoint = 1000, // default mobile/tablet breakpoint
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         final isMobile = constraints.maxWidth < breakpoint;
// //         final crossAxisCount = isMobile ? 1 : 2;
// //
// //         return GridView.builder(
// //           shrinkWrap: true,
// //           physics: const NeverScrollableScrollPhysics(),
// //           itemCount: items.length,
// //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //             crossAxisCount: crossAxisCount,
// //             childAspectRatio: isMobile ? 1 : 2,
// //             // crossAxisSpacing: 5,
// //             // mainAxisSpacing: 5,
// //           ),
// //           itemBuilder: (context, index) {
// //             final key = items.keys.elementAt(index);
// //             final value = items[key]!;
// //
// //             return Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 SizedBox(
// //                   width: 100,
// //                   child: Text(
// //                     key,
// //                     style: TextStyle(color: Colors.grey[700]),
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: Text(
// //                     value,
// //                     style: const TextStyle(fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// class ResponsiveDetailGrid extends StatelessWidget {
//   final Map<String, String> items;
//   final double breakpoint;
//
//   const ResponsiveDetailGrid({
//     super.key,
//     required this.items,
//     this.breakpoint = 1000,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final isMobile = constraints.maxWidth < breakpoint;
//         final crossAxisCount = isMobile ? 1 : 2;
//
//         return GridView.builder(
//         padding: EdgeInsets.zero,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: items.length,
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 300, // tiles adjust size based on this
//             mainAxisSpacing: 16,
//              crossAxisSpacing: 16,
//             childAspectRatio: isMobile ? 5 : 5,
//
//           ),
//           itemBuilder: (context, index) {
//             final key = items.keys.elementAt(index);
//             final value = items[key]!;
//
//
//             return GridTile(
//               // height: 100,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 100,
//                     child: Text(
//                       key,
//                       style: TextStyle(color: Colors.grey[700]),
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       value,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

class ResponsiveInfoGrid extends StatelessWidget {
  final Map<String, String> data;
  final double breakpoint;
  final double labelWidth;

  const ResponsiveInfoGrid({
    super.key,
    required this.data,
    this.breakpoint = 800,
    this.labelWidth = 100,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < breakpoint;
        final double spacing = 16;
        final double runSpacing = 12;
        final double totalWidth = constraints.maxWidth;
        final double itemWidth = isMobile ? totalWidth : (totalWidth - spacing) / 2;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: spacing,
            runSpacing: runSpacing,
            children: data.entries.map((entry) {
              return SizedBox(
                width: itemWidth,
                child: _InfoRow(
                  label: entry.key,
                  value: entry.value,
                  labelWidth: labelWidth,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final double labelWidth;

  const _InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: labelWidth,
          child: Text(
            "$label :",
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
