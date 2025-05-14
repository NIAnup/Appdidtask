import 'dart:developer';
import 'dart:convert';

import 'package:appdidtask/api_service/api_service.dart';
import 'package:appdidtask/model/Category.dart';
import 'package:appdidtask/model/meal.dart';
import 'package:get/get.dart';
import "package:http/http.dart " as http;

class Foodcontroller extends GetxController {
  var mealsdata = <Meals>[].obs;
  RxBool isloading = false.obs;

  void postmealsdata(String typecategory) async {
    isloading.value = true;
    try {
      mealsdata.value = await ApiService().getmealdata(typecategory);
    } catch (e) {
      log("Error $e");
    } finally {
      isloading.value = false;
    }
  }
}
