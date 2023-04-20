import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipetia/API/API.dart';
import 'package:recipetia/constants/constant.dart';
import 'package:recipetia/view/home_page.dart';
import 'package:recipetia/view/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'view/login.dart';
late SharedPreferences pref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  pref = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    child: Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        routes: {
          Constant.enterNameRoute: (context) => const Login(),
          Constant.homePageRoute: (context) => const HomePage()
        },
        home: API.rapidAPIKey.isEmpty
            ? const Scaffold(
                body: Center(
                  child: Text(
                      "The API rapid key is empty. Please insert one in API folder."),
                ),
              )
            : pref.getString("name") == null
                ? const WelcomePage()
                : const HomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: const TextTheme(
              bodyMedium: TextStyle(),
            ).apply(
              fontFamily: Constant.mainFontFamily.fontFamily,
            ),
            useMaterial3: true),
      ),
    ),
  ));
}
