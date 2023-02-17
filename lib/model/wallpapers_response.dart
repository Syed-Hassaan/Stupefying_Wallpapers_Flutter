import 'package:stupefying_wallpapers/model/wallpaper.dart';

class WallpaperResponse {
  List<Wallpaper>? photos;

  WallpaperResponse({this.photos});
  factory WallpaperResponse.fromJson(Map<String, dynamic> json) {
    var tempWallpaperR = WallpaperResponse();
    tempWallpaperR.photos = [];
    for (var wallpaperJson in (json['photos']) as List<dynamic>) {
      var wallpaperMap = wallpaperJson as Map<String, dynamic>;
      tempWallpaperR.photos?.add(Wallpaper.fromJson(wallpaperMap));
    }

    return tempWallpaperR;
  }
}
