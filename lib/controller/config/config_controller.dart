import 'package:get/get.dart';
import 'package:overseas_front_end/model/app_configs/config_model.dart';
import 'package:overseas_front_end/model/app_configs/config_list_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import '../../core/services/api_service.dart';
import '../../core/services/navigation_service.dart';
import '../../core/shared/constants.dart';
import '../../view/widgets/custom_snackbar.dart';
import '../product_controller/product_controller.dart';

class ConfigController extends GetxController {
  var isLoading = false.obs;
  var configData = ConfigListModel().obs;

  @override
  void onInit() {
    super.onInit();
    loaddata();
  }

  void loaddata() {
    loadConfigData();
    Get.find<ProductController>().fetchProducts();
  }

  Future<bool> loadConfigData() async {
    // print(configData.value);
    if (configData.value.id != null) return true;
    isLoading.value = true;
    try {
      var result = await ApiService().getRequest(
        endpoint: Constant().configList,
        fromJson: (json) => ConfigListModel.fromJson(json),
      );

      result.fold((failure) {
        return false;
      }, (data) => {configData.value = data});
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
      // ignore: control_flow_in_finally
      return true;
    }
  }

  List<ConfigModel> getItemsByCategory(String category) {
    try {
      return configData.value
          .getItems(category)
          .whereType<ConfigModel>()
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addItem(
      String category, Map<String, dynamic> newItemData) async {
    try {
      var result = await ApiService().patchRequest(
          endpoint: Constant().editConfigList,
          body: {"field": category, "action": "insert", "value": newItemData},
          fromJson: (json) => json);
      NavigationService.goBack();
      result.fold(
        (failure) {
          CustomSnackBar.showMessage("Error", "Failed to add item",
              backgroundColor: AppColors.redSecondaryColor);
        },
        (data) async {
          final newItem = ConfigModel.fromMap(newItemData);
          newItem.id = data['insertedId'] ??
              DateTime.now().millisecondsSinceEpoch.toString();
          configData.value.insertItem(category, newItem);
          configData.refresh();
          NavigationService.goBack();

          CustomSnackBar.showMessage("Success", "Item added successfully",
              backgroundColor: AppColors.greenSecondaryColor.withOpacity(0.5));
        },
      );
    } catch (e) {
      CustomSnackBar.showMessage("Error", "Failed to add item",
          backgroundColor: AppColors.redSecondaryColor);
    }
  }

  Future<void> updateItem(String category, String itemId,
      Map<String, dynamic> updatedItemData) async {
    try {
      var result = await ApiService().patchRequest(
        endpoint: Constant().editConfigList,
        body: {
          "field": category,
          "action": "update",
          "value": {
            "_id": itemId,
            ...updatedItemData,
          },
        },
        fromJson: (json) => json,
      );
      NavigationService.goBack();
      result.fold(
        (failure) {
          CustomSnackBar.showMessage("Error", "Failed to update item",
              backgroundColor: AppColors.redSecondaryColor);
        },
        (data) {
          final updatedItem = ConfigModel.fromMap({
            "_id": itemId,
            ...updatedItemData,
          });
          configData.value.updateItem(category, updatedItem);
          configData.refresh();
          NavigationService.goBack();
          CustomSnackBar.showMessage("Success", "Item updated successfully",
              backgroundColor: AppColors.greenSecondaryColor.withOpacity(0.5));
        },
      );
    } catch (e) {
      CustomSnackBar.showMessage("Error", "Failed to update item",
          backgroundColor: AppColors.redSecondaryColor);
    }
  }

  Future<void> deleteItem(String category, String itemId) async {
    try {
      var result = await ApiService().patchRequest(
        endpoint: Constant().editConfigList,
        body: {
          "field": category,
          "action": "delete",
          "value": {
            "_id": itemId,
          },
        },
        fromJson: (json) => json,
      );
      NavigationService.goBack();
      result.fold(
        (failure) {
          CustomSnackBar.showMessage("Error", "Failed to update item",
              backgroundColor: AppColors.redSecondaryColor);
        },
        (data) {
          NavigationService.goBack();
          final existingList = getItemsByCategory(category);
          final item = existingList.firstWhereOrNull((e) => e.id == itemId);
          if (item == null) return;
          configData.value.deleteItem(category, item);
          configData.refresh();

          CustomSnackBar.showMessage(
            "Success",
            "Item deleted successfully",
            backgroundColor: AppColors.redSecondaryColor,
          );
        },
      );
    } catch (e) {
      CustomSnackBar.showMessage("Error", "Failed to delete item",
          backgroundColor: AppColors.redSecondaryColor);
    }
  }

  /// Dynamic fields config (can be moved to backend or JSON file later)
  Map<String, dynamic> getFieldsForCategory(String category) {
    final defaultFields = {
      'fields': ['name', 'status'],
      'required': ['name', 'status']
    };
    final customMap = <String, Map<String, dynamic>>{
      'branch': {
        'fields': ['name', 'address', 'phone', 'status'],
        'required': ['name', 'status', 'address', 'phone']
      },
      'client_status': {
        'fields': ['name', 'status', 'colour'],
        'required': ['name', 'status', 'colour']
      },
      'program': {
        'fields': ['name', 'program', 'status'],
        'required': ['name', 'program', 'status']
      },
      'specialized': {
        'fields': ['name', 'category', 'status'],
        'required': ['name', 'category', 'status']
      },
    };

    return customMap[category] ?? defaultFields;
  }

  List<String> getFieldsList(String category) =>
      List<String>.from(getFieldsForCategory(category)['fields'] ?? []);

  List<String> getRequiredFields(String category) =>
      List<String>.from(getFieldsForCategory(category)['required'] ?? []);

  bool isFieldRequired(String category, String field) =>
      getRequiredFields(category).contains(field);

  String getCategoryDisplayName(String category) =>
      category.replaceAll('_', ' ').toUpperCase();

  Map<String, dynamic> configModelToMap(ConfigModel model) => {
        'id': model.id,
        'name': model.name,
        'code': model.code,
        'country': model.country,
        'province': model.province,
        'status': model.status ?? 'ACTIVE',
        'address': model.address,
        'phone': model.phone,
        'colour': model.colour,
        'program': model.program, // Added
        'category': model.category, // Added
      };

  List<String> getAvailableCategories() =>
      configData.value.getAllKeys().toList();
}
