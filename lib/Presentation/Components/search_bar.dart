import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final Function(String) onSearch;

  const SearchPage({super.key, required this.onSearch});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    widget.onSearch(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.4,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(style: BorderStyle.none),
        color: ColorResources.scaffoldColor,
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'አባል ይፈልጉ',
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xffA9ADB0),
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Color(0xffA9ADB0),
        ),
      ),
    );
  }
}
