import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:recipetia/constants/constant.dart';

class API {
  static const String url = "tasty.p.rapidapi.com";
  static const String rapidAPIKey =
      "c2fa6b3f56msha1325100bfdfd95p172625jsnbe14be1c98ed";

  API._();

  static Future<List<Map<String, dynamic>>> getList({
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.https(url, Constant.recipeList, queryParameters);
    headers = headers ?? {};

    final response = await http.get(
      uri,
      headers: {
        "X-RapidAPI-Key": rapidAPIKey,
        ...headers,
      },
    );

    final body = jsonDecode(response.body);

    final List<Map<String, dynamic>> results = [];

    for (final result in body["results"]) {
      if (result["canonical_id"].startsWith("compilation")) {
        continue;
      }

      final id = result["id"].toString();
      final maker = result["credits"]?[0]?["name"] ?? "none";
      final recipeName = result["name"] ?? "none";
      final description = result["description"]?.toString() ?? "N/A";
      final instruction = result["instructions"] ?? [];
      final score =
          ((result["user_ratings"]?["score"] ?? 0) * 10).toStringAsFixed(1);
      final imageUrl = result["thumbnail_url"] ?? "none";
      final component = result["sections"][0]["components"] ?? "none";
      final nutrition = result["nutrition"] ?? "none";
      final totalTime = result["total_time_minutes"];

      final Map<String, dynamic> item = {
        "id": id,
        "maker": maker,
        "name": recipeName,
        "instructions": instruction,
        "score": score,
        "url": imageUrl,
        "component": component,
        "nutrition": nutrition,
        "description": description,
        "time": totalTime,
      };

      results.add(item);
    }

    return results;
  }
}
