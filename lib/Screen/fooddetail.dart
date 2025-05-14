import 'dart:io';

import 'package:appdidtask/controller/FooddetailsController.dart';
import 'package:appdidtask/model/MealsData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart%20' as http;
import 'package:social_sharing_plus/social_sharing_plus.dart' as share;
import 'package:path_provider/path_provider.dart';

class Fooddetail extends StatefulWidget {
  const Fooddetail({super.key, required this.urlcategory});
  final String urlcategory;

  @override
  State<Fooddetail> createState() => _FooddetailState();
}

class _FooddetailState extends State<Fooddetail> {
  final FoodDetailscontroller foodDetailscontroller =
      Get.find<FoodDetailscontroller>();
  @override
  void initState() {
    super.initState();
    foodDetailscontroller.getfooddetaildata(widget.urlcategory);
  }

  Future<void> sharemeal(MealsData meal) async {
    final tempDir = await getTemporaryDirectory();

    final response = await http.get(Uri.parse(meal.strMealThumb ?? ""));

    final imagepath = '${tempDir.path}/${meal.idMeal}.jpg';
    final imageFile = File(imagepath);
    await imageFile.writeAsBytes(response.bodyBytes);

    await share.SocialSharingPlus.shareToSocialMediaWithMultipleMedia(
      share.SocialPlatform.facebook,

      media: [imageFile.path],
      content: '${meal.strMeal}/${meal.strInstructions}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Food Detail",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final data = foodDetailscontroller.mealsdata.value;
              sharemeal(data!);
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              if (foodDetailscontroller.isloading.value) {
                return Center(child: CircularProgressIndicator());
              }
              final data = foodDetailscontroller.mealsdata.value;
              print(data);
              if (data == null) {
                return Center(child: Text("Food Details Not Found"));
              }
              return Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(data.strMealThumb ?? ""),

                  Text(
                    data.strMeal ?? " ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 34,
                    ),
                  ),
                  Text(
                    data.strArea ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Tags ${data.strTags} " ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    data.strInstructions ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),

                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Ingredient',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Measure',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient1 ?? "")),
                          DataCell(Text(data.strMeasure1 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient2 ?? "")),
                          DataCell(Text(data.strMeasure2 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient3 ?? "")),
                          DataCell(Text(data.strMeasure3 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient4 ?? "")),
                          DataCell(Text(data.strMeasure4 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient5 ?? "")),
                          DataCell(Text(data.strMeasure5 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient6 ?? "")),
                          DataCell(Text(data.strMeasure6 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient7 ?? "")),
                          DataCell(Text(data.strMeasure7 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient8 ?? "")),
                          DataCell(Text(data.strMeasure8 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient9 ?? "")),
                          DataCell(Text(data.strMeasure9 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient10 ?? "")),
                          DataCell(Text(data.strMeasure10 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient10 ?? "")),
                          DataCell(Text(data.strMeasure10 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient1 ?? "")),
                          DataCell(Text(data.strMeasure1 ?? "")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text(data.strIngredient1 ?? "")),
                          DataCell(Text(data.strMeasure1 ?? "")),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
