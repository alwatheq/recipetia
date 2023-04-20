import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:recipetia/constants/constant.dart';

import 'package:recipetia/view/favorite_page.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'Home_view.dart';

final list = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final pages = [
  const Home(),
  const FavoritePage(),
];
int current = 0;

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            color: Color(0xffF5F5F5),
            boxShadow: [BoxShadow(blurRadius: 10, color: Color(0x47000000))]),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: SalomonBottomBar(
            onTap: (p0) {
              setState(() {
                current = p0;
              });
            },
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            currentIndex: current,
            items: [
              SalomonBottomBarItem(
                selectedColor: Constant.mainColor,
                unselectedColor: const Color(0xAD000000),
                icon: const Icon(FluentIcons.home_12_filled),
                title: const Text("Home"),
              ),
              SalomonBottomBarItem(
                selectedColor: Colors.red[600],
                unselectedColor: const Color(0xAD000000),
                icon: const Icon(FluentIcons.heart_12_filled),
                title: const Text("Favorite"),
              ),
            ],
          ),
        ),
      ),
      body: pages[current],
    );
  }
}
