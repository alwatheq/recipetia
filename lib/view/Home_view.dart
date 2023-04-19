import 'dart:developer';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

import '../API/API.dart';
import '../constants/constant.dart';
import '../search/search_delegate.dart';
import '../widget/infinite_recipe.dart';
import 'home_page.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  PagingController controller = PagingController<int, dynamic>(firstPageKey: 0);
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Lets cook",
              style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constant.mainFontFamily.fontFamily,
                  color: const Color(0xff535353)),
            ),
            Container(
                padding: const EdgeInsets.all(32),
                child: TextField(
                  onTap: () => showSearch(
                      context: context, delegate: CustomSearchDelegate()),
                  controller: search,
                  onTapOutside: (event) {},
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            color: Color(0xF99E9E9E), width: 2)),
                    prefixIcon: const Icon(
                      FluentIcons.search_12_filled,
                      color: Color(0xF99E9E9E),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            color: Color(0xF99E9E9E), width: 2)),
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Search",
                    fillColor: const Color(0x259E9E9E),
                  ),
                )),
            InfiniteRecipes(controller: controller),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (pageKey == 0 && list.isNotEmpty) {
        controller.appendPage(list, pageKey + 20);

        return;
      }
      final newPage = await API
          .getList(queryParameters: {"from": pageKey.toString(), "size": "20"});

      final newItems = newPage;

      final nextPageKey = pageKey + 20;
      controller.appendPage(newItems, nextPageKey);
      list.addAll(newItems);
    } catch (error) {
      controller.error = error;
      log(error.toString());
    }
  }

  @override
  bool get wantKeepAlive => true;
}
