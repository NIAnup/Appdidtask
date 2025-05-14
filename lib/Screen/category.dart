import 'package:appdidtask/Screen/Randommeal.dart';
import 'package:appdidtask/Screen/SearchScreen.dart';
import 'package:appdidtask/Screen/foodScreen.dart';
import 'package:appdidtask/Screen/fooddetail.dart';
import 'package:appdidtask/Screen/loginscreen.dart';
import 'package:appdidtask/controller/CategoryController.dart';
import 'package:appdidtask/controller/Foodcontroller.dart';
import 'package:appdidtask/controller/searchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late Categorycontroller categorycontroller;
  final Foodcontroller foodcontroller = Get.put(Foodcontroller());
  final TextEditingController searchController = TextEditingController();
  final Searchcontroller searchgetxcontroller = Get.put(Searchcontroller());
  @override
  void initState() {
    super.initState();
    categorycontroller = Get.put(Categorycontroller());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: SizedBox(
          width: width * 0.7,
          child: TextFormField(
            cursorColor: Colors.grey,
            controller: searchController,

            decoration: InputDecoration(
              hintText: "Search meals...",
              focusedBorder: UnderlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 0),
              ),
            ),
          ),
        ),
        actions: [
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              final query = searchController.text.trim();
              if (query.isNotEmpty) {
                Get.to(() => SearchScreen(searchQuery: query));
                searchController.clear();
              } else {
                Get.snackbar(
                  "Empty Search",
                  "Please enter a meal name to search.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.orange.withOpacity(0.8),
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(12),
                  duration: const Duration(seconds: 2),
                );
              }
            },
            child: Container(
              height: 50,
              width: 50,

              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.search),
            ),
          ),
          const SizedBox(width: 8),

          IconButton(
            tooltip: "Logout",
            onPressed: () {
              Get.offAll(Loginscreen());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (categorycontroller.isloading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Get.to(RandomMeal());
                },
                child: Container(
                  height: 50,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black54),
                  ),
                  child: Center(
                    child: Text(
                      "Random Meal",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: height * 0.8,
                width: width * 0.8,

                child: PageView.builder(
                  itemCount: categorycontroller.categorydata.length,
                  itemBuilder: (context, index) {
                    final data = categorycontroller.categorydata[index];
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
                        child: SingleChildScrollView(
                          child: GestureDetector(
                            onTap: () {
                              final value = foodcontroller.postmealsdata(
                                data.strCategory ?? "",
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => FoodScreen(
                                        urlcategory: data.strCategory ?? "",
                                      ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    data.strCategory ?? "Beef",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 34,
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  Image.network(
                                    width: 300,
                                    data.strCategoryThumb ?? "",
                                  ),

                                  SizedBox(height: 40),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data.strCategoryDescription ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      // body: ListView.builder(
      //   itemCount: 2,
      //   itemBuilder: (context, index) {
      //     return Container(
      //       width: width * 0.5,
      //       decoration: BoxDecoration(
      //         border: Border.all(color: Colors.black54),
      //       ),
      //       child: Column(
      //         children: [
      //           Text(
      //             "Beef",
      //             style: TextStyle(
      //               fontWeight: FontWeight.w400,
      //               color: Colors.black54,
      //               fontSize: 14,
      //             ),
      //           ),

      //           Image.network(
      //             width: 150,
      //             "https://www.themealdb.com/images/category/beef.png",
      //           ),
      //           Text(
      //             """Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]""",
      //             style: TextStyle(
      //               fontWeight: FontWeight.w400,
      //               color: Colors.black54,
      //               fontSize: 14,
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
