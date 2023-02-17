import "package:flutter/material.dart";
import 'package:stupefying_wallpapers/views/screens/category_screen.dart';

class CategoryBlock extends StatefulWidget {
  String categoryTitle;
  String categoryImage;
  CategoryBlock(
      {super.key, required this.categoryTitle, required this.categoryImage});

  @override
  State<CategoryBlock> createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                      categoryTitle: widget.categoryTitle,
                      catergoryImg: widget.categoryImage,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  height: 100,
                  width: 120,
                  fit: BoxFit.cover,
                  widget.categoryImage),
            ),
            Container(
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(12)),
            ),
            Positioned(
              top: 15,
              left: 30,
              child: Text(
                widget.categoryTitle,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
