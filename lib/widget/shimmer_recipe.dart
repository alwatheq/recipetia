import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../constants/constant.dart';

class ShimmerRecipe extends StatelessWidget {
  const ShimmerRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              blurRadius: 10, color: Color(0x39000000), offset: Offset(0, 5))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 18,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Shimmer.fromColors(
                        baseColor: const Color(0xFFEBEBF4),
                        highlightColor:
                            const Color(0xFFEBEBF4).withOpacity(0.5),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: 90,
                    margin: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.red,
                              highlightColor: Colors.yellow,
                              child: Text(
                                "---",
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 18.sp,
                                    height: 0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                      Constant.mainFontFamily.fontFamily,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.red,
                              highlightColor: Colors.yellow,
                              child: Icon(
                                Icons.star,
                                size: 22.sp,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: const Color(0xFFEBEBF4),
                      highlightColor: const Color(0xFFEBEBF4).withOpacity(0.5),
                      child: SizedBox(
                        width: 260,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              height: 16,
                              child: const Text(""),
                              width: double.infinity,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              child: const Text(""),
                              height: 10,
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: const Color(0xFFEBEBF4),
                      highlightColor: const Color(0xFFEBEBF4).withOpacity(0.5),
                      child: Icon(
                        Icons.favorite,
                        size: 28.sp,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
