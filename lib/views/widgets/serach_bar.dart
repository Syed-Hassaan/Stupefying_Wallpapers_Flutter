import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stupefying_wallpapers/views/screens/search_screen.dart';

class SearchBar extends StatefulWidget {
  String xtx = "Search Wallpaper here";
  SearchBar({super.key, required this.xtx});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(15, 0, 0, 0),
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: widget.xtx,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (_searchController.text == "" ||
                  _searchController.text.length >= 30) {
                return;
              } else {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (context) => SearchScreen(
                        searchQuery: _searchController.text.toString())));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SearchScreen(
                //             searchQuery: _searchController.text.toString())));
              }
            },
            child: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
