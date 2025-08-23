import 'package:flutter_test/flutter_test.dart';
import 'package:japanese_dict/data/definitions.dart';
import 'package:japanese_dict/data/dictionary_service.dart';

void main() {
  test(
    "Test to see if fetchDefinitions first result of \'dog\' is actully dog",
    () async {
      DictionaryService dictionaryService = DictionaryService();
      List<Definitions> definition_list = [];
      Definitions first_result;

      definition_list = await dictionaryService.fetchDefinitions('dog');
      first_result = definition_list[0];

      expect('犬', first_result.words[0].word);
      
    },
  );
}
