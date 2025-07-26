// // Minimal Client Management Tab
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/res/style/colors/colors.dart';
// import 'package:provider/provider.dart';

// import '../../../../controller/project/project_provider_controller.dart';
// import '../../../widgets/widgets.dart';

// class ClientManagementTab extends StatefulWidget {
//   const ClientManagementTab({super.key});

//   @override
//   State<ClientManagementTab> createState() => _ClientManagementTabState();
// }

// class _ClientManagementTabState extends State<ClientManagementTab> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _vacancyController = TextEditingController();
//   final TextEditingController _commissionController = TextEditingController();

//   List<Map<String, dynamic>> _selectedClients = [
//     {
//       'id': '1',
//       'name': 'Tech Solutions Inc.',
//       'email': 'contact@techsolutions.com',
//       'vacancy': '5',
//       'commission': '15.0',
//     },
//     {
//       'id': '2',
//       'name': 'Digital Marketing Pro',
//       'email': 'info@digitalmarketing.com',
//       'vacancy': '3',
//       'commission': '12.5',
//     },
//   ];

//   // List<Map<String, dynamic>> _allClients = [
//   //   {
//   //     'id': '3',
//   //     'name': 'Global Enterprises',
//   //     'email': 'hello@globalent.com',
//   //   },
//   //   {
//   //     'id': '4',
//   //     'name': 'StartUp Ventures',
//   //     'email': 'contact@startup.com',
//   //   },
//   //   {
//   //     'id': '5',
//   //     'name': 'Creative Agency',
//   //     'email': 'info@creative.com',
//   //   },
//   // ];

//   // List<Map<String, dynamic>> _filteredClients = [];

//   @override
//   void initState() {
//     super.initState();
//     // _filteredClients = List.from(_allClients);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Header
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: const BoxDecoration(
//             gradient: AppColors.buttonGraidentColour,
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.people, color: Colors.white),
//               const SizedBox(width: 8),
//               const CustomText(
//                 text: 'Client Management',
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//               const Spacer(),
//               ElevatedButton.icon(
//                 onPressed: _showAddClientDialog,
//                 icon: const Icon(Icons.add),
//                 label: const CustomText(text: 'Add Client'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.blue.shade600,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Client List
//         Consumer<ProjectProvider>(
//           builder: (context, value, child) => Expanded(
//             child: value.clients.isEmpty
//                 ? const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.people_outline,
//                             size: 64, color: Colors.grey),
//                         SizedBox(height: 16),
//                         CustomText(text: 'No clients assigned'),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: value.clients.length,
//                     itemBuilder: (context, index) {
//                       final client = value.clients[index];
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: AppColors.textGrayColour,
//                             child: CustomText(text: client.name?[0] ?? ''),
//                           ),
//                           title: CustomText(
//                             text: client.name ?? '',
//                             fontSize: 15,
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CustomText(text: client.email ?? ''),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Chip(
//                                     label: CustomText(
//                                         text:
//                                             'Created at: ${DateFormat("dd/MM/yyyy").format(DateTime.tryParse(client.createdAt ?? '') ?? DateTime.now())}'),
//                                     backgroundColor: Colors.green.shade300,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Chip(
//                                     label: CustomText(
//                                         text: 'Country: ${client.country}'),
//                                     backgroundColor: Colors.orange.shade300,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           trailing:
//                               Row(mainAxisSize: MainAxisSize.min, children: [
//                             IconButton(
//                               icon: const Icon(Icons.edit, size: 20),
//                               tooltip: 'Edit',
//                               onPressed: () =>
//                                   _showEditClientDialog(client.toJson()),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete,
//                                   color: Colors.red, size: 20),
//                               tooltip: 'Remove',
//                               onPressed: () async {
//                                 final confirmed = await showDialog<bool>(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     title: Row(
//                                       children: [
//                                         Icon(Icons.warning_amber_rounded,
//                                             color: Colors.red.shade400,
//                                             size: 24),
//                                         const SizedBox(width: 8),
//                                         const Text('Remove Client'),
//                                       ],
//                                     ),
//                                     content: Text(
//                                       'Remove "${client.name}" from this project?',
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () =>
//                                             Navigator.pop(context, false),
//                                         child: const Text('Cancel'),
//                                       ),
//                                       ElevatedButton.icon(
//                                         onPressed: () =>
//                                             Navigator.pop(context, true),
//                                         icon: const Icon(Icons.delete,
//                                             color: Colors.white),
//                                         label: const Text('Remove'),
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.red.shade600,
//                                           foregroundColor: Colors.white,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 20, vertical: 12),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                                 // if (confirmed == true) {
//                                 //   _removeClient(client.sId ?? '');
//                                 // }
//                               },
//                             ),
//                           ]),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _filterClients(String query) {
//     // setState(() {
//     //   _filteredClients = _allClients
//     //       .where((client) =>
//     //           client['name'].toLowerCase().contains(query.toLowerCase()) ||
//     //           client['email'].toLowerCase().contains(query.toLowerCase()))
//     //       .where((client) => !_selectedClients
//     //           .any((selected) => selected['id'] == client['id']))
//     //       .toList();
//     // });
//   }

//   void _showAddClientDialog() {
//     _searchController.clear();
//     // setState(() {
//     //   _filteredClients = _allClients
//     //       .where((client) => !_selectedClients
//     //           .any((selected) => selected['id'] == client['id']))
//     //       .toList();
//     // });

//     showDialog(
//       context: context,
//       builder: (context) => Consumer<ProjectProvider>(
//         builder: (context, value, child) {
//           value.filteredClients = value.clients
//               .where((client) => !_selectedClients
//                   .any((selected) => selected['id'] == client.sId))
//               .toList();
//           return StatefulBuilder(
//             builder: (context, setDialogState) => Dialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   children: [
//                     // Header
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: const BoxDecoration(
//                         gradient: AppColors.buttonGraidentColour,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(16),
//                           topRight: Radius.circular(16),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.person_add,
//                               color: Colors.white, size: 24),
//                           const SizedBox(width: 12),
//                           const CustomText(
//                             text: 'Add Clients to Project',
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                           const Spacer(),
//                           IconButton(
//                             onPressed: () => Navigator.pop(context),
//                             icon: const Icon(Icons.close, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Search Section
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       color: Colors.grey.shade50,
//                       child: TextField(
//                         controller: _searchController,
//                         decoration: InputDecoration(
//                           hintText: 'Search clients by name or email...',
//                           prefixIcon:
//                               const Icon(Icons.search, color: Colors.grey),
//                           suffixIcon: _searchController.text.isNotEmpty
//                               ? IconButton(
//                                   icon: const Icon(Icons.clear),
//                                   onPressed: () {
//                                     _searchController.clear();
//                                     setDialogState(() {
//                                       value.filteredClients = value.clients;
//                                     });
//                                   },
//                                 )
//                               : null,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 12),
//                         ),
//                         onChanged: (query) {
//                           setDialogState(() {
//                             if (query.isEmpty) {
//                               value.filteredClients = value.clients;
//                             }
//                             print(value.clients.length);
//                             value.filteredClients = value.clients
//                                 .where((client) =>
//                                     (client.name
//                                             ?.toLowerCase()
//                                             .contains(query.toLowerCase()) ??
//                                         false) ||
//                                     (client.email
//                                             ?.toLowerCase()
//                                             .contains(query.toLowerCase()) ??
//                                         false))
//                                 .toList();
//                           });
//                         },
//                       ),
//                     ),

//                     // Results Count
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Row(
//                         children: [
//                           Icon(Icons.info_outline,
//                               size: 16, color: Colors.grey.shade600),
//                           const SizedBox(width: 8),
//                           CustomText(
//                             text:
//                                 '${value.filteredClients.length} clients available',
//                             color: Colors.grey.shade600,
//                             fontSize: 14,
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Client List
//                     Expanded(
//                       child: value.filteredClients.isEmpty
//                           ? Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.search_off,
//                                     size: 64,
//                                     color: Colors.grey.shade400,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   CustomText(
//                                     text: _searchController.text.isEmpty
//                                         ? 'No clients available'
//                                         : 'No clients found matching "${_searchController.text}"',
//                                     fontSize: 16,
//                                     color: Colors.grey.shade600,
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : ListView.separated(
//                               padding: const EdgeInsets.all(16),
//                               itemCount: value.filteredClients.length,
//                               separatorBuilder: (context, index) =>
//                                   const SizedBox(height: 8),
//                               itemBuilder: (context, index) {
//                                 final client = value.filteredClients[index];
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                     border:
//                                         Border.all(color: Colors.grey.shade200),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.1),
//                                         spreadRadius: 1,
//                                         blurRadius: 4,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: ListTile(
//                                     contentPadding: const EdgeInsets.all(16),
//                                     leading: CircleAvatar(
//                                       backgroundColor: Colors.blue.shade100,
//                                       child: CustomText(
//                                         text:
//                                             client.name?[0].toUpperCase() ?? '',
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.blue.shade700,
//                                       ),
//                                     ),
//                                     title: CustomText(
//                                       text: client.name ?? '',
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                     ),
//                                     subtitle: CustomText(
//                                       text: client.email ?? '',
//                                       color: Colors.grey.shade600,
//                                       fontSize: 14,
//                                     ),
//                                     trailing: Container(
//                                       decoration: BoxDecoration(
//                                         gradient: AppColors.greenGradient,
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: ElevatedButton.icon(
//                                         onPressed: () =>
//                                             _showClientDetailsDialog(
//                                                 client.toJson()),
//                                         icon: const Icon(Icons.add, size: 18),
//                                         label: const CustomText(
//                                           text: 'Add',
//                                           color: Colors.white,
//                                         ),
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.transparent,
//                                           foregroundColor: Colors.white,
//                                           shadowColor: Colors.transparent,
//                                           elevation: 0,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _showClientDetailsDialog(Map<String, dynamic> client) {
//     _vacancyController.clear();
//     _commissionController.clear();

//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Container(
//           width: 450,
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white,
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Header with client info
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 25,
//                       backgroundColor:
//                           AppColors.orangeSecondaryColor.withOpacity(
//                         1.0,
//                       ),
//                       child: CustomText(
//                         text: client['name'][0].toUpperCase(),
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.orangeSecondaryColor,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomText(
//                             text: client['name'],
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           CustomText(
//                             text: client['email'],
//                             fontSize: 14,
//                             color: Colors.grey.shade600,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),

//                 // Form fields
//                 CustomTextFormField(
//                   controller: _vacancyController,
//                   label: 'Number of Vacancies',
//                   isRequired: true,
//                   keyboardType: TextInputType.number,
//                 ),

//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _commissionController,
//                   label: 'Commission',
//                   isRequired: true,
//                   keyboardType: TextInputType.number,
//                 ),

//                 const SizedBox(height: 32),

//                 // Action buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomActionButton(
//                         text: 'Cancel',
//                         icon: Icons.close,
//                         onPressed: () => Navigator.pop(context),
//                         isFilled: false,
//                         textColor: Colors.blue.shade600,
//                         borderColor: Colors.blue.shade100,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomActionButton(
//                         text: 'Add Client',
//                         icon: Icons.check,
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             _addClient(client);
//                             Navigator.pop(context);
//                             Navigator.pop(context);
//                           }
//                         },
//                         isFilled: true,
//                         gradient: AppColors.orangeGradient,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showEditClientDialog(Map<String, dynamic> client) {
//     _vacancyController.text = client['vacancy'];
//     _commissionController.text = client['commission'];

//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Container(
//           width: 450,
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white,
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Header with client info
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Colors.orange.shade100,
//                       child: CustomText(
//                         text: client['name'][0].toUpperCase(),
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange.shade700,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.edit,
//                                   size: 18, color: Colors.orange),
//                               const SizedBox(width: 8),
//                               CustomText(
//                                 text: 'Edit ${client['name']}',
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ],
//                           ),
//                           CustomText(
//                             text: client['email'],
//                             fontSize: 14,
//                             color: Colors.grey.shade600,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),

//                 // Form fields
//                 TextFormField(
//                   controller: _vacancyController,
//                   decoration: InputDecoration(
//                     labelText: 'Number of Vacancies',
//                     prefixIcon: const Icon(Icons.work_outline),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey.shade50,
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value?.isEmpty == true) return 'Required';
//                     if (int.tryParse(value!) == null)
//                       return 'Enter valid number';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 TextFormField(
//                   controller: _commissionController,
//                   decoration: InputDecoration(
//                     labelText: 'Commission Percentage',
//                     prefixIcon: const Icon(Icons.percent),
//                     suffix: const Text('%'),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey.shade50,
//                   ),
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   validator: (value) {
//                     if (value?.isEmpty == true) return 'Required';
//                     final commission = double.tryParse(value!);
//                     if (commission == null) return 'Enter valid number';
//                     if (commission < 0 || commission > 100)
//                       return 'Must be between 0-100';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 32),

//                 // Action buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Cancel'),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             _editClient(client['id']);
//                             Navigator.pop(context);
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange.shade600,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Update Client'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _addClient(Map<String, dynamic> client) {
//     setState(() {
//       _selectedClients.add({
//         ...client,
//         'vacancy': _vacancyController.text,
//         'commission': _commissionController.text,
//       });
//       // _allClients.removeWhere((c) => c['id'] == client['id']);
//     });
//   }

//   void _editClient(String clientId) {
//     setState(() {
//       final index = _selectedClients.indexWhere((c) => c['sid'] == clientId);
//       if (index != -1) {
//         _selectedClients[index]['vacancy'] = _vacancyController.text;
//         _selectedClients[index]['commission'] = _commissionController.text;
//       }
//     });
//   }

//   void _removeClient(String clientId) {
//     setState(() {
//       final client = _selectedClients.firstWhere((c) => c['sid'] == clientId);
//       _selectedClients.removeWhere((c) => c['sid'] == clientId);
//       // _allClients.add({
//       //   'id': client['id'],
//       //   'name': client['name'],
//       //   'email': client['email'],
//       // });
//     });
//   }
// }
