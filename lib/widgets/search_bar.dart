import "package:flutter/material.dart";

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
                color: const Color.fromARGB(255, 238, 237, 237),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.black),
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
                  color: Colors.black,
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
