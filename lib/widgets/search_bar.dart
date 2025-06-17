import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const SearchWidget({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * .9,
            height: 70,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 237, 237),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.black, size: 30),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onSubmitted: onSubmitted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
