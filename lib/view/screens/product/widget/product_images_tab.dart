import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../controller/product_controller/product_controller.dart';
import '../../../../core/shared/constants.dart';
import '../../../widgets/upload_document_popup.dart';

class ProductImagesTab extends StatelessWidget {
  final String productId;

  const ProductImagesTab({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Product Documents',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12),

        /// Image Grid
        Obx(
          () => Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount:
                  (productController.productDetails.value.images?.length ?? 0) +
                      1,
              itemBuilder: (context, index) {
                if (index ==
                    (productController.productDetails.value.images?.length ??
                        0)) {
                  return _addImageCard(context);
                }
                return _imageCard(
                    productController.productDetails.value.images?[index] ?? '',
                    context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageCard(String url, BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: Constant().featureBaseUrl + url,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
            placeholder: (context, url) => CustomShimmerWidget(
              width: double.maxFinite,
              height: double.maxFinite,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Positioned(
          right: 6,
          top: 6,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Image'),
                  content: const Text(
                      'Are you sure you want to delete this image? This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.find<ProductController>().deleteProductImage(body: {
                          'url': url,
                        }, context: context, productId: productId);
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.black54,
              child: Icon(Icons.delete, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addImageCard(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return UploadDocumentPopup(
              // initialProducts:
              //     lead.productInterested ?? <ProductItem>[],
              onSave: (documents) {
                Get.find<ProductController>().uploadImage(
                    productId: productId, body: documents, context: context);
              },
              allowMultiple: false,
              onlyImages: true,
              noDocType: true,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: const Center(
          child: Icon(Icons.add_a_photo, size: 30),
        ),
      ),
    );
  }
}
