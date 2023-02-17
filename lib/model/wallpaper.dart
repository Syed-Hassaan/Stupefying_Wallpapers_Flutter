import 'package:stupefying_wallpapers/model/src.dart';

class Wallpaper {
  String? photographer;
  Src? src;
  Wallpaper({this.photographer, this.src});

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    var wallpaperR = Wallpaper();
    wallpaperR.photographer = json['photographer'];
    wallpaperR.src = Src.fromjson(json['src']);
    return wallpaperR;
  }
}
