import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../controller/customer_profile/customer_profile_controller.dart';
import '../../../../controller/product_controller/product_controller.dart';
import '../../../../model/lead/product_intreseted_model.dart';
import '../../../../model/lead/product_offered_model.dart';
import '../../../../model/product/product_model.dart';
import '../../../widgets/custom_product_dropdown.dart';

class ProductInterestedPopup extends StatefulWidget {
  final String? clientId;
  final String? productId;
  const ProductInterestedPopup({super.key, this.clientId, this.productId});

  @override
  State<ProductInterestedPopup> createState() => _ProductInterestedPopupState();
}

class _ProductInterestedPopupState extends State<ProductInterestedPopup> {
  final productController = Get.find<ProductController>();

  ProductModel? selectedProduct;
  ProductOfferedModel? offers = ProductOfferedModel();

  Future<void> saveData() async {
    if (selectedProduct == null || offers == null) {
      Get.snackbar(
          "Error", "Please select a product and add at least one offer");
      return;
    }
    final savedData = ProductInterestedModel(
      productId: selectedProduct?.id,
      productName: selectedProduct?.name,
      offers: [
        offers ?? ProductOfferedModel(),
      ],
    );
    // showLoaderDialog(context);
    await Get.find<CustomerProfileController>().addProductInterest(
        context: context,
        clientId: widget.clientId,
        productInterested: savedData);
    // Navigator.pop(context);
    // Navigator.pop(context);
  }

  @override
  initState() {
    super.initState();
    productController.fetchProducts();
    if (widget.productId != null) {
      final matchedProduct = productController.products.firstWhereOrNull(
        (product) => product.id == widget.productId,
      );
      if (matchedProduct != null) {
        selectedProduct = matchedProduct;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productList = productController.products;

    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Products Interested",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 🔥 Product Selector
            if (widget.productId == null)
              CustomProductDropDown(
                label: "Select Product",
                products: productList,
                selectedProduct: selectedProduct,
                onChanged: (value) {
                  setState(() => selectedProduct = value);
                },
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomText(
                  text: selectedProduct?.name ?? 'Selected Product',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Negotiation Offer",
                      color: AppColors.darkOrangeColour,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    const SizedBox(height: 13),
                    CustomTextFormField(
                      label: "Offered Price",
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.currency_rupee,
                      onChanged: (value) {
                        offers?.offerPrice = int.tryParse(value) ?? 0;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      label: "Demanding Price",
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.currency_rupee,
                      onChanged: (value) {
                        offers?.demandingPrice = int.tryParse(value) ?? 0;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      label: "Description",
                      maxLines: 2,
                      onChanged: (value) {
                        offers?.description = value;
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),
            CustomActionButton(
              text: 'ADD',
              icon: Icons.add,
              onPressed: () async {
                await saveData();
              },
              isFilled: true,
              gradient: AppColors.orangeGradient,
            ),
          ],
        ),
      ),
    );
  }
}

// class ProductInterestedPopup extends StatefulWidget {
//   final String? productId;
//   final Function(List<Map<String, dynamic>>) onSave;

//   const ProductInterestedPopup({
//     super.key,
//     this.productId,
//     required this.onSave,
//   });

//   @override
//   State<ProductInterestedPopup> createState() => _ProductInterestedPopupState();
// }

// class _ProductInterestedPopupState extends State<ProductInterestedPopup> {
//   List<ProductItem> _products = [];
//   final _formKey = GlobalKey<FormState>();
//   final productController = Get.find<ProductController>();

//   @override
//   void initState() {
//     super.initState();
//     _initializeProducts();
//     _products = productController.products;
//   }

//   void _initializeProducts() {
//     if (_products.isEmpty) {
//       _addProduct();
//     }
//   }

//   void _addProduct() {
//     setState(() {
//       _products.add(ProductItem(
//         productId: '',
//         productName: '',
//         offers: [],
//       ));
//     });
//   }

//   void _removeProduct(int index) {
//     if (_products.length > 1) {
//       setState(() {
//         _products.removeAt(index);
//       });
//     }
//   }

//   void _addOffer(int productIndex) {
//     setState(() {
//       _products[productIndex].offers.add(OfferItem(
//             offerPrice: 0.0,
//             demandingPrice: 0.0,
//             description: '',
//             updatedBy: '',
//             status: 'active',
//             uploadedAt: DateTime.now().toIso8601String(),
//           ));
//     });
//   }

//   void _removeOffer(int productIndex, int offerIndex) {
//     setState(() {
//       _products[productIndex].offers.removeAt(offerIndex);
//     });
//   }

//   Future<void> _saveProducts() async {
//     if (_formKey.currentState!.validate()) {
//       final List<Map<String, dynamic>> productsList = _products
//           .where((product) =>
//               product.productId.isNotEmpty || product.productName.isNotEmpty)
//           .map((product) {
//         return {
//           'product_id': product.productId,
//           'product_name': product.productName,
//           'offers': product.offers.map((offer) {
//             return {
//               'offer_price': offer.offerPrice,
//               'demanding_price': offer.demandingPrice,
//               'description': offer.description,
//               'updated_by': offer.updatedBy,
//               'status': offer.status,
//               'uploaded_at': offer.uploadedAt,
//             };
//           }).toList(),
//         };
//       }).toList();

//       widget.onSave(productsList);
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: 800,
//         constraints: const BoxConstraints(maxHeight: 700),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 20,
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Header
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.shopping_bag_rounded,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Text(
//                         'Products Interested',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                   ],
//                 ),
//               ),

//               // Content
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       // Product List
//                       ..._products.asMap().entries.map((entry) {
//                         final index = entry.key;
//                         final product = entry.value;
//                         return _buildProductCard(index, product);
//                       }).toList(),

//                       // Add Product Button
//                       Container(
//                         margin: const EdgeInsets.only(top: 16),
//                         child: CustomActionButton(
//                           text: 'Add Another Product',
//                           icon: Icons.add,
//                           onPressed: _addProduct,
//                           backgroundColor:
//                               AppColors.primaryColor.withOpacity(0.1),
//                           textColor: AppColors.primaryColor,
//                           borderColor: AppColors.primaryColor.withOpacity(0.3),
//                         ),
//                       ),

//                       const SizedBox(height: 32),

//                       // Save Button
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomActionButton(
//                               text: 'Cancel',
//                               icon: Icons.close,
//                               onPressed: () => Navigator.of(context).pop(),
//                               textColor: Colors.grey,
//                               borderColor: Colors.grey.shade300,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: CustomActionButton(
//                               text: 'Save Products',
//                               icon: Icons.save,
//                               isFilled: true,
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color(0xFF7F00FF),
//                                   Color(0xFFE100FF),
//                                 ],
//                               ),
//                               onPressed: _saveProducts,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProductCard(int productIndex, ProductItem product) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 20),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Product ${productIndex + 1}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 if (_products.length > 1)
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _removeProduct(productIndex),
//                     tooltip: 'Remove Product',
//                   ),
//               ],
//             ),

//             const SizedBox(height: 16),

//             // Product Details
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'Product ID *',
//                     controller: TextEditingController(text: product.productId),
//                     onChanged: (value) {
//                       setState(() {
//                         _products[productIndex].productId = value;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter product ID';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'Product Name *',
//                     controller:
//                         TextEditingController(text: product.productName),
//                     onChanged: (value) {
//                       setState(() {
//                         _products[productIndex].productName = value;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter product name';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // Offers Section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Offers',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add, color: AppColors.primaryColor),
//                   onPressed: () => _addOffer(productIndex),
//                   tooltip: 'Add Offer',
//                 ),
//               ],
//             ),

//             // Offers List
//             if (product.offers.isNotEmpty) ...[
//               const SizedBox(height: 12),
//               ...product.offers.asMap().entries.map((offerEntry) {
//                 final offerIndex = offerEntry.key;
//                 final offer = offerEntry.value;
//                 return _buildOfferCard(productIndex, offerIndex, offer);
//               }).toList(),
//             ],

//             if (product.offers.isEmpty)
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'No offers added. Click + to add an offer.',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOfferCard(int productIndex, int offerIndex, OfferItem offer) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       color: Colors.grey.shade50,
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Offer ${offerIndex + 1}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red, size: 18),
//                   onPressed: () => _removeOffer(productIndex, offerIndex),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 8),

//             // Offer Details
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'Offer Price *',
//                     controller: TextEditingController(
//                         text: offer.offerPrice.toString()),
//                     keyboardType: TextInputType.number,
//                     prefixIcon: Icons.currency_rupee,
//                     onChanged: (value) {
//                       setState(() {
//                         _products[productIndex].offers[offerIndex].offerPrice =
//                             double.tryParse(value) ?? 0.0;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter offer price';
//                       }
//                       if (double.tryParse(value) == null) {
//                         return 'Please enter valid price';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'Demanding Price',
//                     controller: TextEditingController(
//                         text: offer.demandingPrice.toString()),
//                     keyboardType: TextInputType.number,
//                     prefixIcon: Icons.currency_rupee,
//                     onChanged: (value) {
//                       setState(() {
//                         _products[productIndex]
//                             .offers[offerIndex]
//                             .demandingPrice = double.tryParse(value) ?? 0.0;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             // Status and Updated By
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomDropdownField(
//                     label: 'Status',
//                     value: offer.status,
//                     items: const ['active', 'inactive', 'expired', 'pending'],
//                     onChanged: (value) {
//                       setState(() {
//                         _products[productIndex].offers[offerIndex].status =
//                             value ?? 'active';
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'Updated By *',
//                     controller: TextEditingController(text: offer.updatedBy),
//                     onChanged: (value) {
//                       setState(() {
//                         _products[productIndex].offers[offerIndex].updatedBy =
//                             value;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter updated by';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             // Description
//             CustomTextFormField(
//               label: 'Description',
//               controller: TextEditingController(text: offer.description),
//               maxLines: 2,
//               onChanged: (value) {
//                 setState(() {
//                   _products[productIndex].offers[offerIndex].description =
//                       value;
//                 });
//               },
//             ),

//             const SizedBox(height: 8),

//             // Uploaded At
//             CustomTextFormField(
//               label: 'Uploaded At',
//               controller: TextEditingController(text: offer.uploadedAt),
//               readOnly: true,
//               prefixIcon: Icons.calendar_today,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Data Models
// class ProductItem {
//   String productId;
//   String productName;
//   List<OfferItem> offers;

//   ProductItem({
//     required this.productId,
//     required this.productName,
//     required this.offers,
//   });
// }

// class OfferItem {
//   double offerPrice;
//   double demandingPrice;
//   String description;
//   String updatedBy;
//   String status;
//   String uploadedAt;

//   OfferItem({
//     required this.offerPrice,
//     required this.demandingPrice,
//     required this.description,
//     required this.updatedBy,
//     required this.status,
//     required this.uploadedAt,
//   });
// }
