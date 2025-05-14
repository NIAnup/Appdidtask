import 'package:appdidtask/Screen/category.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: key,
              child: Column(
                spacing: 20,
                children: [
                  Text(
                    "Welcome back! Glad to See You. Again!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),

                  //Email Textfield\
                  SizedBox(
                    width: width * 0.9,
                    child: TextFormField(
                      controller: email,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: "Enter your Email",
                        focusColor: Colors.grey,
                        fillColor: Colors.grey,

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                  ),

                  //Password TextField
                  SizedBox(
                    width: width * 0.9,
                    child: TextFormField(
                      controller: password,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                        focusColor: Colors.grey.shade400,
                        fillColor: Colors.grey.shade400,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      email.text = 'admin';
                      password.text = '1234';
                      if (key.currentState!.validate()) {
                        if (email.text == 'admin' && password.text == '1234') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Category()),
                          );
                        }
                      }
                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
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
  }
}
