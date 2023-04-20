import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:recipetia/main.dart';

class Constant {
  static const introductionImage = "assets/asd.png";
  static TextStyle mainFontFamily = GoogleFonts.poppins();
  static TextStyle secondeFontFamily = GoogleFonts.snippet();

  static String enterNameRoute = "/enterName";
  static String homePageRoute = "/homepage";
  static String recipeList = "recipes/list";
  static String recipeListSimilarity = "recipes/list-similarities";

  static const Color mainColor = Color(0xffFF7643);

  Constant._();

  static changeUserName(String name) {
    pref.setString("name", name);
  }
}
