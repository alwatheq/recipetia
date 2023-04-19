import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipetia/widget/recipe_widget.dart';

class UnFavoritesNotifier extends StateNotifier<List<Recipe>> {
  UnFavoritesNotifier(super.state);

  void add(Recipe recipe) {
    state = [...state.map((e) => e.copy()), recipe];
  }

  void removeRecipe(Recipe recipe) {
    state.remove(recipe);

    state = [...state.map((e) => e.copy())];
  }
}
