import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overseas_front_end/view/widgets/popup_profile_upload_widget.dart';

import '../../../../model/lead/lead_model.dart';
import '../../../widgets/enhanced_switchtile_and_textfield.dart';

class DocumentTab extends StatefulWidget {
  LeadModel? leadModel;
  DocumentTab({super.key, this.leadModel});

  @override
  State<DocumentTab> createState() => _DocumentTabState();
}

class _DocumentTabState extends State<DocumentTab> {
  List<bool> switchStatus = [];
  List<bool> pdfStatus = [];

  List documents = [
    'Passport',
    'SSLC',
    'Plus Two',
    'Degree Level Certificate',
    'Masters Level Certificate',
    'Passport',
    'SSLC',
    'Plus Two',
    'Degree Level Certificate',
    'Masters Level Certificate',
  ];
  // Uint8List? imageBytes;
  bool pdf = false;
  @override
  void initState() {
    // imageBytes = widget.initialImageBytes;
    switchStatus = List.filled(documents.length, false);
    pdfStatus = List.filled(documents.length, false);
    super.initState();
  }

  bool tenthCertificate = false;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        pdf = true;
      });
      // setState(() => imageBytes = bytes);
      // widget.onImageChanged?.call(bytes);
    }
  }

  Future<void> _onpress() async {}

  // void _removeImage() {
  //   setState(() => imageBytes = null);
  //   widget.onImageChanged?.call(null);
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          // child: Column(
          //   spacing: 10,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     EnhancedSwitchTileWithButton(
          //         label: "Passport",
          //         icon: Icons.list_alt_rounded,
          //         value:tenthCertificate ,
          //         onChanged: (value){
          //      setState(() {
          //        tenthCertificate=value;
          //      });
          //    },
          //       visibleButton: tenthCertificate,
          //       onPressed: _showRecordDialog,
          //       hasPdf: pdf,
          //
          //    ),
          //     EnhancedSwitchTileWithButton(
          //       label: "SSLC",
          //       icon: Icons.list_alt_rounded,
          //       value:tenthCertificate ,
          //       onChanged: (value){
          //         setState(() {
          //           tenthCertificate=value;
          //         });
          //       },
          //       visibleButton: tenthCertificate,
          //       onPressed: _showRecordDialog,
          //       hasPdf: pdf,
          //
          //     ),
          //     EnhancedSwitchTileWithButton(
          //       label: "SSLC",
          //       icon: Icons.list_alt_rounded,
          //       value:tenthCertificate ,
          //       onChanged: (value){
          //         setState(() {
          //           tenthCertificate=value;
          //         });
          //       },
          //       visibleButton: tenthCertificate,
          //       onPressed: _showRecordDialog,
          //       hasPdf: pdf,
          //
          //     ),
          //
          //   ],
          // ),
          child: SingleChildScrollView(
            child: Column(
              // spacing: 10,
              children: List.generate(documents.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 5, bottom: 5),
                  child: EnhancedSwitchTileWithButton(
                    label: documents[index],
                    icon: Icons.list_alt_rounded,
                    value: switchStatus[index],
                    onChanged: (value) {
                      setState(() {
                        switchStatus[index] = value;
                      });
                    },
                    visibleButton: switchStatus[index],
                    onPressed: () => _showRecordDialog(index),
                    hasPdf: pdfStatus[index],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _showRecordDialog(int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Container(
            height: 350,
            width: 250,
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                ),
                const PopupProfileUploadWidget(
                  title: 'Upload Document',
                ),
              ],
            )),
      ),
    );
  }
}
