import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import "package:stupefying_wallpapers/model/wallpapers_response.dart";
import 'package:stupefying_wallpapers/views/screens/full_screen.dart';
import "package:stupefying_wallpapers/views/widgets/category_block.dart";
import "package:stupefying_wallpapers/views/widgets/serach_bar.dart";

import "../widgets/custom_app_bar.dart";

class CategoryScreen extends StatefulWidget {
  String catergoryImg;
  String categoryTitle;
  CategoryScreen(
      {super.key, required this.catergoryImg, required this.categoryTitle});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  WallpaperResponse? categoryResponse;
  bool isLoading = false;
  getQueryResults() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=${widget.categoryTitle}&per_page=30&page=1"),
          headers: {
            "Authorization":
                "NTULDfJpzl46IBe6WfSIq7uRLjHFbUt4oAsW6dsNyPXAQsXccrbB3OU"
          });
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        categoryResponse = WallpaperResponse.fromJson(data);
        isLoading = false;
      });
      print("Dataaaaaa");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getQueryResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          word1: "Stupfying",
          word2: "WALLPAPER",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    widget.catergoryImg,
                  ),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 130,
                  child: Column(
                    children: [
                      Text(
                        "CATEGORY",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.categoryTitle.toUpperCase(),
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            isLoading
                ? const Center(
                    child: SpinKitWave(
                      color: Colors.orange,
                      size: 60.0,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 13,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 350,
                          ),
                          itemCount: categoryResponse?.photos?.length ?? 0,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenPicture(
                                        imgSrc: categoryResponse?.photos?[index]
                                                .src?.portrait ??
                                            ""),
                                  ),
                                );
                              },
                              child: Container(
                                height: 200,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.grey,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    categoryResponse
                                            ?.photos?[index].src?.portrait
                                            .toString() ??
                                        "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          })),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
