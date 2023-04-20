import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipetia/constants/constant.dart';

import 'package:recipetia/view/favorite_page.dart';
import 'package:recipetia/widget/detailed.dart';
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
  AppearanceNotifier? appearanceController;
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
    this.appearanceController,
  });

  final favoriteProvider = StateNotifierProvider<FavoriteNotifier, bool>((ref) {
    return FavoriteNotifier(false);
  });

  @override
  Widget build(BuildContext context) {
    final HeartNotifier _favoriteController = HeartNotifier(isFavorite);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Detailed(
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
              // prov: favoriteProvider,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Color(0x39000000),
                offset: Offset(0, 5),
              )
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
                                width: 10,
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
                      width: 63.w,
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
                          return AnimatedBuilder(
                            animation: _favoriteController,
                            builder: (context, child) => Container(
                              width: 50,
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(favoriteProvider.notifier).change();
                                  isFavorite = !isFavorite;
                                  _favoriteController.changeState(isFavorite);
                                  final favoriteSnackBar = SnackBar(
                                    content: Text(
                                      "${isFavorite ? 'added to' : 'removed from'} favorites",
                                    ),
                                    duration: const Duration(seconds: 1),
                                  );
                                  if (isFavorite) {
                                    ref
                                        .read(unFavoritesProvider.notifier)
                                        .add(this);
                                  } else {
                                    appearanceController?.changeState();
                                    Future.delayed(Duration(milliseconds: 300))
                                        .then(
                                      (value) => ref
                                          .read(unFavoritesProvider.notifier)
                                          .removeRecipe(this),
                                    );
                                  }
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(favoriteSnackBar);
                                },
                                child: AnimatedScale(
                                  duration: Duration(milliseconds: 250),
                                  scale: _favoriteController.size / 22.sp,
                                  curve: Curves.decelerate,
                                  child: isFavorite
                                      ? Icon(
                                          Icons.favorite,
                                          size: _favoriteController.size,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          size: _favoriteController.size,
                                          color: Colors.red,
                                        ),
                                ),
                              ),
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

  // to json
  Map<String, dynamic> toJson() => {
        'name': name,
        'maker': maker,
        'imageUrl': imageUrl,
        'score': score,
        'id': id,
        'comp': comp,
        'isFavorite': isFavorite,
        'nutrition': nutrition,
        'instructions': instructions,
        'description': description,
        'time': time,
      };

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

  // from json
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      maker: json['maker'],
      imageUrl: json['imageUrl'],
      score: json['score'],
      id: json['id'],
      comp: json['comp'],
      isFavorite: json['isFavorite'],
      nutrition: json['nutrition'],
      instructions: json['instructions'],
      description: json['description'],
      time: json['time'],
    );
  }
}

class HeartNotifier extends ChangeNotifier {
  HeartNotifier(this.filled);
  bool filled;
  double size = 22.sp;
  changeState(bool value) {
    filled = value;
    if (value) {
      size = 25.sp;
      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        size = 22.sp;
        notifyListeners();
      });
    }
    notifyListeners();
  }
}
