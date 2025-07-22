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

import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/campaign/campaign_provider.dart';
import 'package:overseas_front_end/model/app_configs/config_model.dart';
import 'package:provider/provider.dart';

import '../../../../controller/config/config_provider.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_toast.dart';

class DeleteDialogue extends StatelessWidget {
  const DeleteDialogue({super.key, required this.id, required this.name});
  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(text: 'Delete ${name}'),
      content: CustomText(
          text:
              'Are you sure you want to delete this item? This action cannot be undone.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        Consumer<ConfigProvider>(
          builder: (context, value, child) => ElevatedButton(
            onPressed: () {
              Provider.of<CampaignProvider>(context, listen: false)
                  .deleteCampaign(context, id);
              // value.removeItem(category, item);
              // setState(() {
              //   value.permissionsData[category]!.remove(item);
              // });
              Navigator.of(context).pop();
              CustomToast.showToast(
                  context: context, message: '${name} deleted successfully');
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text('${name} deleted successfully'),
              //     backgroundColor: Colors.red,
              //   ),
              // );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: CustomText(text: 'Delete', color: Colors.white),
          ),
        ),
      ],
    );
  }
}
