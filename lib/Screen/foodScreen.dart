import 'package:appdidtask/Screen/fooddetail.dart';
import 'package:appdidtask/controller/CategoryController.dart';
import 'package:appdidtask/controller/Foodcontroller.dart';
import 'package:appdidtask/controller/FooddetailsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodScreen extends StatefulWidget {
  FoodScreen({super.key, required this.urlcategory});
  final String urlcategory;

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late Foodcontroller foodcontroller;

  final FoodDetailscontroller foodDetailscontroller = Get.put(
    FoodDetailscontroller(),
  );
  @override
  void initState() {
    super.initState();
    foodcontroller = Get.find<Foodcontroller>();
    foodcontroller.postmealsdata(widget.urlcategory);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Food ${widget.urlcategory}",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() {
        if (foodcontroller.isloading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: foodcontroller.mealsdata.length,
          itemBuilder: (context, index) {
            final data = foodcontroller.mealsdata[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: height * 0.8,
                // width: width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                Fooddetail(urlcategory: data.idMeal ?? ""),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(width: 200, data.strMealThumb ?? ""),
                        SizedBox(height: 40),
                        Text(
                          data.strMeal ?? "Beef",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     data.?? "",
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.black54,
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
