import "dart:convert";

import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:stupefying_wallpapers/model/wallpapers_response.dart";
import "package:stupefying_wallpapers/views/screens/full_screen.dart";
import "package:stupefying_wallpapers/views/widgets/category_block.dart";
import "package:stupefying_wallpapers/views/widgets/serach_bar.dart";
import 'package:http/http.dart' as http;
import "../widgets/custom_app_bar.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WallpaperResponse? response;
  bool isLoading = false;
  List<String> categoryList = ['Nature', "Bike", "City", "Street", "Food"];
  List<String> categoryImages = [
    'https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    "https://images.pexels.com/photos/1119796/pexels-photo-1119796.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/462331/pexels-photo-462331.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/409701/pexels-photo-409701.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  ];

  getTrendingWallpapers() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http
          .get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
        "Authorization":
            "NTULDfJpzl46IBe6WfSIq7uRLjHFbUt4oAsW6dsNyPXAQsXccrbB3OU"
      });
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        this.response = WallpaperResponse.fromJson(data);
        isLoading = false;
      });
      print(data);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getTrendingWallpapers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          word1: "Stupefying",
          word2: "WALLPAPER",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SearchBar(
                xtx: "Search Wallpaper here",
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: ((context, index) {
                    return CategoryBlock(
                      categoryTitle: categoryList[index].toString(),
                      categoryImage: categoryImages[index].toString(),
                    );
                  }),
                ),
              ),
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
                      // width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 450,
                          ),
                          itemCount: response?.photos?.length ?? 0,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullScreenPicture(
                                            imgSrc: response?.photos?[index].src
                                                    ?.portrait ??
                                                ""),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 350,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        response?.photos?[index].src?.portrait
                                                .toString() ??
                                            "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  color: Colors.orange,
                                  child: ListTile(
                                    horizontalTitleGap: -20,
                                    leading: const Icon(
                                      Icons.person,
                                      size: 25,
                                    ),
                                    title: Center(
                                      child: Text(
                                        response?.photos?[index].photographer
                                                .toString() ??
                                            "",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
