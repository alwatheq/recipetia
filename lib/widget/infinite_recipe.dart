import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipetia/widget/shimmer_recipe.dart';

import '../view/favorite_page.dart';
import 'recipe_widget.dart';

class InfiniteRecipes extends StatelessWidget {
  const InfiniteRecipes({
    super.key,
    required this.controller,
  });

  final PagingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => controller.refresh(),
        ),
        child: PagedListView(
          builderDelegate: PagedChildBuilderDelegate(
              firstPageProgressIndicatorBuilder: (context) {
            List<Widget> shimmers = List.generate(
                20,
                (index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                child: const ShimmerRecipe(),
              ),
            );
            return Column(
              children: shimmers,
            );
          }, itemBuilder: (context, dynamic item, index) {
            if (item.isEmpty || item == null) {
              return const Center(child: Text("Something wrong happened"));
            }
            return Consumer(builder: (context, ref, child) {
              bool flag = false;
              List<Recipe> listOfFavorites = ref.read(unFavoritesProvider);
              for (var i = 0; i < listOfFavorites.length; i++) {
                if (listOfFavorites[i].id == item["id"]) {
                  flag = true;
                  break;
                }
              }

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Recipe(
                  description: item["description"],
                  name: item['name'] ?? "",
                  imageUrl: item["url"],
                  maker: item["maker"],
                  id: item["id"],
                  isFavorite: flag,
                  score: item["score"],
                  comp: item["component"],
                  nutrition: item["nutrition"],
                  instructions: item["instructions"],
                  time: item["time"],
                ),
              );
            });
          }),
          pagingController: controller,
        ),
      ),
    );
  }
}
