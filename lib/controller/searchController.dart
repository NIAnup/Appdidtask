import 'dart:developer';

import 'package:appdidtask/api_service/api_service.dart';
import 'package:appdidtask/model/MealsData.dart';
import 'package:get/get.dart';

class Searchcontroller extends GetxController {
  var mealsdata = Rxn<MealsData>();
  var isLoading = false.obs;

  Future<void> searchMeals(String query) async {
    isLoading.value = true;
    try {
      mealsdata.value = await ApiService().getsearchresult(query);
    } catch (e) {
      log("Error $e");
    } finally {
      isLoading.value = false;
    }
  }
}
