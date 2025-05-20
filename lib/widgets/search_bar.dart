import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            width: MediaQuery.of(context).size.width * .9,
            height: 70,
            decoration: BoxDecoration(
                color: Color(0xFF2B2B2B),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
