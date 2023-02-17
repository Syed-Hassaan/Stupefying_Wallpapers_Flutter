class Src {
  String? portrait;
  Src({this.portrait});

  factory Src.fromjson(Map<String, dynamic> json) {
    var portraitR = Src();
    portraitR.portrait = json['portrait'];
    return portraitR;
  }
}
