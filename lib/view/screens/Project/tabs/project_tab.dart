// import 'package:flutter/material.dart';
// import '../../../../model/product/backup/vacancy_model.dart';
// import '../../../../utils/style/colors/colors.dart';
// import '../../../widgets/custom_text.dart';

// class ProjectTab extends StatelessWidget {
//   final VacancyModel? data;

//   const ProjectTab({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           const double tabletBreakpoint = 600;
//           if (constraints.maxWidth > tabletBreakpoint) {
//             return _buildTabletLayout(context);
//           } else {
//             return _buildMobileLayout(context);
//           }
//         },
//       ),
//     );
//   }

//   /// Builds the layout for tablet and larger screens.
//   Widget _buildTabletLayout(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: _buildJobOverview(),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 flex: 1,
//                 child: Column(
//                   children: [
//                     _buildProjectInfo(),
//                     const SizedBox(height: 16),
//                     _buildQualifications(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // Specializations now takes up the full width for clarity
//           _buildSpecialization(),
//         ],
//       ),
//     );
//   }

//   /// Builds the layout for mobile screens.
//   Widget _buildMobileLayout(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildJobOverview(),
//           const SizedBox(height: 16),
//           _buildProjectInfo(),
//           const SizedBox(height: 16),
//           _buildQualifications(),
//           const SizedBox(height: 16),
//           _buildSpecialization(),
//         ],
//       ),
//     );
//   }

//   // A new reusable widget for our cards.
//   Widget _buildDetailCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Card(
//       elevation: 5,
//       color: AppColors.blueNeutralColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     gradient: AppColors.buttonGraidentColour,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Icon(icon, color: Colors.white, size: 20),
//                 ),
//                 const SizedBox(width: 12),
//                 CustomText(
//                   text: title,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryColor,
//                 ),
//               ],
//             ),
//             const Divider(height: 24, thickness: 1),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildJobOverview() {
//     return _buildDetailCard(
//       title: 'Job Overview',
//       icon: Icons.work_outline,
//       children: [
//         _buildInfoRow('Position', data?.jobCategory),
//         _buildInfoRow('Experience', '${data?.experience ?? 'N/A'} years'),
//         _buildInfoRow(
//           'Status',
//           data?.status,
//           color: data?.status == 'ACTIVE' ? Colors.green : Colors.red,
//         ),
//         _buildInfoRow('Total Vacancies', '${data?.totalVacancies ?? 0}'),
//         _buildInfoRow('Target CVs', '${data?.totalTargetCv ?? 0}'),
//         _buildInfoRow(
//           'Salary Range',
//           '${_formatSalary(data?.salaryFrom)} - ${_formatSalary(data?.salaryTo)}',
//         ),
//         _buildInfoRow(
//           'Deadline',
//           data?.lastDateToApply,
//           color: Colors.red.shade600,
//         ),
//         if (data?.description?.isNotEmpty == true)
//           _buildInfoRow('Description', data!.description!),
//       ],
//     );
//   }

//   Widget _buildProjectInfo() {
//     return _buildDetailCard(
//       title: 'Project Info',
//       icon: Icons.assignment_outlined,
//       children: [
//         _buildInfoRow('Project', data?.project?.projectName),
//         _buildInfoRow('Type', data?.project?.organizationType),
//         _buildInfoRow('Category', data?.project?.organizationCategory),
//         _buildInfoRow(
//           'Job Location',
//           '${data?.city ?? 'N/A'}, ${data?.country ?? 'N/A'}',
//           color: Colors.green.shade600,
//         ),
//         _buildInfoRow(
//           'Project Location',
//           '${data?.project?.city ?? 'N/A'}, ${data?.project?.country ?? 'N/A'}',
//         ),
//       ],
//     );
//   }

//   Widget _buildQualifications() {
//     return _buildDetailCard(
//       title: 'Qualifications',
//       icon: Icons.school_outlined,
//       children: [
//         if (data?.qualifications?.isNotEmpty == true)
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: data!.qualifications!
//                 .take(6)
//                 .map((qual) => Chip(
//                       label: Text(qual),
//                       backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//                       labelStyle: const TextStyle(
//                         color: AppColors.primaryColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 4, vertical: 0),
//                     ))
//                 .toList(),
//           )
//         else
//           const CustomText(
//             text: 'Not specified',
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//       ],
//     );
//   }

//   Widget _buildSpecialization() {
//     return _buildDetailCard(
//       title: 'Specializations',
//       icon: Icons.category_outlined,
//       children: [
//         if (data?.specializationTotals?.isNotEmpty == true)
//           ...data!.specializationTotals!
//               .take(4)
//               .map((spec) => Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: CustomText(
//                             text: spec.specialization ?? 'N/A',
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         CustomText(
//                           text: '${spec.count}/${spec.targetCv}',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w900,
//                           color: AppColors.orangeSecondaryColor,
//                         ),
//                       ],
//                     ),
//                   ))
//               .toList()
//         else
//           const CustomText(
//             text: 'No specializations',
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//       ],
//     );
//   }

//   // Reusable helper widget for rows of information.
//   Widget _buildInfoRow(String label, String? value, {Color? color}) {
//     if (value == null || value.isEmpty) {
//       return const SizedBox.shrink();
//     }
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//             text: '$label:',
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey.shade700,
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: CustomText(
//               text: value,
//               fontSize: 14,
//               color: color ?? AppColors.primaryColor,
//               fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatSalary(dynamic salary) {
//     if (salary == null) return 'N/A';
//     if (salary is! int && salary is! double && salary is! num) {
//       return 'N/A';
//     }
//     int salaryInt = salary is int ? salary : (salary as num).toInt();

//     if (salaryInt >= 10000000) {
//       double crores = salaryInt / 10000000.0;
//       return '₹${crores.toStringAsFixed(crores == crores.toInt() ? 0 : 2)}Cr';
//     } else if (salaryInt >= 100000) {
//       double lakhs = salaryInt / 100000.0;
//       return '₹${lakhs.toStringAsFixed(lakhs == lakhs.toInt() ? 0 : 1)}L';
//     } else if (salaryInt >= 1000) {
//       double thousands = salaryInt / 1000.0;
//       return '₹${thousands.toStringAsFixed(thousands == thousands.toInt() ? 0 : 1)}K';
//     } else {
//       return '₹$salaryInt';
//     }
//   }
// }
