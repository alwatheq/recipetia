import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../API/API.dart';
import '../main.dart';
import '../view/favorite_page.dart';
import '../widget/recipe_widget.dart';

List<String> previousEntries = [];

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  CustomSearchDelegate() {
    prevLoad();
  }
  List<Map> searchedRecipes = [];

  Future<void> prevLoad() async {
    // ignore: unused_local_variable
    final previousEntries = pref.getStringList("previousEnteries") ?? [];
  }

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
        // unfocus
        FocusScope.of(context).unfocus();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    previousEntries.add(query);
    pref.setStringList("previousEntries", previousEntries);
    return FutureBuilder(
      future:
          API.getList(queryParameters: {"from": "0", "size": "20", "q": query}),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Center(
              child: Text(
                "Sorry no result",
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Consumer(builder: (context, ref, child) {
                      bool flag = false;
                      List<Recipe> listOfFavorites =
                          ref.read(unFavoritesProvider);
                      for (var i = 0; i < listOfFavorites.length; i++) {
                        if (listOfFavorites[i].id ==
                            snapshot.data?[index]["id"]) {
                          flag = true;
                          break;
                        }
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Recipe(
                          description: snapshot.data?[index]["description"],
                          name: snapshot.data?[index]['name'],
                          imageUrl: snapshot.data?[index]["url"],
                          maker: snapshot.data?[index]["maker"],
                          id: snapshot.data?[index]["id"],
                          isFavorite: flag,
                          score: snapshot.data?[index]["score"],
                          comp: snapshot.data?[index]["component"],
                          nutrition: snapshot.data?[index]["nutrition"],
                          instructions: snapshot.data?[index]["instructions"],
                          time: snapshot.data?[index]["item"],
                        ),
                      );
                    });
                  },
                ),
              )
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Text("error");
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    final setPreviousEntries = Set.from(previousEntries);
    return ListView.builder(
      itemCount: setPreviousEntries.length,
      itemBuilder: (context, index) {
        var result = setPreviousEntries.elementAt(index);
        return GestureDetector(
          onTap: () {
            query = result;
            showResults(context);
            List<String> temp = List.from(setPreviousEntries);
            pref.setStringList("previousEntries", temp);
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
