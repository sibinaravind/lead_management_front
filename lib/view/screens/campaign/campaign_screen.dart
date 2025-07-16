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
    Provider.of<CampaignProvider>(context, listen: false).getCampaignList();
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(width: 16),
                                Expanded(
                                  child: PopupTextField(
                                    requiredField: false,
                                    label: 'Title',
                                    controller: value.titleController,
                                    icon: Icons.grade,
                                    hint: 'e.g., Advertisement Campaign',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomDateField(
                                    label: 'Start Date',
                                    controller: value.startDateController,
                                  ),
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
                                value.addCampaign(
                                  docName: value.titleController.text.trim(),
                                  title: value.titleController.text.trim(),
                                  image64: value.file64 ?? "",
                                  startDate:
                                      value.startDateController.text.trim(),
                                );
                                Navigator.pop(context);
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
            Consumer<CampaignProvider>(
              builder: (context, value, child) => SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = constraints.maxWidth;

                        // Define how many cards per row based on screen width
                        int crossAxisCount = 2;
                        if (screenWidth > 1200) {
                          crossAxisCount = 4;
                        } else if (screenWidth > 800) {
                          crossAxisCount = 3;
                        } else {
                          crossAxisCount = 2;
                        }

                        // Control card height by adjusting childAspectRatio (width / height)
                        double childAspectRatio = 1.3;

                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: value.campaignModelList?.length ?? 0,
                          itemBuilder: (context, index) {
                            final CampaignModel campaign =
                                value.campaignModelList?.elementAt(index)
                                    as CampaignModel;

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: Image.network(
                                      "${Constant().featureBaseUrl}${campaign.image}",
                                      height:
                                          140, // Can adjust based on screen size if needed
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          const Center(
                                              child: Icon(Icons.broken_image)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              fontSize: 16,
                                              text: campaign.title ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Start Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(campaign.startDate ?? ""))}",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.edit,
                                                      size: 20),
                                                  onPressed: () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: CustomText(
                                                          text:
                                                              "Edit ${campaign.title}",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      size: 20),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          DeleteDialogue(
                                                        id: campaign.sId ?? "",
                                                        name: campaign.title ??
                                                            "",
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )),
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
