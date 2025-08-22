import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japanese_dict/data/definitions.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const dictionary_source =
      'https://jisho.org/api/v1/search/words?keyword=';
  String user_input = '';
  List<Definitions> resultTile = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Japanese Dictionary')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search',
              // onChanged: (value) {
              //   user_input = value.trim();
              // },
              onSubmitted: (value) async {
                setState(() {
                  isLoading = true;
                  user_input = value.trim();
                });

                try {
                  resultTile = await fetchDefinitions();
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: isLoading
              ? Center(child: CircularProgressIndicator())
              :resultTile.isEmpty
                ? Center(child: Text(''))
                : ListView.builder(
                    itemCount: resultTile.length,
                    itemBuilder: (context, index) {
                      final item = resultTile[index];
                      final title = item.words.isNotEmpty
                          ? item.words[0].word
                          : 'No word';
                      final reading = item.words.isNotEmpty
                          ? item.words[0].reading
                          : 'No word';
                      final subtitle = item.definition.isNotEmpty
                          ? item.definition.join(', ')
                          : 'No Definition';

                      // print("$title, $reading");

                      return ListTile(
                        title: Text("$title, $reading"),
                        subtitle: Text(subtitle),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String getSearchUrl(String keyword) {
    return dictionary_source + keyword;
  }

  Future<List<Definitions>> fetchDefinitions() async {
    final Uri url = Uri.parse(getSearchUrl(user_input));
    final response = await http.get(url);
    final Map<String, dynamic> definitionJson = json.decode(response.body);
    final List<dynamic> dataList = definitionJson['data'];

    final List<Definitions> definitionsList = dataList
        .map((item) => Definitions.fromJSON(item))
        .toList();

    // for (Definitions obj in definitionsList) {
    //   print(obj);
    // }

    return definitionsList;
  }
}
