import "dart:convert";

import "package:http/http.dart" as http;
import "package:stupefying_wallpapers/model/wallpapers_response.dart";

class ApiOperations {
  static WallpaperResponse? _wallpaperResponse;
  static getTrendingWallpapers() async {
    try {
      var response = await http
          .get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
        "Authorization":
            "NTULDfJpzl46IBe6WfSIq7uRLjHFbUt4oAsW6dsNyPXAQsXccrbB3OU"
      });
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      _wallpaperResponse = WallpaperResponse.fromJson(data);
      print(data);
    } catch (e) {
      print(e.toString());
    }
  }

  // static getTrendingWallpaper() async {
  //   await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
  //     "Authorization": "NTULDfJpzl46IBe6WfSIq7uRLjHFbUt4oAsW6dsNyPXAQsXccrbB3OU"
  //   }).then((value) {
  //     Map<String, dynamic> jsonData = jsonDecode(value.body);
  //     List photos = jsonData['photos'];
  //     photos.forEach((element) {
  //       Map<String, dynamic> src = element['src'];
  //       print(src['portrait']);
  //     });
  //   });
  // }
}
