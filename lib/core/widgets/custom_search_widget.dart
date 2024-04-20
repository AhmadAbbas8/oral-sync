import 'package:flutter/material.dart';

import '../utils/icon_broken.dart';

class CustomSearchWidget extends StatefulWidget {
  final Function(String) onSearch; // Callback function for search logic

  const CustomSearchWidget({super.key, required this.onSearch});

  @override
  _CustomSearchWidgetState createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  final TextEditingController _searchTextController = TextEditingController();
  String _searchText = "";
  bool _showClearButton = false; // Flag for clear button visibility

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Adapt to app theme
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(IconBroken.Search, color: Colors.grey[600]),
                border: InputBorder.none,
                suffixIcon: _searchText.isNotEmpty
                    ? AnimatedOpacity(
                        opacity: _showClearButton ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.grey[400]),
                          onPressed: () {
                            setState(() {
                              _searchTextController.text = "";
                              _searchText = "";
                              _showClearButton = false;
                            });
                          },
                        ),
                      )
                    : null, // Show clear button only when text is entered
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                  _showClearButton = text.isNotEmpty;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
