// import 'package:flutter/material.dart';

// class BuildSection extends StatelessWidget {
//   final String? title;
//   final List<Widget> fields;
//   const BuildSection({super.key, this.title, required this.fields});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title ?? '',
//             style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87)),
//         const SizedBox(height: 12),
//         Wrap(
//           spacing: 16,
//           runSpacing: 16,
//           children: fields.map((field) {
//             return ConstrainedBox(
//               constraints: const BoxConstraints(
//                 minWidth: 200,
//                 maxWidth: 350,
//               ),
//               child: field,
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }
// }
