import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:recipetia/constants/constant.dart';
import 'package:recipetia/view/favorite_page.dart';

import 'package:recipetia/widget/recipe_widget.dart';
import 'package:sizer/sizer.dart';

import '../provider/favorite_provider.dart';

// ignore: must_be_immutable
class DetailedRecipe extends StatelessWidget {
  final String name;
  final String maker;
  final String imageUrl;
  final String score;
  bool favorite;
  final String id;
  final List<dynamic> comp;
  final Map nutrition;
  final List instructions;
  final String description;
  final int? time;
  final StateNotifierProvider<FavoriteNotifier, bool> prov;
  DetailedRecipe(
      {super.key,
      required this.name,
      required this.maker,
      required this.imageUrl,
      required this.score,
      required this.id,
      required this.comp,
      required this.favorite,
      required this.nutrition,
      required this.instructions,
      required this.description,
      required this.time,
      required this.prov});
  PageController pages = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(name),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PageView(
        controller: pages,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 55.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Color(0x39000000),
                            offset: Offset(0, 5))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 18,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                width: double.infinity,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 1.h),
                                child: CircleAvatar(
                                  maxRadius: 4.h,
                                  backgroundColor: const Color(0xFF555555),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        FluentIcons.star_24_filled,
                                        size: 24.sp,
                                        color: Constant.mainColor,
                                      ),
                                      Text(
                                        score,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Constant.mainColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      FluentIcons.clock_24_regular,
                                      size: 24.sp,
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    Text(
                                      time == null
                                          ? "N/A"
                                          : "${time.toString()} minutes",
                                      style: TextStyle(fontSize: 12.sp),
                                    )
                                  ],
                                ),
                                const VerticalDivider(),
                                Column(
                                  children: [
                                    Icon(
                                      FluentIcons.fire_24_regular,
                                      size: 24.sp,
                                    ),
                                    Text(
                                      nutrition["calories"] == null
                                          ? "N/A"
                                          : "${nutrition["calories"].toString()} Kcal",
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "ingredient",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    height: 25.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: comp.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          height: 2.h,
                          width: 50.w,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Color(0x39000000),
                                  offset: Offset(0, 5))
                            ],
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 5.h,
                                  child: const Image(
                                    image: AssetImage(
                                      "assets/1.png",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                child: Text(
                                  comp[index]["ingredient"]["name"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "${comp[index]["measurements"][0]["quantity"].toString()} ${comp[index]["measurements"][0]["unit"]["name"]}",
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "info",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 10,
                            color: Color(0x39000000),
                            offset: Offset(0, 5))
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Made by : $maker",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "\t Description: $description",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12.sp, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    height: 10.h,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          pages.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeIn);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Constant.mainColor),
                        child: const Text(
                          "Start making this recipe",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ...instructions.map(
            (e) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 10,
                      color: Color(0x39000000),
                      offset: Offset(0, 5))
                ],
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("step ${e["position"]}"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "${e["display_text"]}",
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            pages.previousPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Constant.mainColor),
                          child: Text(
                            e["position"] != 1
                                ? "Previous step"
                                : "Recipe details",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            pages.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Constant.mainColor),
                          child: Text(
                            e["position"] != instructions.length
                                ? "Next step"
                                : "Next",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 64.0),
                  child: Text(
                    "Enjoy the meal",
                    style: TextStyle(fontSize: 30.sp),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Did you like this recipe?",
                    textAlign: TextAlign.center,
                  ),
                ),
                !favorite
                    ? Consumer(
                        builder: (context, ref, child) => ElevatedButton(
                          onPressed: () {
                            const favoriteSnackBar = SnackBar(
                              content: Text("added to favorites"),
                              duration: Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(favoriteSnackBar);
                            favorite = true;
                            ref.read(unFavoritesProvider.notifier).add(Recipe(
                                name: name,
                                maker: maker,
                                imageUrl: imageUrl,
                                score: score,
                                id: id,
                                isFavorite: true,
                                comp: comp,
                                nutrition: nutrition,
                                instructions: instructions,
                                description: description,
                                time: time));
                            ref.read(prov.notifier).change();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Constant.mainColor),
                          child: const Text(
                            "add it to favorite",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : Container(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700]),
                    onPressed: () {
                      pages.animateToPage(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    child: const Text(
                      "back to recipe details",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
