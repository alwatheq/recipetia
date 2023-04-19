import 'package:flutter/material.dart';
import 'package:recipetia/constants/constant.dart';
import 'package:sizer/sizer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.92),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(32),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Enter your name",
                    fillColor: Colors.white70),
              )),
          Container(
            padding: const EdgeInsets.all(32),
            height: 15.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Constant.changeUserName(name.text);
                Navigator.pushNamedAndRemoveUntil(
                    context, Constant.homePageRoute, (route) => true);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Constant.mainColor),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
