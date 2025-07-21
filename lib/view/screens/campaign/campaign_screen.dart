import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/campaign/campaign_provider.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import 'package:overseas_front_end/functions/pick_image.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../model/campaign/campaign_model.dart';
import '../../../res/style/colors/colors.dart';
import '../../widgets/custom_toast.dart';
import 'widget/delete_dialogue.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CampaignProvider>(context, listen: false).getCampaignList(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Consumer<CampaignProvider>(
                    builder: (context, value, child) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with icon and title
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    text: 'Add Campaign',
                                  ),
                                  const SizedBox(height: 4),
                                  CustomText(
                                    text: 'Enter your campaign details',
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Form content with enhanced styling
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PopupTextField(
                                  requiredField: false,
                                  label: 'Title',
                                  controller: value.titleController,
                                  icon: Icons.grade,
                                  hint: 'e.g., Advertisement Campaign',
                                ),
                                const SizedBox(height: 16),
                                CustomDateField(
                                  initialDate: DateTime.now()
                                      .subtract(Duration(days: 5)),
                                  label: 'Start Date',
                                  controller: value.startDateController,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: Image.memory(
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(),
                                base64Decode(
                                    value.file64?.split(",").last ?? ''),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                String? file64 = await FileUploadService()
                                    .pickAndCompressFileAsBase64();
                                value.file64 = file64;
                                value.previewFile();

                                // Navigator.pop(context);
                              },
                              icon: const Icon(Icons.upload),
                              label: const CustomText(text: "Upload Image"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Action buttons with enhanced styling
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: CustomText(
                                text: 'Cancel',
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                if (value.titleController.text.isEmpty ||
                                    value.startDateController.text.isEmpty ||
                                    (value.file64?.isEmpty ?? true)) {
                                  CustomToast.showToast(
                                      context: context,
                                      message:
                                          'All fields and image are required');
                                } else {
                                  value.addCampaign(
                                    context,
                                    docName: value.titleController.text.trim(),
                                    title: value.titleController.text.trim(),
                                    image64: value.file64 ?? "",
                                    startDate:
                                        value.startDateController.text.trim(),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 2,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  CustomText(
                                    text: 'Add Campaign',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Dialog(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   elevation: 8,
            //   child: ConstrainedBox(
            //     constraints: BoxConstraints(maxWidth: 600),
            //     child: Padding(
            //       padding: const EdgeInsets.all(16.0),
            //       child: SingleChildScrollView(
            //         child: Consumer<CampaignProvider>(
            //           builder: (context, value, child) => Column(
            //             mainAxisSize: MainAxisSize.min,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               CustomText(
            //                 text: "Add Campaign",
            //                 fontSize: 18,
            //               ),
            //               const SizedBox(height: 16),
            //               CustomTextField(
            //                 controller: value.titleController,
            //                 labelText: "Title",
            //                 validator: (value) {
            //                   return null;
            //                 },
            //               ),
            //               const SizedBox(height: 12),
            //               CustomDateField(
            //                 controller: value.startDateController,
            //                 label: "Start Date",
            //                 isRequired: true,
            //               ),
            //               const SizedBox(height: 12),
            //               Center(
            //                 child: Image.memory(
            //                   errorBuilder: (context, error, stackTrace) =>
            //                       Container(),
            //                   base64Decode(value.file64?.split(",").last ?? ''),
            //                   width: 200,
            //                   height: 200,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //               Center(
            //                 child: ElevatedButton.icon(
            //                   onPressed: () async {
            //                     String? file64 = await FileUploadService()
            //                         .pickAndCompressFileAsBase64();
            //                     value.file64 = file64;
            //                     value.previewFile();

            //                     // Navigator.pop(
            //                     // context); // Optionally close dialog after add
            //                   },
            //                   icon: const Icon(Icons.upload),
            //                   label: const CustomText(text: "Upload Image"),
            //                 ),
            //               ),
            //               const SizedBox(height: 16),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 children: [
            //                   TextButton(
            //                     onPressed: () => Navigator.pop(context),
            //                     child: const CustomText(text: "Cancel"),
            //                   ),
            //                   const SizedBox(width: 8),
            //                   ElevatedButton(
            //                     onPressed: () {
            //                       value.addCampaign(
            //                         docName: value.titleController.text.trim(),
            //                         title: value.titleController.text.trim(),
            //                         image64: value.file64 ?? "",
            //                         startDate:
            //                             value.startDateController.text.trim(),
            //                       );
            //                       Navigator.pop(context);
            //                       // Add any confirm action if needed
            //                       // For example, you could trigger the addCampaign here instead of in the upload button
            //                     },
            //                     child: const CustomText(text: "Save"),
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Container (fixed at top)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF123456),
                    Color(0xFF2196F3)
                  ], // Replace with your gradient colors
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.campaign,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          color: AppColors.backgroundColor,
                          text: "Campaign Management Dashboard",
                          fontSize: 20,
                        ),
                        const SizedBox(height: 4),
                        // Text(
                        //   "",
                        //   style: TextStyle(
                        //     color: Colors.white.withOpacity(0.9),
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Scrollable Grid Content
            Expanded(
              child: Consumer<CampaignProvider>(
                builder: (context, value, child) => LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;

                    // Enhanced responsive breakpoints
                    int crossAxisCount = 2;
                    double childAspectRatio = 0.85;

                    if (screenWidth > 1400) {
                      crossAxisCount = 5;
                      childAspectRatio = 0.6;
                    } else if (screenWidth > 1200) {
                      crossAxisCount = 4;
                      childAspectRatio = 0.6;
                    } else if (screenWidth > 900) {
                      crossAxisCount = 3;
                      childAspectRatio = 0.8;
                    } else if (screenWidth > 600) {
                      crossAxisCount = 2;
                      childAspectRatio = 0.85;
                    } else {
                      crossAxisCount = 1;
                      childAspectRatio = 1.2;
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600 ? 24 : 16,
                      ),
                      child: GridView.builder(
                        // Remove shrinkWrap and NeverScrollableScrollPhysics
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: screenWidth > 600 ? 20 : 16,
                          mainAxisSpacing: screenWidth > 600 ? 24 : 16,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemCount: value.campaignModelList?.length ?? 0,
                        itemBuilder: (context, index) {
                          final CampaignModel campaign = value.campaignModelList
                              ?.elementAt(index) as CampaignModel;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                              shadowColor: Colors.black.withOpacity(0.1),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      Colors.grey.shade50,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 20,
                                      offset: const Offset(0, 4),
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 40,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      // Handle card tap
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Enhanced Image Container
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                  child: Image.network(
                                                    "${Constant().featureBaseUrl}${campaign.image}",
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Colors
                                                                .grey.shade300,
                                                            Colors
                                                                .grey.shade100,
                                                          ],
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons
                                                              .image_not_supported_outlined,
                                                          size: 40,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Status Badge
                                                Positioned(
                                                  top: 12,
                                                  right: 12,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.green.shade400,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.green
                                                              .withOpacity(0.3),
                                                          blurRadius: 8,
                                                          offset: const Offset(
                                                              0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Text(
                                                      "Active",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Enhanced Content Section
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Title
                                                Expanded(
                                                  child: CustomText(
                                                    fontSize: screenWidth > 600
                                                        ? 16
                                                        : 14,
                                                    text: campaign.title ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),

                                                // Date with Icon
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.blue.shade50,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Icon(
                                                        Icons.calendar_today,
                                                        size: 12,
                                                        color: Colors
                                                            .blue.shade600,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        DateFormat(
                                                                "dd MMM yyyy")
                                                            .format(
                                                          DateTime.parse(campaign
                                                                  .startDate ??
                                                              ""),
                                                        ),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .red.shade50,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .delete_outline,
                                                              size: 18,
                                                              color: Colors
                                                                  .red.shade600,
                                                            ),
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        DeleteDialogue(
                                                                  id: campaign
                                                                          .sId ??
                                                                      "",
                                                                  name: campaign
                                                                          .title ??
                                                                      "",
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(height: 12),

                                                // Action Buttons
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 // showDialog(
                                          //   context: context,
                                          //   builder: (context) => Dialog(
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(12),
                                          //     ),
                                          //     elevation: 8,
                                          //     child: Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(16.0),
                                          //       child: SingleChildScrollView(
                                          //         child: Consumer<
                                          //             CampaignProvider>(
                                          //           builder: (context, value,
                                          //                   child) =>
                                          //               Column(
                                          //             mainAxisSize:
                                          //                 MainAxisSize.min,
                                          //             crossAxisAlignment:
                                          //                 CrossAxisAlignment
                                          //                     .start,
                                          //             children: [
                                          //               Text(
                                          //                 "Edit Campaign",
                                          //                 style:
                                          //                     Theme.of(context)
                                          //                         .textTheme
                                          //                         .displayLarge,
                                          //               ),
                                          //               const SizedBox(
                                          //                   height: 16),
                                          //               CustomTextField(
                                          //                 controller: value
                                          //                     .titleController,
                                          //                 labelText: "Title",
                                          //                 validator: (_) {},
                                          //               ),
                                          //               Image.network(
                                          //                 "${Constant().featureBaseUrl}${campaign.image}",
                                          //                 height:
                                          //                     200, // adjust as needed
                                          //                 width:
                                          //                     double.infinity,
                                          //                 fit: BoxFit.cover,
                                          //                 errorBuilder: (context,
                                          //                         error,
                                          //                         stackTrace) =>
                                          //                     const Center(
                                          //                         child: Icon(Icons
                                          //                             .broken_image)),
                                          //               ),
                                          //               const SizedBox(
                                          //                   height: 12),
                                          //               CustomDateField(
                                          //                 controller: value
                                          //                     .startDateController,
                                          //                 label: "Start Date",
                                          //                 isRequired: true,
                                          //               ),
                                          //               const SizedBox(
                                          //                   height: 12),
                                          //               ElevatedButton.icon(
                                          //                 onPressed: () async {
                                          //                   String? file64 =
                                          //                       await FileUploadService()
                                          //                           .pickAndCompressFileAsBase64();
                                          //                   value.file64 =
                                          //                       file64;

                                          //                   // Navigator.pop(
                                          //                   // context); // Optionally close dialog after add
                                          //                 },
                                          //                 icon: const Icon(
                                          //                     Icons.upload),
                                          //                 label: const Text(
                                          //                     "Upload Image"),
                                          //                 style: ElevatedButton
                                          //                     .styleFrom(
                                          //                   minimumSize:
                                          //                       const Size
                                          //                           .fromHeight(
                                          //                           48),
                                          //                 ),
                                          //               ),
                                          //               const SizedBox(
                                          //                   height: 16),
                                          //               Row(
                                          //                 mainAxisAlignment:
                                          //                     MainAxisAlignment
                                          //                         .end,
                                          //                 children: [
                                          //                   TextButton(
                                          //                     onPressed: () =>
                                          //                         Navigator.pop(
                                          //                             context),
                                          //                     child: const Text(
                                          //                         "Cancel"),
                                          //                   ),
                                          //                   const SizedBox(
                                          //                       width: 8),
                                          //                   ElevatedButton(
                                          //                     onPressed: () {
                                          //                       value
                                          //                           .addCampaign(
                                          //                         docName: value
                                          //                             .titleController
                                          //                             .text
                                          //                             .trim(),
                                          //                         title: value
                                          //                             .titleController
                                          //                             .text
                                          //                             .trim(),
                                          //                         image64: value
                                          //                                 .file64 ??
                                          //                             "",
                                          //                         startDate: value
                                          //                             .startDateController
                                          //                             .text
                                          //                             .trim(),
                                          //                       );
                                          //                       Navigator.pop(
                                          //                           context);
                                          //                       // Add any confirm action if needed
                                          //                       // For example, you could trigger the addCampaign here instead of in the upload button
                                          //                     },
                                          //                     child: const Text(
                                          //                         "Save"),
                                          //                   ),
                                          //                 ],
                                          //               )
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // );


          // showDialog(
          //     context: context,
          //     builder: (context) => Dialog(
          //           child: Consumer<CampaignProvider>(
          //             builder: (context, value, child) => Column(
          //               children: [
          //                 CustomTextField(
          //                     controller: value.titleController,
          //                     labelText: "Title",
          //                     validator: (_) {}),
          //                 CustomDateField(
          //                   controller: value.startDateController,
          //                   label: "Start Date",
          //                   isRequired: true,
          //                 ),
          //                 Consumer<CampaignProvider>(
          //                   builder: (context, value, child) => ElevatedButton(
          //                       onPressed: () async {
          //                         String? file64 = await FileUploadService()
          //                             .pickAndCompressFileAsBase64();
          //                         value.addCampaign(
          //                             docName:
          //                                 value.titleController.text.trim(),
          //                             title: value.titleController.text.trim(),
          //                             image64: file64 ?? "",
          //                             startDate: value.startDateController.text
          //                                 .trim());
          //                       },
          //                       child: CustomText(
          //                         text: "Image Upload",
          //                       )),
          //                 )
          //                 // CustomTextField(
          //                 //     controller: value.titleController,
          //                 //     labelText: "Doc Name",
          //                 //     validator: (_) {}),
          //               ],
          //             ),
          //           ),
          //         ));

           // const SizedBox(height: 16),
            // CustomTextField(
            //   validator: (p0) {},
            //   controller: _controller,
            //   labelText: "Campaign text",
            // ),
            // const SizedBox(height: 16),
            // Consumer<CampaignProvider>(
            //   builder: (context, value, child) => ElevatedButton(
            //       onPressed: () {
            //         value.uploadImage();
            //       },
            //       child: Text("Select Campaign image")),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // _isLoading
            //     ? const CircularProgressIndicator()
            //     : ElevatedButton.icon(
            //         onPressed: () {},
            //         icon: const Icon(Icons.cloud_upload),
            //         label: const Text("Upload"),
            //       ),
            // const SizedBox(height: 16),
            // if (_responseMessage != null)
            //   Text(
            //     _responseMessage!,
            //     style: TextStyle(
            //       color: _responseMessage!.startsWith("Success")
            //           ? Colors.green
            //           : Colors.red,
            //     ),
            //   ),


                  // child: ListView.builder(
                  //   padding: const EdgeInsets.all(12),
                  //   itemCount: value.campaignModel?.data?.length ?? 0,
                  //   itemBuilder: (context, index) {
                  //     final Data campaign =
                  //         (value.campaignModel?.data?.elementAt(index) ?? [])
                  //             as Data;
                  //     return Card(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(16)),
                  //       margin: const EdgeInsets.only(bottom: 12),
                  //       elevation: 4,
                  //       child: Column(
                  //         children: [
                  //           ClipRRect(
                  //             borderRadius: const BorderRadius.vertical(
                  //                 top: Radius.circular(16)),
                  //             child: Image.network(
                  //               errorBuilder: (context, error, stackTrace) =>
                  //                   CircularProgressIndicator(),
                  //               "${Constant().featureBaseUrl}${campaign.image}", // control size
                  //               height: 180,
                  //               width: double.infinity,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(12),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 CustomText(
                  //                   text: campaign.title ?? "",
                  //                 ),
                  //                 const SizedBox(height: 4),
                  //                 // CustomText(
                  //                 //   text: "Status: ${campaign.}",
                  //                 // ),
                  //                 const SizedBox(height: 2),
                  //                 CustomText(
                  //                   text: "Start Date: ${campaign.startDate}",
                  //                 ),
                  //                 const SizedBox(height: 8),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.end,
                  //                   children: [
                  //                     TextButton.icon(
                  //                       onPressed: () {
                  //                         // TODO: Implement edit action
                  //                         ScaffoldMessenger.of(context)
                  //                             .showSnackBar(
                  //                           SnackBar(
                  //                               content: CustomText(
                  //                                   text:
                  //                                       "Edit ${campaign.title}")),
                  //                         );
                  //                       },
                  //                       icon: const Icon(Icons.edit, size: 18),
                  //                       label: const CustomText(text: "Edit"),
                  //                     ),
                  //                     const SizedBox(width: 8),
                  //                     TextButton.icon(
                  //                       onPressed: () {
                  //                         Provider.of<CampaignProvider>(context,
                  //                                 listen: false)
                  //                             .deleteCampaign(value
                  //                                     .campaignModel?.data
                  //                                     ?.elementAt(index)
                  //                                     .sId ??
                  //                                 "");
                  //                         ScaffoldMessenger.of(context)
                  //                             .showSnackBar(
                  //                           SnackBar(
                  //                               content: CustomText(
                  //                                   text:
                  //                                       "Delete ${campaign.title}")),
                  //                         );
                  //                       },
                  //                       icon: const Icon(Icons.delete, size: 18),
                  //                       label: const CustomText(text: "Delete"),
                  //                     ),
                  //                   ],
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
