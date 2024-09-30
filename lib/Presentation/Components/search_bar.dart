import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _items = List<String>.generate(100, (i) => "Item $i");
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {
      _filteredItems = _items
          .where((item) =>
              item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 43.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(style: BorderStyle.none),
              color: ColorResources.scaffoldColor),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
                hintText: 'አባል ይፈልጉ',
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffA9ADB0)),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Color(0xffA9ADB0)),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredItems[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
