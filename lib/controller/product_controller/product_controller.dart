import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import '../../core/services/api_service.dart';
import '../../model/product/product_model.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();
  RxString itemsPerPage = "10".obs;
  RxInt currentPage = 0.obs;
  RxString? error;
  RxBool isLoading = false.obs;
  RxString? responseId;

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  Map<String, dynamic> filter = {};
  String? selectedVacancyId;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    // Only load if there are products returned
    if (products.isNotEmpty) {
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
        endpoint: Constant().productList,
        fromJson: (json) =>
            List<ProductModel>.from(json.map((e) => ProductModel.fromJson(e))),
      );

      response.fold(
        (failure) {
          throw Exception("Failed to load products");
        },
        (loadedProjects) {
          products.value = loadedProjects;
          filteredProducts.value = loadedProjects;
        },
      );
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    } finally {
      isLoading.value = false;
    }
  }

// Create a new product
  Future<bool> createProd({
    required ProductModel product,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    final body = product.toJson()
      ..remove('_id')
      ..remove('created_at');

    try {
      var response = await _apiService.postRequest(
        endpoint: Constant().addProduct,
        body: body,
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          CustomToast.showToast(
            context: context,
            message: failure != null
                ? failure.toString()
                : "Failed to create project",
          );
          return false;
        },
        (data) {
          product.id = data;
          products.insert(products.length, product);
          filteredProducts.insert(filteredProducts.length, product);
          CustomToast.showToast(
            context: context,
            message: 'Product created successfully',
          );
          Navigator.of(context).pop();
          return true;
        },
      );
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Edit an existing product
  Future<bool> editProduct({
    required ProductModel product,
    required String productId,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;
      var response = await _apiService.patchRequest(
        endpoint: "${Constant().updateProduct}/$productId",
        body: product.toJson()
          ..remove('_id')
          ..remove('created_at'),
        fromJson: (json) => json,
      );
      return response.fold(
        (failure) {
          CustomToast.showToast(
            context: context,
            message: "Failed to update project",
          );
          return false;
        },
        (data) {
          final index = products.indexWhere((p) => p.id == productId);
          if (index != -1) {
            products[index] = product;
            filteredProducts[index] = product;
          }
          CustomToast.showToast(
            context: context,
            message: 'Product updated successfully',
          );
          Navigator.of(context).pop();
          return true;
        },
      );
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Search projects
  void searchProjects({String? filter, String? query}) {
    final q = query?.toLowerCase() ?? '';
    final f = filter?.toLowerCase() ?? '';

    if (q.isEmpty && f.isEmpty) {
      // If both search and filter are empty/null, show all projects
      filteredProducts.value = products;
      return;
    }

    filteredProducts.value = products.where((product) {
      bool matchesQuery = q.isEmpty
          ? true
          : (product.name?.toLowerCase().contains(q) ?? false) ||
              (product.category?.toLowerCase().contains(q) ?? false) ||
              (product.shortDescription?.toLowerCase().contains(q) ?? false);

      bool matchesFilter = f.isEmpty
          ? true
          : (product.name?.toLowerCase().contains(f) ?? false) ||
              (product.status?.toLowerCase().contains(f) ?? false);

      return matchesQuery && matchesFilter;
    }).toList();
  }
}
