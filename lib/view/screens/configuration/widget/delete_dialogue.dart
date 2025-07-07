// import 'package:flutter/material.dart';
//
// void _showDeleteDialog(String category, Map<String, dynamic> item,BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Delete ${item['name']}'),
//         content: Text(
//             'Are you sure you want to delete this item? This action cannot be undone.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//           ElecvatedButtonWidget(item: ,),
//         ],
//       );
//     },
//   );
// }
//
// class ElecvatedButtonWidget extends StatelessWidget {
//  final String category;
//  final Map<String, dynamic> item;
//   const ElecvatedButtonWidget({
//     super.key, required this.category, required this.item,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           permissionsData[category]!.remove(item);
//         });
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('${item['name']} deleted successfully'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       },
//       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//       child: Text('Delete', style: TextStyle(color: Colors.white)),
//     );
//   }
// }
