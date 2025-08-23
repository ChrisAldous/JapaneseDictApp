import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:japanese_dict/data/definitions.dart';
import 'package:japanese_dict/data/dictionary_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'dictionary_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Tests on Dictionary Service fetchDefinition method', () {
    test(
      "Test to see if fetchDefinitions first result of \'dog\' is actully dog",
      () async {
        final MockClient mockClient = MockClient();

        final fake_response = {
          "data": [
            {
              "slug": "犬",
              "is_common": true,
              "tags": ["wanikani2"],
              "jlpt": ["jlpt-n5"],
              "japanese": [
                {"word": "犬", "reading": "いぬ"},
                {"word": "狗", "reading": "いぬ"},
                {"reading": "イヌ"},
              ],
              "senses": [
                {
                  "english_definitions": ["dog (Canis (lupus) familiaris)"],
                  "parts_of_speech": ["Noun"],
                  "links": [],
                  "tags": [],
                  "restrictions": [],
                  "see_also": [],
                  "antonyms": [],
                  "source": [],
                  "info": [],
                },
                {
                  "english_definitions": [
                    "squealer",
                    "rat",
                    "snitch",
                    "informer",
                    "informant",
                    "spy",
                  ],
                  "parts_of_speech": ["Noun"],
                  "links": [],
                  "tags": ["Derogatory", "Usually written using kana alone"],
                  "restrictions": [],
                  "see_also": ["みっこくしゃ"],
                  "antonyms": [],
                  "source": [],
                  "info": [],
                },
                {
                  "english_definitions": ["loser", "asshole"],
                  "parts_of_speech": ["Noun"],
                  "links": [],
                  "tags": ["Derogatory"],
                  "restrictions": [],
                  "see_also": [],
                  "antonyms": [],
                  "source": [],
                  "info": [],
                },
                {
                  "english_definitions": [
                    "counterfeit",
                    "inferior",
                    "useless",
                    "wasteful",
                  ],
                  "parts_of_speech": ["Noun, used as a prefix"],
                  "links": [],
                  "tags": [],
                  "restrictions": [],
                  "see_also": [],
                  "antonyms": [],
                  "source": [],
                  "info": [],
                },
              ],
              "attribution": {
                "jmdict": true,
                "jmnedict": false,
                "dbpedia": false,
              },
            },
          ],
        };

        when(
          mockClient.get(
            Uri.parse('https://jisho.org/api/v1/search/words?keyword=dog'),
          ),
        ).thenAnswer(
          (_) async => http.Response(json.encode(fake_response), 200),
        );

        DictionaryService dictionaryService = DictionaryService(mockClient);

        final result = await dictionaryService.fetchDefinitions('dog');

        expect(result, isNotEmpty);
        expect(result[0].words[0].word, '犬');
        // expect(result[0].definition, contains('dog'));
      },
    );

    test('If use submitted an empty string', () async {
      final MockClient mockClient = MockClient();

      when(
        mockClient.get(
          Uri.parse('https://jisho.org/api/v1/search/words?keyword='),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          json.encode({
            'data' : [],
          }),
          200,
        ),
      );

      DictionaryService dictionaryService = DictionaryService(mockClient);
      final result = await dictionaryService.fetchDefinitions('');

      expect(result.length, equals(0));
    });
  });
}
