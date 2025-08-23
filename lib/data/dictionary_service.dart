import 'definitions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DictionaryService {
  static const dictionary_source =
      'https://jisho.org/api/v1/search/words?keyword=';

  DictionaryService();

  String getSearchUrl(String keyword) {
    return dictionary_source + keyword;
  }

  Future<List<Definitions>> fetchDefinitions(user_input) async {
    final Uri url = Uri.parse(getSearchUrl(user_input));
    final response = await http.get(url);
    final Map<String, dynamic> definitionJson = json.decode(response.body);
    final List<dynamic> dataList = definitionJson['data'];

    final List<Definitions> definitionsList = dataList
        .map((item) => Definitions.fromJSON(item))
        .toList();

    // print(definitionsList);

    return definitionsList;
  }
}
