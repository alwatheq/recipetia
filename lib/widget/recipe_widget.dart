import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipetia/constants/constant.dart';

import 'package:recipetia/view/favorite_page.dart';
import 'package:recipetia/widget/detailed_recipe_widget.dart';
import 'package:sizer/sizer.dart';

import '../provider/favorite_provider.dart';

// ignore: must_be_immutable
class Recipe extends StatelessWidget {
  final String name;
  final String maker;
  final String imageUrl;
  final String score;
  bool isFavorite;
  final String id;
  final List<dynamic> comp;
  final Map nutrition;
  final List<dynamic> instructions;
  final String description;
  final int? time;
  Recipe({
    super.key,
    required this.name,
    required this.maker,
    required this.imageUrl,
    required this.score,
    this.isFavorite = false,
    required this.id,
    required this.comp,
    required this.nutrition,
    required this.instructions,
    required this.description,
    required this.time,
  });

  final favoriteProvider = StateNotifierProvider<FavoriteNotifier, bool>((ref) {
    return FavoriteNotifier();
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailedRecipe(
                      description: description,
                      instructions: instructions,
                      name: name,
                      maker: maker,
                      imageUrl: imageUrl,
                      score: score,
                      id: id,
                      comp: comp,
                      favorite: isFavorite,
                      nutrition: nutrition,
                      time: time,
                      prov: favoriteProvider,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10,
                  color: Color(0x39000000),
                  offset: Offset(0, 5))
            ]),
        height: 30.h,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
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
                      child: Image(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      width: 90,
                      margin: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                score,
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 18.sp,
                                    height: 0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        Constant.mainFontFamily.fontFamily),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.star,
                                size: 22.sp,
                                color: Colors.amber,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 280,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                height: 0,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff535353)),
                          ),
                          Text(
                            "By $maker",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              height: 0,
                              color: const Color(0xff6D6D6D),
                              fontFamily: Constant.mainFontFamily.fontFamily,
                              fontSize: 10.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Consumer(builder: (context, ref, child) {
                          ref.watch(favoriteProvider);

                          return IconButton(
                            onPressed: () {
                              ref.read(favoriteProvider.notifier).change();
                              isFavorite = !isFavorite;
                              if (isFavorite) {
                                const favoriteSnackBar = SnackBar(
                                  content: Text("added to favorites"),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(favoriteSnackBar);
                                ref
                                    .read(unFavoritesProvider.notifier)
                                    .add(this);
                              } else {
                                const favoriteSnackBar = SnackBar(
                                  content: Text("removed from favorites"),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(favoriteSnackBar);
                                ref
                                    .read(unFavoritesProvider.notifier)
                                    .removeRecipe(this);
                              }
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 22.sp,
                              color: Colors.red,
                            ),
                          );
                        })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Recipe copy() {
    return Recipe(
      name: name,
      maker: maker,
      imageUrl: imageUrl,
      score: score,
      id: id,
      comp: comp,
      isFavorite: isFavorite,
      nutrition: nutrition,
      instructions: instructions,
      description: description,
      time: time,
    );
  }
}
