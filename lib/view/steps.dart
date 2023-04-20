import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:recipetia/widget/detailed.dart';

import '../constants/constant.dart';

class Steps extends StatelessWidget {
  Steps({
    super.key,
    required this.detailed,
  });
  final PageController _controller = PageController();
  final Detailed detailed;
  @override
  Widget build(BuildContext context) {
    final allGifs = [1, 2, 3, 4, 5, 6];
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemBuilder: (context, index) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // gif from assets
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: AssetImage(
                          'assets/gif/${index % allGifs.length}.gif',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    detailed.instructions[index]['display_text']
                        .split('Â')
                        .join(''),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.75,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Constant.mainColor.withOpacity(0.1),
                        ),
                        overlayColor: MaterialStateProperty.all(
                          Constant.mainColor.withOpacity(0.2),
                        ),
                        side: MaterialStateProperty.all(
                          BorderSide(color: Constant.mainColor),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 30),
                        ),
                      ),
                      onPressed: () {
                        index != detailed.instructions.length - 1
                            ? _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeOutQuint,
                              )
                            : Navigator.of(context).pop();
                      },
                      // if it's the last page, show finish button

                      child: Text(
                        index == detailed.instructions.length - 1
                            ? 'End'
                            : 'Next',
                        style: TextStyle(color: Constant.mainColor),
                      ))
                ],
              ),
            ));
          },
          itemCount: detailed.instructions.length,
        ),
      ),
    );
  }
}
