import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../constants/constant.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        const Image(image: AssetImage(Constant.introductionImage)),
        Padding(
          padding: const EdgeInsets.only(top: 64.0, bottom: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constant.mainFontFamily.fontFamily,
                      ),
                      child: const Text("RECIPETIA"),
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontFamily: Constant.secondeFontFamily.fontFamily),
                    child: const Text("Easy To Make Food"),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Container(
                  height: 35.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.bottomCenter,
                      end: AlignmentDirectional.topCenter,
                      colors: [
                        const Color(0xffF8F8F8).withOpacity(01),
                        const Color(0xffF8F8F8).withOpacity(0.2),
                        const Color(0xffD9D9D9).withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(32),
                  height: 15.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Constant.enterNameRoute, (route) => true);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Constant.mainColor),
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
          ],
        )
      ],
    );
  }
}
