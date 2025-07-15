import 'package:flutter/services.dart' show rootBundle;
import 'package:overseas_front_end/controller/lead/round_robin_provider.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/config_provider.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data' as typed;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as exl;
import 'dart:io';

import '../../../widgets/custom_multi_selection_dropdown_field.dart';

class BulkLeadScreen extends StatefulWidget {
  const BulkLeadScreen({super.key});

  @override
  State<BulkLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<BulkLeadScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String? _selectedService = 'Yes';
  String? _roundRobinSelection = 'Yes';
  List<Map<String, dynamic>> uploadedData = [];
  String? uploadedFileName;
  String? _branchController = '';
  String? _serviceTypeControlller = '';
  String _employeeController = '';
  late List<String> _roundRobin = [];

  @override
  void initState() {
    final provider = Provider.of<RoundRobinProvider>(context, listen: false);
    final officeProvider =
        Provider.of<OfficersControllerProvider>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          double dialogWidth = maxWidth;
          if (maxWidth > 1400) {
            dialogWidth = maxWidth * 0.72;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.9;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.95;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.95,
              constraints: const BoxConstraints(
                minWidth: 320,
                maxWidth: 1600,
                minHeight: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.9),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.leaderboard_rounded,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Add Bulk Lead',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: 'Upload Your Bulk Leads as excel',
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white, size: 24),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Scrollbar(
                                        thumbVisibility: true,
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.all(24),
                                          child: Consumer<ConfigProvider>(
                                              builder: (context, configProvider,
                                                  child) {
                                            return LayoutBuilder(
                                              builder: (context, constraints) {
                                                final availableWidth =
                                                    constraints.maxWidth;
                                                int columnsCount = 1;

                                                if (availableWidth > 1000) {
                                                  columnsCount = 3;
                                                } else if (availableWidth >
                                                    600) {
                                                  columnsCount = 2;
                                                }

                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SectionTitle(
                                                        title:
                                                            'Branch Information',
                                                        icon: Icons
                                                            .info_outline_rounded),
                                                    const SizedBox(height: 16),
                                                    ResponsiveGrid(
                                                        columns: columnsCount,
                                                        children: [
                                                          CustomDropdownField(
                                                            label: 'Branch',
                                                            value:
                                                                _branchController,
                                                            items: configProvider
                                                                    .configModelList
                                                                    ?.branch
                                                                    ?.map((e) =>
                                                                        e.name ??
                                                                        "")
                                                                    .toList() ??
                                                                [],
                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    _branchController =
                                                                        val),
                                                            isRequired: true,
                                                          ),
                                                          CustomDropdownField(
                                                            label:
                                                                'Service Type',
                                                            value:
                                                                _selectedService,
                                                            items: configProvider
                                                                    .configModelList
                                                                    ?.serviceType
                                                                    ?.map((e) =>
                                                                        e.name ??
                                                                        "")
                                                                    .toList() ??
                                                                [],
                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    _serviceTypeControlller =
                                                                        val),
                                                            isRequired: true,
                                                          ),
                                                        ]),
                                                    const SizedBox(height: 32),
                                                    const SectionTitle(
                                                        title:
                                                            'Lead Allocation',
                                                        icon: Icons
                                                            .person_outline_rounded),
                                                    const SizedBox(height: 16),
                                                    ResponsiveGrid(
                                                        columns: columnsCount,
                                                        children: [
                                                          CustomRadioGroup(
                                                              label:
                                                                  "Round Robin",
                                                              options: [
                                                                'Yes',
                                                                'No'
                                                              ],
                                                              selectedValue:
                                                                  _roundRobinSelection,
                                                              onChanged:
                                                                  (value) {}),
                                                          // Consumer<RoundRobinProvider>(builder: (context, roundRobin,
                                                          //     child){
                                                          //   return CustomDropdownField(
                                                          //     label: 'Round Robin',
                                                          //     value:
                                                          //     _roundRobin,
                                                          //     items: roundRobin
                                                          //         .roundRobinGroups
                                                          //       .map((e) =>
                                                          //     e.name ??
                                                          //         "")
                                                          //         .toList() ??
                                                          //         [],
                                                          //     onChanged: (val) =>
                                                          //         setState(() =>
                                                          //         _roundRobin =
                                                          //             val ??
                                                          //                 ''),
                                                          //     isRequired: true,
                                                          //   );
                                                          //
                                                          // }),
                                                          // CustomDropdownField(
                                                          //   label: 'Employee',
                                                          //   value:
                                                          //   _employeeController,
                                                          //   items: configProvider
                                                          //       .configModelList
                                                          //       ?.serviceType
                                                          //       ?.map((e) =>
                                                          //   e.name ??
                                                          //       "")
                                                          //       .toList() ??
                                                          //       [],
                                                          //   onChanged: (val) =>
                                                          //       setState(() =>
                                                          //       _employeeController =
                                                          //           val ??
                                                          //               ''),
                                                          //   isRequired: true,
                                                          // ),
                                                          Consumer<
                                                                  OfficersControllerProvider>(
                                                              builder: (context,
                                                                  officers,
                                                                  child) {
                                                            return CustomMultiSelectDropdownField(
                                                              label:
                                                                  'Select Officers',
                                                              selectedItems:
                                                                  _roundRobin,
                                                              items: officers
                                                                      .allOfficersListData
                                                                      ?.map((e) =>
                                                                          e.name ??
                                                                          '')
                                                                      .toList() ??
                                                                  [],
                                                              onChanged:
                                                                  (selected) {
                                                                setState(() {
                                                                  _roundRobin =
                                                                      selected;
                                                                });
                                                              },
                                                              isRequired: true,
                                                            );
                                                          }),
                                                        ]),
                                                    const SizedBox(height: 20),
                                                  ],
                                                );
                                              },
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: CustomActionButton(
                                            text: 'Download Excel Sheet',
                                            icon: Icons.close_rounded,
                                            textColor: Colors.grey,
                                            onPressed: downloadExcelTemplate,
                                            gradient: AppColors.greenGradient,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: CustomActionButton(
                                              text: 'Upload Excel Sheet',
                                              icon: Icons.save_rounded,
                                              isFilled: true,
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF7F00FF),
                                                  Color(0xFFE100FF)
                                                ],
                                              ),
                                              onPressed: _uploadExcelFile),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(width: 24),
                            // Visibility(
                            //   visible: maxWidth > 1000 ? _visibility : false,
                            //   child: Container(
                            //     // width: 280,
                            //     width: MediaQuery.of(context).size.width * .2,
                            //     decoration: BoxDecoration(
                            //       gradient: LinearGradient(
                            //         begin: Alignment.topCenter,
                            //         end: Alignment.bottomCenter,
                            //         colors: [
                            //           AppColors.violetPrimaryColor
                            //               .withOpacity(0.08),
                            //           AppColors.blueSecondaryColor
                            //               .withOpacity(0.04),
                            //         ],
                            //       ),
                            //       borderRadius: BorderRadius.circular(16),
                            //       border: Border.all(
                            //           color: AppColors.violetPrimaryColor
                            //               .withOpacity(0.15)),
                            //     ),
                            //     child: SingleChildScrollView(
                            //       child: Column(
                            //         children: [
                            //           Container(
                            //             padding: const EdgeInsets.all(24),
                            //             child: Column(
                            //               children: [
                            //                 Container(
                            //                   padding: const EdgeInsets.all(16),
                            //                   decoration: BoxDecoration(
                            //                     color: AppColors
                            //                         .violetPrimaryColor
                            //                         .withOpacity(0.1),
                            //                     borderRadius:
                            //                     BorderRadius.circular(12),
                            //                   ),
                            //                   child: Icon(
                            //                     Icons.person_add_alt_1_rounded,
                            //                     size: 40,
                            //                     color: AppColors
                            //                         .violetPrimaryColor,
                            //                   ),
                            //                 ),
                            //                 const SizedBox(width: 12),
                            //                 const FittedBox(
                            //                   fit: BoxFit.scaleDown,
                            //                   child: CustomText(
                            //                     text:
                            //                     'Communication Preferences',
                            //                     fontWeight: FontWeight.bold,
                            //                     // fontSize: 17,
                            //                     color: AppColors.primaryColor,
                            //                   ),
                            //                 ),
                            //                 const SizedBox(height: 8),
                            //                 const CustomText(
                            //                   text:
                            //                   'Fill all required fields to add new lead',
                            //                   fontSize: 13,
                            //                   color: Colors.grey,
                            //                   textAlign: TextAlign.center,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           Visibility(
                            //               visible:
                            //               maxWidth > 1000 ? false : true,
                            //               child: const SizedBox(height: 24)),
                            //           Container(
                            //             padding: const EdgeInsets.all(24),
                            //             child: Column(
                            //               crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //               children: [
                            //                 Row(
                            //                   children: [
                            //                     Container(
                            //                       padding:
                            //                       const EdgeInsets.all(8),
                            //                       decoration: BoxDecoration(
                            //                         color: AppColors
                            //                             .violetPrimaryColor
                            //                             .withOpacity(0.1),
                            //                         borderRadius:
                            //                         BorderRadius.circular(
                            //                             10),
                            //                       ),
                            //                       child: Icon(
                            //                           Icons
                            //                               .notifications_active_rounded,
                            //                           size: 20,
                            //                           color: AppColors
                            //                               .violetPrimaryColor),
                            //                     ),
                            //                     const SizedBox(width: 12),
                            //                     const Expanded(
                            //                       child: CustomText(
                            //                         maxline: true,
                            //                         maxLines: 1,
                            //                         overflow:
                            //                         TextOverflow.ellipsis,
                            //                         text:
                            //                         'Communication Preferences',
                            //                         fontWeight: FontWeight.bold,
                            //                         fontSize: 16,
                            //                         color:
                            //                         AppColors.primaryColor,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 const SizedBox(height: 20),
                            //                 Column(
                            //                   children: [
                            //                     EnhancedSwitchTile(
                            //                       label: 'Send Greetings',
                            //                       icon:
                            //                       Icons.celebration_rounded,
                            //                       value: _sendGreetings,
                            //                       onChanged: (val) => setState(
                            //                               () =>
                            //                           _sendGreetings = val),
                            //                     ),
                            //                     const SizedBox(height: 12),
                            //                     EnhancedSwitchTile(
                            //                       label: 'Send Email Updates',
                            //                       icon: Icons.email_rounded,
                            //                       value: _sendEmail,
                            //                       onChanged: (val) => setState(
                            //                               () => _sendEmail = val),
                            //                     ),
                            //                     const SizedBox(height: 12),
                            //                     EnhancedSwitchTile(
                            //                       label:
                            //                       'WhatsApp Communication',
                            //                       icon: Icons.chat_rounded,
                            //                       value: _sendWhatsapp,
                            //                       onChanged: (val) => setState(
                            //                               () =>
                            //                           _sendWhatsapp = val),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> downloadExcelTemplate() async {
    try {
      final typed.ByteData data = await rootBundle.load('excel/template.xlsx');
      final typed.Uint8List bytes = data.buffer.asUint8List();

      if (kIsWeb) {
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'template.xlsx')
          ..click();
        html.Url.revokeObjectUrl(url);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Template downloaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/template.xlsx';
        final file = File(filePath);

        await file.create(recursive: true);
        await file.writeAsBytes(bytes);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Template downloaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      // setState(() {
      //   isTemplateDownloaded = true;
      // });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading template: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  ///---------------from API------------------
// Future<void> _downloadExcelTemplate() async {
//   try {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/template.xlsx';
//
//     final response = await Dio().download(
//       'https://yourdomain.com/files/template.xlsx',
//       filePath,
//     );
//
//     if (response.statusCode == 200) {
//       setState(() {
//         isTemplateDownloaded = true;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Template downloaded successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       throw 'Failed to download file';
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Error downloading template: $e'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }

  Future<void> _uploadExcelFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null) {
        typed.Uint8List? bytes = result.files.first.bytes;
        if (bytes != null) {
          var excel = exl.Excel.decodeBytes(bytes);

          setState(() {
            uploadedData.clear();
            uploadedFileName = result.files.first.name;
          });

          for (var table in excel.tables.keys) {
            var sheet = excel.tables[table];
            if (sheet != null) {
              List<String> headers = [];
              var firstRow = sheet.rows.first;
              for (var cell in firstRow) {
                headers.add(cell?.value?.toString() ?? '');
              }

              for (int i = 1; i < sheet.rows.length; i++) {
                var row = sheet.rows[i];
                Map<String, dynamic> rowData = {};

                for (int j = 0; j < row.length && j < headers.length; j++) {
                  var cellValue = row[j]?.value?.toString() ?? '';
                  if (cellValue.isNotEmpty) {
                    rowData[headers[j]] = cellValue;
                  }
                }

                if (rowData.isNotEmpty) {
                  uploadedData.add(rowData);
                }
              }
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'File uploaded successfully! ${uploadedData.length} rows loaded.'),
              backgroundColor: Colors.green,
            ),
          );
          _showExcelPreviewAndProcess();
          // _convertToJson();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showExcelPreviewAndProcess() {
    if (uploadedData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No data to show!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    List<String> columns = uploadedData.first.keys.toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excel Preview'),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: columns.map((header) {
                return DataColumn(label: Text(header));
              }).toList(),
              rows: uploadedData.map((row) {
                return DataRow(
                  cells: columns.map((header) {
                    return DataCell(Text(row[header]?.toString() ?? ''));
                  }).toList(),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _convertToJson();

                ///-----------send json to backend --------------------
              },
              child: const Text('Process'),
            ),
          ],
        );
      },
    );
  }

  void _convertToJson() {
    if (uploadedData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No data to convert!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    Map<String, dynamic> jsonData = {
      'branch': _selectedService,
      'serviceType': _selectedService,
      'roundRobin': _roundRobinSelection,
      'employee': _employeeController,
      'uploadedAt': DateTime.now().toIso8601String(),
      'fileName': uploadedFileName,
      'totalRows': uploadedData.length,
      'data': uploadedData,
    };

    String jsonString = JsonEncoder.withIndent('  ').convert(jsonData);

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title:const  Text('JSON Data'),
    //       content: SingleChildScrollView(
    //         child: Text(
    //           jsonString,
    //           style: TextStyle(fontFamily: 'monospace', fontSize: 12),
    //         ),
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child:const  Text('Close'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               const    SnackBar(
    //                 content: Text('JSON data processed successfully!'),
    //                 backgroundColor: Colors.green,
    //               ),
    //             );
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text('Process'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
