import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/campaign_provider.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CampaignSccreen extends StatefulWidget {
  CampaignSccreen({super.key});

  @override
  State<CampaignSccreen> createState() => _CampaignSccreenState();
}

class _CampaignSccreenState extends State<CampaignSccreen> {
  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;

  String? _responseMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        const Text(
                          "Campaign Management Dashboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
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
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: campaigns.length,
                itemBuilder: (context, index) {
                  final campaign = campaigns[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 4,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: Image.network(
                            "${campaign["campaignImage"]}?w=600", // control size
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                campaign["campaignText"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Status: ${campaign["status"]}",
                                style: TextStyle(
                                  color: campaign["status"] == "active"
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Start Date: ${campaign["startDate"]}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      // TODO: Implement edit action
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Edit ${campaign["campaignText"]}")),
                                      );
                                    },
                                    icon: const Icon(Icons.edit, size: 18),
                                    label: const Text("Edit"),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    onPressed: () {
                                      // TODO: Implement delete action
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Delete ${campaign["campaignText"]}")),
                                      );
                                    },
                                    icon: const Icon(Icons.delete, size: 18),
                                    label: const Text("Delete"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> campaigns = [
    {
      "campaignText": "Summer Migration Offer",
      "campaignImage":
          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
      "status": "active",
      "startDate": "2025-07-05"
    },
    {
      "campaignText": "Early Bird Visa Discount",
      "campaignImage":
          "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
      "status": "inactive",
      "startDate": "2025-07-10"
    },
    {
      "campaignText": "Exclusive Partner Program",
      "campaignImage":
          "https://images.unsplash.com/photo-1493246507139-91e8fad9978e",
      "status": "inactive",
      "startDate": "2025-06-01"
    },
    {
      "campaignText": "Student Migration Support",
      "campaignImage":
          "https://images.unsplash.com/photo-1470770841072-f978cf4d019e",
      "status": "active",
      "startDate": "2025-07-01"
    },
    {
      "campaignText": "Family Migration Special",
      "campaignImage":
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
      "status": "active",
      "startDate": "2025-07-15"
    }
  ];
}
