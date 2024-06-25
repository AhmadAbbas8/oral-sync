import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../utils/icon_broken.dart';

class CustomSearchWidget extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchWidget({
    super.key,
    required this.onSearch,
    required this.searchTextController, required this.onPressClear,
  });

  final TextEditingController searchTextController;
  final Function onPressClear;

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  String _searchText = "";
  bool _showClearButton = false;

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
              controller:widget. searchTextController,
              decoration: InputDecoration(
                hintText: LocaleKeys.search.tr(),
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
                              widget.searchTextController.text = "";
                              _searchText = "";
                              _showClearButton = false;
                              widget.onPressClear();
                            });
                          },
                        ),
                      )
                    : null,
              ),
              onChanged: (text) {
                widget.onSearch(text);
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
