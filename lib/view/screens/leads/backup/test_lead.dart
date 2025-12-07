// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../controller/lead/lead_controller.dart';
// import '../lead_page_for_erp.dart';

// class EnhancedLeadManagement extends StatefulWidget {
//   const EnhancedLeadManagement({super.key});

//   @override
//   State<EnhancedLeadManagement> createState() => _EnhancedLeadManagementState();
// }

// class _EnhancedLeadManagementState extends State<EnhancedLeadManagement> {
//   final leadController = Get.find<LeadController>();
//   final _searchController = TextEditingController();

//   String _selectedStatus = 'ALL';
//   bool _isGridView = false;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   List<Lead> get filteredLeads {
//     var leads = leadController.leads;

//     // Filter by status
//     // if (_selectedStatus != 'ALL') {
//     //   leads = leads.where((lead) => lead.status == _selectedStatus).toList();
//     // }

//     // // Filter by search
//     // if (_searchController.text.isNotEmpty) {
//     //   leads = leads.where((lead) =>
//     //     lead.fullName.toLowerCase().contains(_searchController.text.toLowerCase()) ||
//     //     lead.email.toLowerCase().contains(_searchController.text.toLowerCase()) ||
//     //     lead.phone.contains(_searchController.text)
//     //   ).toList();
//     // }

//     return leads;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFFF8FAFC),
//               Color(0xFFEFF6FF),
//               Color(0xFFF1F5F9),
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             _buildHeader(),
//             _buildSearchBar(),
//             _buildStatusChips(),
//             _buildStatsCards(),
//             Expanded(child: _buildLeadsList()),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => Get.dialog(AddEditLead(isEditMode: false)),
//         icon: Icon(Icons.add),
//         label: Text('Add Lead'),
//         backgroundColor: Color(0xFF6366F1),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(20, 48, 20, 20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF6366F1).withOpacity(0.3),
//             blurRadius: 15,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child:
//                 Icon(Icons.people_alt_rounded, color: Colors.white, size: 24),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Lead Management',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 2),
//                 Obx(() => Text(
//                       '${leadController.leads.length} Total Leads',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white.withOpacity(0.9),
//                       ),
//                     )),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: Icon(
//               _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
//               color: Colors.white,
//             ),
//             onPressed: () => setState(() => _isGridView = !_isGridView),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => setState(() {}),
//         decoration: InputDecoration(
//           hintText: 'Search leads by name, email or phone...',
//           prefixIcon: Icon(Icons.search, color: Color(0xFF6366F1)),
//           suffixIcon: _searchController.text.isNotEmpty
//               ? IconButton(
//                   icon: Icon(Icons.clear, color: Colors.grey),
//                   onPressed: () {
//                     _searchController.clear();
//                     setState(() {});
//                   },
//                 )
//               : null,
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusChips() {
//     final statuses = [
//       'ALL',
//       'NEW',
//       'CONTACTED',
//       'QUALIFIED',
//       'CONVERTED',
//       'LOST'
//     ];

//     return Container(
//       height: 50,
//       margin: EdgeInsets.symmetric(horizontal: 16),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: statuses.length,
//         itemBuilder: (context, index) {
//           final status = statuses[index];
//           final isSelected = _selectedStatus == status;

//           return GestureDetector(
//             onTap: () => setState(() => _selectedStatus = status),
//             child: Container(
//               margin: EdgeInsets.only(right: 8),
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               decoration: BoxDecoration(
//                 gradient: isSelected
//                     ? LinearGradient(
//                         colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)])
//                     : null,
//                 color: isSelected ? null : Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//                 boxShadow: [
//                   BoxShadow(
//                     color: isSelected
//                         ? Color(0xFF6366F1).withOpacity(0.3)
//                         : Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     _getStatusIcon(status),
//                     size: 16,
//                     color: isSelected ? Colors.white : Color(0xFF6366F1),
//                   ),
//                   SizedBox(width: 6),
//                   Text(
//                     status,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Color(0xFF6366F1),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildStatsCards() {
//     return Obx(() {
//       final leads = leadController.leads;
//       final newLeads = leads.where((l) => l.status == 'NEW').length;
//       final qualified = leads.where((l) => l.status == 'QUALIFIED').length;
//       final converted = leads.where((l) => l.status == 'CONVERTED').length;

//       return Container(
//         height: 100,
//         margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//         child: Row(
//           children: [
//             _buildStatCard('New', newLeads.toString(), Icons.fiber_new_rounded,
//                 LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)])),
//             SizedBox(width: 12),
//             _buildStatCard(
//                 'Qualified',
//                 qualified.toString(),
//                 Icons.verified_rounded,
//                 LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)])),
//             SizedBox(width: 12),
//             _buildStatCard(
//                 'Converted',
//                 converted.toString(),
//                 Icons.check_circle_rounded,
//                 LinearGradient(colors: [Color(0xFFEC4899), Color(0xFFD81B60)])),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildStatCard(
//       String title, String count, IconData icon, Gradient gradient) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           gradient: gradient,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Icon(icon, color: Colors.white.withOpacity(0.9), size: 24),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   count,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.white.withOpacity(0.9),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLeadsList() {
//     return Obx(() {
//       final leads = filteredLeads;

//       if (leads.isEmpty) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
//               SizedBox(height: 16),
//               Text(
//                 'No leads found',
//                 style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
//               ),
//             ],
//           ),
//         );
//       }

//       return _isGridView ? _buildGridView(leads) : _buildListView(leads);
//     });
//   }

//   Widget _buildListView(List<Lead> leads) {
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: leads.length,
//       itemBuilder: (context, index) {
//         final lead = leads[index];
//         return _buildLeadCard(lead);
//       },
//     );
//   }

//   Widget _buildGridView(List<Lead> leads) {
//     return GridView.builder(
//       padding: EdgeInsets.all(16),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: 0.85,
//       ),
//       itemCount: leads.length,
//       itemBuilder: (context, index) {
//         final lead = leads[index];
//         return _buildLeadGridCard(lead);
//       },
//     );
//   }

//   Widget _buildLeadCard(Lead lead) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () => Get.dialog(AddEditLead(lead: lead, isEditMode: true)),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Text(
//                           lead.fullName[0].toUpperCase(),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             lead.fullName,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF222B45),
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             lead.email,
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey.shade600,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                     _buildPriorityBadge(lead.priority),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Icon(Icons.phone, size: 14, color: Colors.grey.shade600),
//                     SizedBox(width: 4),
//                     Text(
//                       lead.phone,
//                       style:
//                           TextStyle(fontSize: 13, color: Colors.grey.shade700),
//                     ),
//                     SizedBox(width: 16),
//                     Icon(Icons.business, size: 14, color: Colors.grey.shade600),
//                     SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         lead.company ?? 'No Company',
//                         style: TextStyle(
//                             fontSize: 13, color: Colors.grey.shade700),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     _buildStatusBadge(lead.status),
//                     Spacer(),
//                     Text(
//                       _formatDate(lead.createdAt),
//                       style:
//                           TextStyle(fontSize: 12, color: Colors.grey.shade500),
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

//   Widget _buildLeadGridCard(Lead lead) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () => Get.dialog(AddEditLead(lead: lead, isEditMode: true)),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 45,
//                       height: 45,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Text(
//                           lead.fullName[0].toUpperCase(),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     _buildPriorityBadge(lead.priority),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   lead.fullName,
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF222B45),
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   lead.email,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Icon(Icons.phone, size: 12, color: Colors.grey.shade600),
//                     SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         lead.phone,
//                         style: TextStyle(
//                             fontSize: 11, color: Colors.grey.shade700),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 _buildStatusBadge(lead.status),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusBadge(String status) {
//     final colors = {
//       'NEW': Color(0xFF3B82F6),
//       'CONTACTED': Color(0xFFF59E0B),
//       'QUALIFIED': Color(0xFF10B981),
//       'CONVERTED': Color(0xFFEC4899),
//       'LOST': Color(0xFFEF4444),
//     };

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: (colors[status] ?? Colors.grey).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: (colors[status] ?? Colors.grey).withOpacity(0.3),
//         ),
//       ),
//       child: Text(
//         status,
//         style: TextStyle(
//           color: colors[status] ?? Colors.grey,
//           fontSize: 11,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _buildPriorityBadge(int priority) {
//     final colors = {
//       1: Colors.green,
//       2: Colors.blue,
//       3: Colors.orange,
//       4: Colors.red,
//       5: Colors.purple,
//     };

//     return Container(
//       padding: EdgeInsets.all(6),
//       decoration: BoxDecoration(
//         color: (colors[priority] ?? Colors.grey).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Icon(
//         Icons.flag,
//         size: 16,
//         color: colors[priority] ?? Colors.grey,
//       ),
//     );
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status) {
//       case 'ALL':
//         return Icons.all_inclusive;
//       case 'NEW':
//         return Icons.fiber_new_rounded;
//       case 'CONTACTED':
//         return Icons.call;
//       case 'QUALIFIED':
//         return Icons.verified;
//       case 'CONVERTED':
//         return Icons.check_circle;
//       case 'LOST':
//         return Icons.cancel;
//       default:
//         return Icons.label;
//     }
//   }

//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final diff = now.difference(date);

//     if (diff.inDays == 0) return 'Today';
//     if (diff.inDays == 1) return 'Yesterday';
//     if (diff.inDays < 7) return '${diff.inDays} days ago';
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }
