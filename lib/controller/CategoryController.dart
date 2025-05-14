import 'dart:developer';
import 'dart:convert';

import 'package:appdidtask/api_service/api_service.dart';
import 'package:appdidtask/model/Category.dart';
import 'package:get/get.dart';
import "package:http/http.dart " as http;

class Categorycontroller extends GetxController {
  var categorydata = <Categories>[].obs;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    fetchCategorydata();
    super.onInit();
  }

  void fetchCategorydata() async {
    isloading.value = true;
    try {
      categorydata.value = await ApiService().getCategorydata();
    } catch (e) {
      log("Error $e");
    } finally {
      isloading.value = false;
    }
  }
}
