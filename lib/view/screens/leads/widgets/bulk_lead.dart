import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/lead/lead_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:typed_data' as typed;
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as exl;
import 'dart:io';

class BulkLeadScreen extends StatefulWidget {
  const BulkLeadScreen({super.key});

  @override
  State<BulkLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<BulkLeadScreen>
    with TickerProviderStateMixin {
  final configController = Get.find<ConfigController>();
  final _formKey = GlobalKey<FormState>();

  String? _branchController = '';
  String? _roundRobinSelection = 'Yes';
  String? _serviceTypeController = '';
  final List<OfficerModel> _employeeController = [];

  List<Map<String, dynamic>> uploadedData = [];
  String? uploadedFileName;
  bool _isProcessing = false;
  bool _isSaving = false;
  bool _isDataLoaded = false;

  late final ScrollController _formScroll;
  late final ScrollController _previewVertical;
  late final ScrollController _previewHorizontal;

  // Response handling variables
  Map<String, dynamic>? saveResponse;
  List<dynamic>? insertedLeads;
  List<dynamic>? failedLeads;

  @override
  void initState() {
    super.initState();
    _formScroll = ScrollController();
    _previewVertical = ScrollController();
    _previewHorizontal = ScrollController();
  }

  @override
  void dispose() {
    _formScroll.dispose();
    _previewVertical.dispose();
    _previewHorizontal.dispose();
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
            dialogWidth = maxWidth * 0.7;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.95;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.85,
              constraints: const BoxConstraints(
                minWidth: 320,
                maxWidth: 1600,
                minHeight: 600,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomText(
                                text: 'Add Bulk Lead',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: _isDataLoaded
                                    ? '${uploadedData.length} leads loaded from "$uploadedFileName"'
                                    : 'Upload Your Bulk Leads as excel',
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
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    // Main content area with proper scrolling
                                    Expanded(
                                      child: Scrollbar(
                                        controller: _formScroll,
                                        thumbVisibility: true,
                                        child: SingleChildScrollView(
                                          controller: _formScroll,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Lead Allocation Section
                                              const SectionTitle(
                                                  title: 'Lead Allocation',
                                                  icon: Icons
                                                      .person_outline_rounded),
                                              const SizedBox(height: 16),
                                              LayoutBuilder(
                                                builder:
                                                    (context, constraints) {
                                                  final availableWidth =
                                                      constraints.maxWidth;
                                                  int columnsCount = 1;

                                                  if (availableWidth > 1000) {
                                                    columnsCount = 3;
                                                  } else if (availableWidth >
                                                      600) {
                                                    columnsCount = 2;
                                                  }

                                                  return ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
                                                      CustomRadioGroup(
                                                        label: "Round Robin",
                                                        options: ['Yes', 'No'],
                                                        selectedValue:
                                                            _roundRobinSelection,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _roundRobinSelection =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      Visibility(
                                                        visible:
                                                            _roundRobinSelection ==
                                                                    'Yes'
                                                                ? false
                                                                : true,
                                                        child:
                                                            CustomMultiOfficerSelectDropdownField(
                                                          isRequired: true,
                                                          label:
                                                              'Select Officers',
                                                          selectedItems:
                                                              _employeeController,
                                                          items: Get.find<
                                                                  OfficersController>()
                                                              .officersList,
                                                          onChanged:
                                                              (selectedIds) {
                                                            setState(() {
                                                              _employeeController
                                                                  .clear();
                                                              _employeeController
                                                                  .addAll(
                                                                      selectedIds);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                              const SizedBox(height: 20),

                                              // Processing Indicator
                                              if (_isProcessing)
                                                _buildProcessingIndicator(),

                                              // Data Preview Section
                                              if (_isDataLoaded &&
                                                  saveResponse == null)
                                                _buildDataPreview(),
                                              if (saveResponse != null)
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20),
                                                  child: _buildSaveResponse(),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Fixed button row at bottom
                                    Container(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomActionButton(
                                              text: 'Close',
                                              icon: Icons.cancel_outlined,
                                              textColor: Colors.grey,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              gradient: AppColors.greenGradient,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: CustomActionButton(
                                              text: 'Download Template',
                                              icon: Icons.pages_outlined,
                                              textColor: Colors.grey,
                                              onPressed: downloadExcelTemplate,
                                              gradient: AppColors.greenGradient,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          if (!_isDataLoaded)
                                            Expanded(
                                              child: CustomActionButton(
                                                text: 'Upload Excel File',
                                                icon: Icons.upload_file,
                                                isFilled: true,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFF7F00FF),
                                                    Color(0xFFE100FF)
                                                  ],
                                                ),
                                                onPressed: _uploadExcelFile,
                                              ),
                                            )
                                          else
                                            Expanded(
                                                child: CustomActionButton(
                                                    text: _isSaving
                                                        ? 'Saving...'
                                                        : 'Save Leads',
                                                    icon: _isSaving
                                                        ? Icons.hourglass_top
                                                        : Icons.save_rounded,
                                                    isFilled: true,
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFF00C853),
                                                        Color(0xFF64DD17)
                                                      ],
                                                    ),
                                                    onPressed: _isSaving
                                                        ? () {}
                                                        : () => _saveToAPI())),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

  Widget _buildProcessingIndicator() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Processing Excel file...',
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: uploadedFileName ?? 'Loading file...',
                  fontSize: 12,
                  color: Colors.blue.shade700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with record count
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 12),
          child: Row(
            children: [
              Icon(Icons.table_chart, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Flexible(
                child: CustomText(
                  text: 'Preview of Uploaded Data',
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() {
                  uploadedData.clear();
                  uploadedFileName = null;
                  _isDataLoaded = false;
                  saveResponse = null;
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      CustomText(
                        text: '${uploadedData.length} records',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Data Table with constrained height
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Scrollbar(
            controller: _previewHorizontal,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _previewHorizontal,
              scrollDirection: Axis.horizontal,
              primary: false,
              child: SizedBox(
                width: uploadedData.isNotEmpty
                    ? uploadedData[0].length * 180.0
                    : 800,
                child: Scrollbar(
                  controller: _previewVertical,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _previewVertical,
                    primary: false,
                    child: DataTable(
                      columnSpacing: 16,
                      headingRowColor: MaterialStateProperty.resolveWith(
                        (_) => Colors.grey.shade100,
                      ),
                      headingRowHeight: 50,
                      dataRowMinHeight: 40,
                      dataRowMaxHeight: 60,
                      columns: const [
                        DataColumn(
                            label: Text('#',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Name',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Phone',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Email',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Service Type',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Country',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Status',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: uploadedData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final row = entry.value;
                        return DataRow(
                          color: MaterialStateProperty.resolveWith(
                            (_) => index.isEven ? Colors.grey.shade50 : null,
                          ),
                          cells: [
                            DataCell(Text('${index + 1}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(row['name'] ?? 'N/A')),
                            DataCell(Text(row['phone'] ?? 'N/A')),
                            DataCell(Text(row['email'] ?? 'N/A')),
                            DataCell(Text(row['service_type'] ?? 'N/A')),
                            DataCell(Text(row['country'] ?? 'N/A')),
                            DataCell(Text(row['status'] ?? 'NEW')),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Save Response Section
      ],
    );
  }

  Widget _buildSaveResponse() {
    final summary = saveResponse?['summary'];
    final inserted = summary?['inserted'] ?? 0;
    final failed = summary?['failed'] ?? 0;
    final total = summary?['total'] ?? 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: failed == 0 ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: failed == 0 ? Colors.green.shade200 : Colors.orange.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                failed == 0 ? Icons.check_circle : Icons.warning,
                color: failed == 0 ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomText(
                  text: failed == 0
                      ? 'Save Successful!'
                      : 'Save Completed with $failed error(s)',
                  fontWeight: FontWeight.bold,
                  color: failed == 0 ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('Total', total.toString(), Colors.blue),
              _buildStatCard('Inserted', inserted.toString(), Colors.green),
              _buildStatCard('Failed', failed.toString(), Colors.red),
            ],
          ),
          const SizedBox(height: 16),

          // Failed Leads Table
          if (failed > 0 && saveResponse?['errors'] != null)
            _buildFailedLeadsTable(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: const BoxConstraints(minWidth: 80),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          const SizedBox(height: 4),
          CustomText(
            text: label,
            fontSize: 10,
            color: color.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedLeadsTable() {
    final errors = saveResponse?['errors'] ?? [];
    if (errors.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const CustomText(
          text: 'Failed Leads:',
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        const SizedBox(height: 8),
        Container(
          height: 150, // Fixed height for error table
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // Fixed width for error table
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 16,
                      headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.red.shade50,
                      ),
                      dataRowMinHeight: 40,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Index',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Phone',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Reason',
                            maxLines: 3,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: errors.map<DataRow>((error) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text((int.parse(
                                          (error['index'] ?? '0').toString()) +
                                      1)
                                  .toString()),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: SelectionArea(
                                    child: Text(
                                  error['name']?.toString() ?? 'N/A',
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: SelectionArea(
                                  child: Text(
                                    error['phone']?.toString() ?? 'N/A',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: Text(
                                  error['email']?.toString() ?? 'N/A',
                                  // overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 200),
                                child: Text(
                                  error['reason']?.toString() ??
                                      'Unknown error',
                                  style: TextStyle(color: Colors.red.shade700),
                                  // overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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
          ..setAttribute('download', 'bulk_leads_template.xlsx')
          ..click();
        html.Url.revokeObjectUrl(url);
        CustomToast.showToast(
          context: context,
          message: 'Template downloaded successfully!',
          backgroundColor: AppColors.greenSecondaryColor,
        );
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/bulk_leads_template.xlsx';
        final file = File(filePath);
        await file.create(recursive: true);
        await file.writeAsBytes(bytes);
        CustomToast.showToast(
          context: context,
          message: 'Template downloaded successfully!',
          backgroundColor: AppColors.greenSecondaryColor,
        );
      }
    } catch (e) {
      CustomToast.showToast(
        context: context,
        message: 'Error downloading template: $e',
        backgroundColor: AppColors.redSecondaryColor,
      );
    }
  }

  Future<void> _uploadExcelFile() async {
    try {
      // if (_roundRobinSelection == 'No' && _employeeController.isEmpty) {
      //   CustomToast.showToast(
      //     context: context,
      //     message: 'Please select officers for allocation',
      //     backgroundColor: AppColors.redSecondaryColor,
      //   );
      //   return;
      // }
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _isProcessing = true;
        });

        await Future.delayed(
            const Duration(milliseconds: 500)); // Simulate processing

        typed.Uint8List? bytes = result.files.first.bytes;
        if (bytes != null) {
          var excel = exl.Excel.decodeBytes(bytes);

          List<Map<String, dynamic>> newData = [];
          String? fileName = result.files.first.name;

          for (var table in excel.tables.keys) {
            var sheet = excel.tables[table];
            if (sheet != null && sheet.rows.isNotEmpty) {
              List<String> headers = [];
              var firstRow = sheet.rows.first;
              for (var cell in firstRow) {
                headers.add(cell?.value?.toString().trim() ?? '');
              }

              for (int i = 1; i < sheet.rows.length; i++) {
                var row = sheet.rows[i];

                Map<String, dynamic> rowData = {};

                bool hasData = false;
                for (int j = 0; j < row.length && j < headers.length; j++) {
                  var cellValue = row[j]?.value?.toString().trim() ?? '';
                  if (cellValue.isNotEmpty) {
                    rowData[headers[j]] = cellValue;
                    hasData = true;
                  }
                }

                if (hasData) {
                  if (!rowData.containsKey('status')) {
                    rowData['status'] = 'NEW';
                  }
                  if (!rowData.containsKey('service_type')) {
                    rowData['service_type'] = "LEAD";
                  }
                  newData.add(rowData);
                }
              }
            }
          }

          setState(() {
            uploadedData = newData;
            uploadedFileName = fileName;
            _isProcessing = false;
            _isDataLoaded = true;
            saveResponse = null;
          });

          if (uploadedData.isNotEmpty) {
            CustomToast.showToast(
              context: context,
              message: 'Successfully loaded ${uploadedData.length} leads',
              backgroundColor: AppColors.greenSecondaryColor,
            );
          } else {
            CustomToast.showToast(
              context: context,
              message: 'No valid data found in the Excel file',
              backgroundColor: AppColors.orangeSecondaryColor,
            );
            setState(() {
              _isDataLoaded = false;
            });
          }
        }
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      CustomToast.showToast(
        context: context,
        message: 'Error processing file: $e',
        backgroundColor: AppColors.redSecondaryColor,
      );
    }
  }

  Future<void> _saveToAPI() async {
    setState(() {
      _isSaving = true;
    });

    try {
      // Prepare the data according to your API structure
      Map<String, dynamic> requestData = {
        "roundrobin": _roundRobinSelection == 'Yes' ? true : false,
        "officers": _employeeController.map((officer) => officer.id).toList(),
        "data": uploadedData.map((row) {
          return {
            "name": row['name']?.toString() ?? '',
            "email": row['email']?.toString() ?? '',
            "phone": row['phone']?.toString() ?? '',
            "country_code": row['country_code']?.toString() ?? '+91',
            "gender": row['gender']?.toString() ?? 'Male',
            "dob": row['dob']?.toString() ?? '',
            "service_type":
                row['service_type']?.toString() ?? _serviceTypeController,
            "address": row['address']?.toString() ?? '',
            "city": row['city']?.toString() ?? '',
            "state": row['state']?.toString() ?? '',
            "country": row['country']?.toString() ?? '',
            "pincode": row['pincode']?.toString() ?? '',
            "lead_source": row['lead_source']?.toString() ?? '',
            "source_campaign": row['source_campaign']?.toString() ?? '',
            "status": row['status']?.toString() ?? 'NEW',
            "branch": row['branch']?.toString() ?? _branchController,
          };
        }).toList(),
      };
      showLoaderDialog(context);
      // Simulate API call
      // await Future.delayed(const Duration(seconds: 2));
      // // Mock response for demonstration
      // final mockResponse = {
      //   "success": true,
      //   "data": {
      //     "success": true,
      //     "summary": {
      //       "total": uploadedData.length,
      //       "inserted": uploadedData.length - 1,
      //       "failed": 1
      //     },
      //     "insertedIds": List.generate(uploadedData.length - 1,
      //         (index) => "id_${DateTime.now().millisecondsSinceEpoch}_$index"),
      //     "errors": uploadedData.length > 1
      //         ? [
      //             {
      //               "index": 0,
      //               "name": uploadedData[0]['name'],
      //               "email": uploadedData[0]['email'],
      //               "phone": uploadedData[0]['phone'],
      //               "reason": "Duplicate phone number"
      //             }
      //           ]
      //         : []
      //   }
      // };
      var response =
          await Get.find<LeadController>().createBulkLead(context, requestData);
      setState(() {
        saveResponse = response;
      });
      Navigator.of(context).pop(); // Close the loader dialog
    } catch (e) {
      Navigator.of(context).pop(); // Close the loader dialog
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }
}

// import 'package:flutter/services.dart' show rootBundle;
// import 'package:get/get.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:universal_html/html.dart' as html;
// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import 'dart:typed_data' as typed;
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:excel/excel.dart' as exl;
// import 'dart:io';
// import '../../../../controller/officers_controller/officers_controller.dart';
// import '../../../../model/officer/officer_model.dart';
// import '../../../widgets/custom_toast.dart';

// class BulkLeadScreen extends StatefulWidget {
//   const BulkLeadScreen({super.key});

//   @override
//   State<BulkLeadScreen> createState() => _AddLeadScreenState();
// }

// class _AddLeadScreenState extends State<BulkLeadScreen>
//     with TickerProviderStateMixin {
//   final configController = Get.find<ConfigController>();
//   final _formKey = GlobalKey<FormState>();

//   final String _selectedService = 'Yes';
//   String? _roundRobinSelection = 'Yes';
//   List<Map<String, dynamic>> uploadedData = [];
//   String? uploadedFileName;
//   String? _branchController = '';
//   final List<OfficerModel> _employeeController = [];
//   String _roundRobin = '';

//   @override
//   void initState() {
//     // final provider = Provider.of<RoundRobinProvider>(context, listen: false);
//     // final officeProvider =
//     //     Provider.of<OfficersControllerProvider>(context, listen: false);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.72;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.7;
//           } else if (maxWidth > 600) {
//             dialogWidth = maxWidth * 0.95;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.5,
//               constraints: const BoxConstraints(
//                 minWidth: 320,
//                 maxWidth: 1600,
//                 minHeight: 500,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.15),
//                     spreadRadius: 0,
//                     blurRadius: 40,
//                     offset: const Offset(0, 20),
//                   )
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 80,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 16),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(0.9),
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.leaderboard_rounded,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: 'Add Bulk Lead',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text: 'Upload Your Bulk Leads as excel',
//                                 fontSize: 13,
//                                 color: Colors.white70,
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         IconButton(
//                           icon: const Icon(Icons.close_rounded,
//                               color: Colors.white, size: 24),
//                           onPressed: () => Navigator.of(context).pop(),
//                           tooltip: 'Close',
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Form(
//                         key: _formKey,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade50,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border:
//                                       Border.all(color: Colors.grey.shade200),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: Scrollbar(
//                                         thumbVisibility: true,
//                                         child: SingleChildScrollView(
//                                           padding: const EdgeInsets.all(24),
//                                           child: LayoutBuilder(
//                                             builder: (context, constraints) {
//                                               final availableWidth =
//                                                   constraints.maxWidth;
//                                               int columnsCount = 1;

//                                               if (availableWidth > 1000) {
//                                                 columnsCount = 3;
//                                               } else if (availableWidth > 600) {
//                                                 columnsCount = 2;
//                                               }

//                                               return Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const SectionTitle(
//                                                       title:
//                                                           'Branch Information',
//                                                       icon: Icons
//                                                           .info_outline_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomDropdownField(
//                                                           label: 'Branch',
//                                                           value:
//                                                               _branchController,
//                                                           items: configController
//                                                                   .configData
//                                                                   .value
//                                                                   .branch
//                                                                   ?.map((e) =>
//                                                                       e.name ??
//                                                                       "")
//                                                                   .toList() ??
//                                                               [],
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _branchController =
//                                                                       val),
//                                                           isRequired: true,
//                                                         ),
//                                                         // CustomDropdownField(
//                                                         //   label:
//                                                         //       'Service Type',
//                                                         //   value:
//                                                         //       _selectedService,
//                                                         //   items: configProvider
//                                                         //           .configModelList
//                                                         //           ?.serviceType
//                                                         //           ?.map((e) =>
//                                                         //               e.name ??
//                                                         //               "")
//                                                         //           .toList() ??
//                                                         //       [],
//                                                         //   onChanged: (val) =>
//                                                         //       setState(() =>
//                                                         //           _serviceTypeControlller =
//                                                         //               val),
//                                                         //   isRequired: true,
//                                                         // ),
//                                                       ]),
//                                                   const SizedBox(height: 32),
//                                                   const SectionTitle(
//                                                       title: 'Lead Allocation',
//                                                       icon: Icons
//                                                           .person_outline_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomRadioGroup(
//                                                             label:
//                                                                 "Round Robin",
//                                                             options: [
//                                                               'Yes',
//                                                               'No'
//                                                             ],
//                                                             selectedValue:
//                                                                 _roundRobinSelection,
//                                                             onChanged: (value) {
//                                                               setState(() {
//                                                                 _roundRobinSelection =
//                                                                     value;
//                                                               });
//                                                             }),
//                                                         // Visibility(
//                                                         //   visible:
//                                                         //       _roundRobinSelection ==
//                                                         //               'Yes'
//                                                         //           ? true
//                                                         //           : false,
//                                                         //   child: Consumer<
//                                                         //           RoundRobinProvider>(
//                                                         //       builder: (context,
//                                                         //           roundRobin,
//                                                         //           child) {
//                                                         //     return CustomDropdownField(
//                                                         //       label:
//                                                         //           'Round Robin',
//                                                         //       value:
//                                                         //           _roundRobin,
//                                                         //       items: roundRobin
//                                                         //               .roundRobinGroups
//                                                         //               .map((e) =>
//                                                         //                   e.name ??
//                                                         //                   "")
//                                                         //               .toList() ??
//                                                         //           [],
//                                                         //       onChanged: (val) =>
//                                                         //           setState(() =>
//                                                         //               _roundRobin =
//                                                         //                   val ??
//                                                         //                       ''),
//                                                         //       isRequired:
//                                                         //           _roundRobinSelection ==
//                                                         //                   'Yes'
//                                                         //               ? true
//                                                         //               : false,
//                                                         //     );
//                                                         //   }),
//                                                         // ),
//                                                         Visibility(
//                                                             visible:
//                                                                 _roundRobinSelection ==
//                                                                         'Yes'
//                                                                     ? false
//                                                                     : true,
//                                                             child:
//                                                                 CustomMultiOfficerSelectDropdownField(
//                                                               isRequired: true,
//                                                               label:
//                                                                   'Select Officers',
//                                                               selectedItems:
//                                                                   _employeeController,
//                                                               items: Get.find<
//                                                                       OfficersController>()
//                                                                   .officersList,
//                                                               onChanged:
//                                                                   (selectedIds) {
//                                                                 setState(() {
//                                                                   _employeeController
//                                                                       .clear();
//                                                                   _employeeController
//                                                                       .addAll(
//                                                                           selectedIds);
//                                                                 });
//                                                               },
//                                                             )),
//                                                       ]),
//                                                   const SizedBox(height: 20),
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         const SizedBox(width: 16),
//                                         Expanded(
//                                           child: CustomActionButton(
//                                             text: 'Download Excel Sheet',
//                                             icon: Icons.pages_outlined,
//                                             textColor: Colors.grey,
//                                             onPressed: downloadExcelTemplate,
//                                             gradient: AppColors.greenGradient,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 16),
//                                         Expanded(
//                                           child: CustomActionButton(
//                                               text: 'Upload Excel Sheet',
//                                               icon: Icons.save_rounded,
//                                               isFilled: true,
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xFF7F00FF),
//                                                   Color(0xFFE100FF)
//                                                 ],
//                                               ),
//                                               onPressed: _uploadExcelFile),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             // const SizedBox(width: 24),
//                             // Visibility(
//                             //   visible: maxWidth > 1000 ? _visibility : false,
//                             //   child: Container(
//                             //     // width: 280,
//                             //     width: MediaQuery.of(context).size.width * .2,
//                             //     decoration: BoxDecoration(
//                             //       gradient: LinearGradient(
//                             //         begin: Alignment.topCenter,
//                             //         end: Alignment.bottomCenter,
//                             //         colors: [
//                             //           AppColors.violetPrimaryColor
//                             //               .withOpacity(0.08),
//                             //           AppColors.blueSecondaryColor
//                             //               .withOpacity(0.04),
//                             //         ],
//                             //       ),
//                             //       borderRadius: BorderRadius.circular(16),
//                             //       border: Border.all(
//                             //           color: AppColors.violetPrimaryColor
//                             //               .withOpacity(0.15)),
//                             //     ),
//                             //     child: SingleChildScrollView(
//                             //       child: Column(
//                             //         children: [
//                             //           Container(
//                             //             padding: const EdgeInsets.all(24),
//                             //             child: Column(
//                             //               children: [
//                             //                 Container(
//                             //                   padding: const EdgeInsets.all(16),
//                             //                   decoration: BoxDecoration(
//                             //                     color: AppColors
//                             //                         .violetPrimaryColor
//                             //                         .withOpacity(0.1),
//                             //                     borderRadius:
//                             //                     BorderRadius.circular(12),
//                             //                   ),
//                             //                   child: Icon(
//                             //                     Icons.person_add_alt_1_rounded,
//                             //                     size: 40,
//                             //                     color: AppColors
//                             //                         .violetPrimaryColor,
//                             //                   ),
//                             //                 ),
//                             //                 const SizedBox(width: 12),
//                             //                 const FittedBox(
//                             //                   fit: BoxFit.scaleDown,
//                             //                   child: CustomText(
//                             //                     text:
//                             //                     'Communication Preferences',
//                             //                     fontWeight: FontWeight.bold,
//                             //                     // fontSize: 17,
//                             //                     color: AppColors.primaryColor,
//                             //                   ),
//                             //                 ),
//                             //                 const SizedBox(height: 8),
//                             //                 const CustomText(
//                             //                   text:
//                             //                   'Fill all required fields to add new lead',
//                             //                   fontSize: 13,
//                             //                   color: Colors.grey,
//                             //                   textAlign: TextAlign.center,
//                             //                 ),
//                             //               ],
//                             //             ),
//                             //           ),
//                             //           Visibility(
//                             //               visible:
//                             //               maxWidth > 1000 ? false : true,
//                             //               child: const SizedBox(height: 24)),
//                             //           Container(
//                             //             padding: const EdgeInsets.all(24),
//                             //             child: Column(
//                             //               crossAxisAlignment:
//                             //               CrossAxisAlignment.start,
//                             //               children: [
//                             //                 Row(
//                             //                   children: [
//                             //                     Container(
//                             //                       padding:
//                             //                       const EdgeInsets.all(8),
//                             //                       decoration: BoxDecoration(
//                             //                         color: AppColors
//                             //                             .violetPrimaryColor
//                             //                             .withOpacity(0.1),
//                             //                         borderRadius:
//                             //                         BorderRadius.circular(
//                             //                             10),
//                             //                       ),
//                             //                       child: Icon(
//                             //                           Icons
//                             //                               .notifications_active_rounded,
//                             //                           size: 20,
//                             //                           color: AppColors
//                             //                               .violetPrimaryColor),
//                             //                     ),
//                             //                     const SizedBox(width: 12),
//                             //                     const Expanded(
//                             //                       child: CustomText(
//                             //                         maxline: true,
//                             //                         maxLines: 1,
//                             //                         overflow:
//                             //                         TextOverflow.ellipsis,
//                             //                         text:
//                             //                         'Communication Preferences',
//                             //                         fontWeight: FontWeight.bold,
//                             //                         fontSize: 16,
//                             //                         color:
//                             //                         AppColors.primaryColor,
//                             //                       ),
//                             //                     ),
//                             //                   ],
//                             //                 ),
//                             //                 const SizedBox(height: 20),
//                             //                 Column(
//                             //                   children: [
//                             //                     EnhancedSwitchTile(
//                             //                       label: 'Send Greetings',
//                             //                       icon:
//                             //                       Icons.celebration_rounded,
//                             //                       value: _sendGreetings,
//                             //                       onChanged: (val) => setState(
//                             //                               () =>
//                             //                           _sendGreetings = val),
//                             //                     ),
//                             //                     const SizedBox(height: 12),
//                             //                     EnhancedSwitchTile(
//                             //                       label: 'Send Email Updates',
//                             //                       icon: Icons.email_rounded,
//                             //                       value: _sendEmail,
//                             //                       onChanged: (val) => setState(
//                             //                               () => _sendEmail = val),
//                             //                     ),
//                             //                     const SizedBox(height: 12),
//                             //                     EnhancedSwitchTile(
//                             //                       label:
//                             //                       'WhatsApp Communication',
//                             //                       icon: Icons.chat_rounded,
//                             //                       value: _sendWhatsapp,
//                             //                       onChanged: (val) => setState(
//                             //                               () =>
//                             //                           _sendWhatsapp = val),
//                             //                     ),
//                             //                   ],
//                             //                 ),
//                             //               ],
//                             //             ),
//                             //           ),
//                             //         ],
//                             //       ),
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
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

//   Future<void> downloadExcelTemplate() async {
//     try {
//       final typed.ByteData data = await rootBundle.load('excel/template.xlsx');
//       final typed.Uint8List bytes = data.buffer.asUint8List();

//       if (kIsWeb) {
//         final blob = html.Blob([bytes]);
//         final url = html.Url.createObjectUrlFromBlob(blob);
//         final anchor = html.AnchorElement(href: url)
//           ..setAttribute('download', 'template.xlsx')
//           ..click();
//         html.Url.revokeObjectUrl(url);
//         CustomToast.showToast(
//             context: context, message: 'Template downloaded successfully!');
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(
//         //     content: Text('Template downloaded successfully!'),
//         //     backgroundColor: Colors.green,
//         //   ),
//         // );
//       } else {
//         final directory = await getApplicationDocumentsDirectory();
//         final filePath = '${directory.path}/template.xlsx';
//         final file = File(filePath);

//         await file.create(recursive: true);
//         await file.writeAsBytes(bytes);
//         CustomToast.showToast(
//             context: context, message: 'Template downloaded successfully!');
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(
//         //     content: Text('Template downloaded successfully!'),
//         //     backgroundColor: Colors.green,
//         //   ),
//         // );
//       }

//       // setState(() {
//       //   isTemplateDownloaded = true;
//       // });
//     } catch (e) {
//       CustomToast.showToast(
//           context: context,
//           message: 'Error downloading template: $e',
//           backgroundColor: AppColors.redSecondaryColor);
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(
//       //     content: Text('Error downloading template: $e'),
//       //     backgroundColor: Colors.red,
//       //   ),
//       // );
//     }
//   }

//   ///---------------from API------------------
// // Future<void> _downloadExcelTemplate() async {
// //   try {
// //     final directory = await getApplicationDocumentsDirectory();
// //     final filePath = '${directory.path}/template.xlsx';
// //
// //     final response = await Dio().download(
// //       'https://yourdomain.com/files/template.xlsx',
// //       filePath,
// //     );
// //
// //     if (response.statusCode == 200) {
// //       setState(() {
// //         isTemplateDownloaded = true;
// //       });
// //
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Template downloaded successfully!'),
// //           backgroundColor: Colors.green,
// //         ),
// //       );
// //     } else {
// //       throw 'Failed to download file';
// //     }
// //   } catch (e) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text('Error downloading template: $e'),
// //         backgroundColor: Colors.red,
// //       ),
// //     );
// //   }
// // }

//   Future<void> _uploadExcelFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['xlsx', 'xls'],
//       );

//       if (result != null) {
//         typed.Uint8List? bytes = result.files.first.bytes;
//         if (bytes != null) {
//           var excel = exl.Excel.decodeBytes(bytes);

//           setState(() {
//             uploadedData.clear();
//             uploadedFileName = result.files.first.name;
//           });

//           for (var table in excel.tables.keys) {
//             var sheet = excel.tables[table];
//             if (sheet != null) {
//               List<String> headers = [];
//               var firstRow = sheet.rows.first;
//               for (var cell in firstRow) {
//                 headers.add(cell?.value?.toString() ?? '');
//               }

//               for (int i = 1; i < sheet.rows.length; i++) {
//                 var row = sheet.rows[i];
//                 Map<String, dynamic> rowData = {};

//                 for (int j = 0; j < row.length && j < headers.length; j++) {
//                   var cellValue = row[j]?.value?.toString() ?? '';
//                   if (cellValue.isNotEmpty) {
//                     rowData[headers[j]] = cellValue;
//                   }
//                 }

//                 if (rowData.isNotEmpty) {
//                   uploadedData.add(rowData);
//                 }
//               }
//             }
//           }

//           // ScaffoldMessenger.of(context).showSnackBar(
//           //   SnackBar(
//           //     content: Text(
//           //         'File uploaded successfully! ${uploadedData.length} rows loaded.'),
//           //     backgroundColor: Colors.green,
//           //   ),
//           // );
//           _showExcelPreviewAndProcess();
//           // _convertToJson();
//         }
//       }
//     } catch (e) {
//       CustomToast.showToast(
//           context: context,
//           message: 'Error uploading file: $e',
//           backgroundColor: AppColors.redSecondaryColor);
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(
//       //     content: Text('Error uploading file: $e'),
//       //     backgroundColor: Colors.red,
//       //   ),
//       // );
//     }
//   }

//   void _showExcelPreviewAndProcess() {
//     if (uploadedData.isEmpty) {
//       CustomToast.showToast(
//           context: context,
//           message: 'No data to show!',
//           backgroundColor: AppColors.orangeSecondaryColor);
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(
//       //     content: Text('No data to show!'),
//       //     backgroundColor: Colors.orange,
//       //   ),
//       // );
//       return;
//     }

//     List<String> columns = uploadedData.first.keys.toList();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Excel Preview'),
//           content: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columns: columns.map((header) {
//                 return DataColumn(label: Text(header));
//               }).toList(),
//               rows: uploadedData.map((row) {
//                 return DataRow(
//                   cells: columns.map((header) {
//                     return DataCell(Text(row[header]?.toString() ?? ''));
//                   }).toList(),
//                 );
//               }).toList(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Close'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _convertToJson();

//                 ///-----------send json to backend --------------------
//               },
//               child: const Text('Process'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _convertToJson() {
//     if (uploadedData.isEmpty) {
//       CustomToast.showToast(
//           context: context,
//           message: 'No data to convert!',
//           backgroundColor: AppColors.orangeSecondaryColor);
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(
//       //     content: Text('No data to convert!'),
//       //     backgroundColor: Colors.orange,
//       //   ),
//       // );
//       return;
//     }

//     Map<String, dynamic> jsonData = {
//       'branch': _selectedService,
//       'serviceType': _selectedService,
//       'roundRobin': _roundRobinSelection,
//       'employee': _employeeController,
//       'uploadedAt': DateTime.now().toIso8601String(),
//       'fileName': uploadedFileName,
//       'totalRows': uploadedData.length,
//       'data': uploadedData,
//     };

//     String jsonString = JsonEncoder.withIndent('  ').convert(jsonData);

//     // showDialog(
//     //   context: context,
//     //   builder: (BuildContext context) {
//     //     return AlertDialog(
//     //       title:const  Text('JSON Data'),
//     //       content: SingleChildScrollView(
//     //         child: Text(
//     //           jsonString,
//     //           style: TextStyle(fontFamily: 'monospace', fontSize: 12),
//     //         ),
//     //       ),
//     //       actions: [
//     //         TextButton(
//     //           onPressed: () {
//     //             Navigator.of(context).pop();
//     //           },
//     //           child:const  Text('Close'),
//     //         ),
//     //         TextButton(
//     //           onPressed: () {
//     //             ScaffoldMessenger.of(context).showSnackBar(
//     //               const    SnackBar(
//     //                 content: Text('JSON data processed successfully!'),
//     //                 backgroundColor: Colors.green,
//     //               ),
//     //             );
//     //             Navigator.of(context).pop();
//     //           },
//     //           child: const Text('Process'),
//     //         ),
//     //       ],
//     //     );
//     //   },
//     // );
//   }
// }
