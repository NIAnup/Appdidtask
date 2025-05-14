import 'dart:convert';
import 'dart:developer';

import 'package:appdidtask/model/Category.dart';
import 'package:appdidtask/model/MealsData.dart';
import 'package:appdidtask/model/meal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Categories>> getCategorydata() async {
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"),
    );

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      // Decode as Map
      Map<String, dynamic> jsonData = json.decode(response.body);

      List<dynamic> categoryList = jsonData['categories'];

      // Map to Category model
      return categoryList.map((e) => Categories.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<Meals>> getmealdata(String categoryname) async {
    final response = await http.post(
      Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryname",
      ),
    );

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      // Decode as Map
      Map<String, dynamic> jsonData = json.decode(response.body);

      List<dynamic> categoryList = jsonData['meals'];

      // Map to Category model
      return categoryList.map((e) => Meals.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<MealsData> getfooddetail(String categoryname) async {
    final response = await http.post(
      Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$categoryname",
      ),
    );

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      // Decode as Map
      final jsonData = json.decode(response.body);

      var categoryList = jsonData['meals'][0];

      // Map to Category model
      return MealsData.fromJson(categoryList);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<MealsData> getRandomMeal() async {
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"),
    );

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      // Decode as Map
      final jsonData = json.decode(response.body);

      var categoryList = jsonData['meals'][0];

      // Map to Category model
      return MealsData.fromJson(categoryList);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<MealsData> getsearchresult(String query) async {
    final response = await http.post(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
    );

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      // Decode as Map
      final jsonData = json.decode(response.body);

      var categoryList = jsonData['meals'][0];

      // Map to Category model
      return MealsData.fromJson(categoryList);
    } else {
      throw Exception("Failed to load categories");
    }
  }
}
