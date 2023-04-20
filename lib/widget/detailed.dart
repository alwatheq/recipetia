import 'dart:developer';

import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipetia/provider/favorite_provider.dart';
import 'package:recipetia/view/steps.dart';

final icons = [];

class Detailed extends StatelessWidget {
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
  Detailed({
    super.key,
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
  });
  @override
  Widget build(BuildContext context) {
    log(comp
        .map((e) => e['measurements'][0]['unit']['name'])
        .toList()
        .toString());
    // log(comp[0]['measurements'][0]['quantity'].toString());
    // log(comp[0]['measurements'][0]['unit']['name'].toString());
    return ClipRRect(
      child: Scaffold(
          appBar: AppBar(
            title: Text(name),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        DropShadowImage(
                          image: Image(
                            image: NetworkImage(imageUrl),
                            width: 400,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: 20,
                          blurRadius: 20,
                          offset: const Offset(5, 5),
                          scale: 1.05,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15, top: 40),
                          decoration: const BoxDecoration(
                            // color: Colors.white,
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Color.fromARGB(240, 22, 22, 22),
                                // Color.fromARGB(175, 43, 43, 43),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            // borderRadius: BorderRadius.circular(20),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 230,
                                child: Text(
                                  maker,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 235, 235, 235),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Text(
                                '${nutrition["calories"] != null ? nutrition["calories"].toString() + ' cal' : ''} ${time != null ? '\n' + time.toString() + " min" : ''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 235, 235, 235),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  description.isNotEmpty
                      ? const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 25,
                            height: 2.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF7643),
                          ),
                          textAlign: TextAlign.start,
                        )
                      : Container(),
                  // padding: EdgeInsets.all(10),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: 25,
                      height: 2.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFF7643),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  ...comp.map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "🍳 ${e['ingredient']['name'].split('Â').join('')}",
                            style: TextStyle(
                                fontSize: 16, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${(e['measurements'][0]['quantity']).split('Â').join('')}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              e['measurements'][0]['unit']['name'],
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
                      onTap: () {
                        final RecipeProvider =
                            StateNotifierProvider<FavoriteNotifier, bool>(
                                (ref) => FavoriteNotifier(favorite));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Steps(detailed: this),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffFFA53E),
                                Color(0xffFF7643),
                              ],
                            )),
                        child: const Text(
                          "Start Cooking!",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
