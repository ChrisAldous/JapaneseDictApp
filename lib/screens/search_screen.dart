import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japanese_dict/data/definitions.dart';
import 'package:japanese_dict/data/dictionary_service.dart';
import 'package:japanese_dict/screens/word_definition_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DictionaryService dictService = DictionaryService();
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 210, 24, 11),
          title: Text('Japanese Dictionary'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search',
              onSubmitted: (value) async {
                setState(() {
                  isLoading = true;
                  user_input = value.trim();
                });

                try {
                  resultTile = await dictService.fetchDefinitions(user_input);
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
                : resultTile.isEmpty
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

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) => WordDefinitionScreen(the_word: item))
                          );
                        },
                        child: ListTile(
                          title: Text("$title, $reading"),
                          subtitle: Text(subtitle),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
