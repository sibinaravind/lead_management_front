import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/custom_action_button.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import 'info_item.dart';
import 'product_intrested_popup.dart';

class ProductInterestedTab extends StatelessWidget {
  final LeadModel lead;
  const ProductInterestedTab({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            int columnsCount = availableWidth > 900
                ? 3
                : availableWidth > 600
                    ? 2
                    : 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  title: "Products Interested",
                  icon: Icons.shopping_bag_rounded,
                  tail: SizedBox(
                    width: 180,
                    // height: 35,
                    child: CustomActionButton(
                      text: 'Add  Interested',
                      icon: Icons.add_rounded,
                      textColor: AppColors.violetPrimaryColor,
                      // gradient: AppColors.greenGradient,
                      // backgroundColor: AppColors.blueSecondaryColor,
                      // isFilled: true,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ProductInterestedPopup(
                              // initialProducts:
                              //     lead.productInterested ?? <ProductItem>[],
                              clientId: lead.id,
                            );
                          },
                        );
                      },
                      // gradient: AppColors.greenGradient,
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                if (lead.productInterested == null ||
                    lead.productInterested!.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "No products found",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Products Customer are interested in will appear here.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...lead.productInterested!.map((product) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 0.8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // PRODUCT NAME
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.productName ?? "Unnamed Product",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ProductInterestedPopup(
                                        clientId: lead.id,
                                        productId: product.productId,
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.add_box_outlined,
                                    size: 30, color: Colors.orange),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // OFFERS LIST
                          if (product.offers == null || product.offers!.isEmpty)
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                "No offers available",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            )
                          else
                            ...product.offers!.map((offer) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 0.7),
                                ),
                                child: ResponsiveGrid(
                                  columns: columnsCount,
                                  // gap: 10,
                                  children: [
                                    InfoItem(
                                      label: "Offer Price",
                                      value:
                                          offer.offerPrice?.toString() ?? "N/A",
                                      icon: Icons.currency_rupee_rounded,
                                      iconColor: AppColors.greenSecondaryColor,
                                    ),
                                    InfoItem(
                                      label: "Demanding Price",
                                      value: offer.demandingPrice?.toString() ??
                                          "N/A",
                                      icon: Icons.request_quote_rounded,
                                      iconColor: AppColors.orangeSecondaryColor,
                                    ),
                                    InfoItem(
                                      label: "Uploaded At",
                                      value: offer.uploadedAt ?? "N/A",
                                      icon: Icons.calendar_today_rounded,
                                      iconColor: AppColors.blueSecondaryColor,
                                    ),
                                    InfoItem(
                                      label: "Description",
                                      value: offer.description ?? "N/A",
                                      icon: Icons.description_rounded,
                                      iconColor: AppColors.redSecondaryColor,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    );
                  }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
