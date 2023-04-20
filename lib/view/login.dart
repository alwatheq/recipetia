import 'package:flutter/material.dart';
import 'package:recipetia/constants/constant.dart';
import 'package:sizer/sizer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    FocusScope.of(context).nextFocus();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.92),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            child: TextField(
              onSubmitted: (value) {
                Constant.changeUserName(value);
                Navigator.pushNamedAndRemoveUntil(
                    context, Constant.homePageRoute, (route) => false);
              },
              controller: name,
              cursorColor: Constant.mainColor,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Constant.mainColor),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Constant.mainColor),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                hintText: "Enter your name",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 148, 148, 148),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            height: 15.h,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
