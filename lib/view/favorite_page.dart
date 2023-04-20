import 'dart:convert';
import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipetia/constants/constant.dart';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipetia/main.dart';
import 'package:sizer/sizer.dart';

import '../provider/un_favorite_provider.dart';
import '../widget/recipe_widget.dart';

final unFavoritesProvider =
    StateNotifierProvider<UnFavoritesNotifier, List<Recipe>>((ref) {
  return UnFavoritesNotifier();
});

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 7),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Favorites",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: Constant.mainFontFamily.fontFamily,
                      color: const Color(0xff535353),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final listOfFavorites = ref.watch(unFavoritesProvider);
                  if (listOfFavorites.isEmpty) {
                    return const Center(
                      child: Text(
                        "You don't have any favorites recipes",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 30, color: Constant.mainColor),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: listOfFavorites.length + 1,
                    itemBuilder: (context, index) {
                      if (index < listOfFavorites.length) {
                        final AppearanceNotifier controller =
                            AppearanceNotifier(
                                listOfFavorites[index].isFavorite);
                        listOfFavorites[index].appearanceController =
                            controller;
                        return Container(
                          key: ValueKey("${listOfFavorites[index].id}"),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) => AnimatedSlide(
                              offset: controller.appear
                                  ? const Offset(0, 0)
                                  : const Offset(-2, 0),
                              duration: const Duration(milliseconds: 300),
                              child: listOfFavorites[index],
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class AppearanceNotifier extends ChangeNotifier {
  AppearanceNotifier(this.appear);
  bool appear;
  changeState() {
    appear = false;
    notifyListeners();
  }
}
