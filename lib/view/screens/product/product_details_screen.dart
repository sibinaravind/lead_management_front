import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../controller/product_controller/product_controller.dart';
import 'add_edit_product_screen.dart';
import 'widget/product_details_tab.dart';
import 'widget/product_eligibility_tab.dart';
import 'widget/product_price_tab.dart';
import 'widget/product_basic_info.dart';
import 'widget/product_images_tab.dart';
import 'widget/product_provider_tab.dart';

class ProductProfileScreen extends StatefulWidget {
  const ProductProfileScreen({
    super.key,
    required this.productid,
  });

  final String productid;

  @override
  State<ProductProfileScreen> createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen> {
  int _selectedTabIndex = 0;
  final productController = Get.find<ProductController>();
  List<Map<String, dynamic>> _tabs = [];

  @override
  void initState() {
    super.initState();
    _initializeTabs();
  }

  Future<void> _initializeTabs() async {
    await productController.getProductDetails(context, widget.productid);
    _tabs = [
      {
        'icon': Icons.info_outline,
        'label': 'Basic Info',
        'widget': ProductBasicInfoTab(
            product: productController.productDetails.value),
      },
      {
        'icon': Icons.description_outlined,
        'label': 'Details',
        'widget': ProductCategoryDetailsDisplayTab(
            product: productController.productDetails.value),
      },
      {
        'icon': Icons.attach_money,
        'label': 'Pricing',
        'widget': ProductPricingTab(
          product: productController.productDetails.value,
        ),
      },
      {
        'icon': Icons.verified_user,
        'label': 'Eligibility',
        'widget': ProductEligibilityDisplayTab(
          product: productController.productDetails.value,
        ),
      },
      {
        'icon': Icons.image_outlined,
        'label': 'Images',
        'widget': ProductImagesTab(
          productId: widget.productid,
        ),
      },
      {
        'icon': Icons.store,
        'label': 'Provider Details',
        'widget': ProductProviderTab(
            provider: productController.productDetails.value),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      backgroundColor: AppColors.backgroundColor,
      child: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.primaryColor,
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: productController.productDetails.value.name ??
                          'Product Profile',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: PopupMenuButton<String>(
                        elevation: 8,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 24,
                        ),
                        onSelected: (value) {
                          if (value == 'edit_lead') {
                            showDialog(
                              context: context,
                              builder: (context) => AddProductScreen(
                                productToEdit:
                                    productController.productDetails.value,
                              ),
                            );
                          } else if (value == 'update_status') {
                            // showDialog(
                            //   context: context,
                            //   builder: (context) => StatusUpdatePopup(
                            //     clientId:
                            //         profileController.leadDetails.value.id ??
                            //             '',
                            //   ),
                            // );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit_lead',
                            child: Row(
                              children: const [
                                Icon(Icons.edit,
                                    size: 20,
                                    color: AppColors.redSecondaryColor),
                                SizedBox(width: 10),
                                CustomText(
                                  text: 'Edit Lead',
                                ),
                              ],
                            ),
                          ),
                          // PopupMenuItem(
                          //   value: 'update_status',
                          //   child: Row(
                          //     children: const [
                          //       Icon(Icons.update,
                          //           size: 20,
                          //           color: AppColors.greenSecondaryColor),
                          //       SizedBox(width: 10),
                          //       CustomText(
                          //         text: 'Update Status',
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),
              productController.productDetails.value.id == null
                  ? Expanded(
                      child: Center(
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (_, __) => CustomShimmerWidget(
                            height: 100,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: isDesktop ? _desktopLayout() : _mobileLayout(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  /// Desktop Layout (Left Tabs + Right Content)
  Widget _desktopLayout() {
    return Row(
      children: [
        Container(
          width: 260,
          color: AppColors.primaryColor,
          child: ListView.builder(
            itemCount: _tabs.length,
            itemBuilder: (_, index) {
              final isSelected = _selectedTabIndex == index;
              return ListTile(
                leading: Icon(
                  _tabs[index]['icon'],
                  color: isSelected ? Colors.white : Colors.white38,
                ),
                title: CustomText(
                  text: _tabs[index]['label'],
                  color: isSelected ? Colors.white : Colors.white38,
                ),
                selected: isSelected,
                onTap: () => setState(() => _selectedTabIndex = index),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: _tabs[_selectedTabIndex]['widget'],
          ),
        ),
      ],
    );
  }

  /// Mobile Layout (Horizontal Tabs)
  Widget _mobileLayout() {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _tabs.length,
            itemBuilder: (_, index) {
              final isSelected = _selectedTabIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedTabIndex = index),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                  ),
                  child: Row(
                    children: [
                      Icon(_tabs[index]['icon'],
                          size: 18,
                          color: isSelected
                              ? Colors.white
                              : AppColors.primaryColor),
                      const SizedBox(width: 6),
                      CustomText(
                        text: _tabs[index]['label'],
                        color:
                            isSelected ? Colors.white : AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: _tabs[_selectedTabIndex]['widget'],
          ),
        ),
      ],
    );
  }
}
