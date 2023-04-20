import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipetia/main.dart';
import 'package:recipetia/widget/recipe_widget.dart';

class UnFavoritesNotifier extends StateNotifier<List<Recipe>> {
  UnFavoritesNotifier():super([
    ...jsonDecode(pref.getString('favorites') ?? "[]").map((e) => Recipe.fromJson(e))
  ]);

  void add(Recipe recipe) {
    state = [...state.map((e) => e.copy()), recipe];
    var data = jsonDecode(pref.getString('favorites') ?? "[]");
    data.add(recipe.toJson());
    pref.setString('favorites', jsonEncode(data));

  }

  void removeRecipe(Recipe recipe) {
    state.remove(recipe);
    var data = jsonDecode(pref.getString('favorites') ?? "[]").where((e) => e != recipe.toJson()).toList();
    pref.setString('favorites', jsonEncode(data));
    state = [...state.map((e) => e.copy())];
  }
}
