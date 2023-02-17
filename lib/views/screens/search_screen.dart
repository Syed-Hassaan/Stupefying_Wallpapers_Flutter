import "dart:convert";

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:stupefying_wallpapers/model/wallpapers_response.dart";
import 'package:stupefying_wallpapers/views/screens/full_screen.dart';
import "package:stupefying_wallpapers/views/widgets/serach_bar.dart";
import "package:http/http.dart" as http;
import "../widgets/custom_app_bar.dart";

class SearchScreen extends StatefulWidget {
  String searchQuery;
  SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  WallpaperResponse? queryResponse;
  bool isLoading = false;

  getQueryResults(String query) async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=${widget.searchQuery}&per_page=30&page=1"),
          headers: {
            "Authorization":
                "NTULDfJpzl46IBe6WfSIq7uRLjHFbUt4oAsW6dsNyPXAQsXccrbB3OU"
          });
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        queryResponse = WallpaperResponse.fromJson(data);
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
    getQueryResults(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/homeScreen");
          },
          icon: Icon(Icons.arrow_back_sharp),
          color: Colors.orange,
        ),
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
              child: SearchBar(xtx: widget.searchQuery),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.searchQuery.toString().toUpperCase(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              )),
            ),
            const SizedBox(
              height: 10,
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
                          itemCount: queryResponse?.photos?.length ?? 0,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenPicture(
                                        imgSrc: queryResponse?.photos?[index]
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
                                    queryResponse?.photos?[index].src?.portrait
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
