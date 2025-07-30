import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/officers_controller/round_robin_controller.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_toast.dart';

class OfficersDeleteDialogue extends StatelessWidget {
  final List<String> officerIds;
  final String item;
  final String roundrobinId;

  const OfficersDeleteDialogue({
    super.key,
    required this.officerIds,
    required this.item,
    required this.roundrobinId,
  });

  @override
  Widget build(BuildContext context) {
    final roundRobinController = Get.find<RoundRobinController>();

    return AlertDialog(
      title: const CustomText(text: 'Are you sure ?'),
      content: CustomText(text: 'You want to delete this officer $item?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // closes dialog
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            bool result =
                await roundRobinController.removeOfficersFromRoundRobin(
              roundRobinId: roundrobinId,
              officerIds: officerIds,
            );
            if (result) {
              CustomToast.showToast(
                context: context,
                message: 'Deleted successfully!',
              );
            } else {
              CustomToast.showToast(
                context: context,
                message: roundRobinController.error.value ??
                    'Failed to delete officers',
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const CustomText(
            text: 'Delete',
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}


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