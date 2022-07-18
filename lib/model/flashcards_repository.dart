import 'package:flashcards/model/model.dart';
import 'package:flashcards/model/mock_flashcard_repository.dart';
import 'package:flashcards/model/mock_json_source.dart';

// Implementing a singleton class to store the flashcards.
class FlashcardsRepository {
  final List<Collection> collections = <Collection>[
    Collection(
      collectionName: 'Animals (Test collection)',
      flashcards: [
        Flashcard(frontSide: 'cat', backSide: 'кошка'),
        Flashcard(frontSide: 'dog', backSide: 'собака'),
        Flashcard(frontSide: 'duck', backSide: 'утка'),
      ],
    ),
  ];

  static final FlashcardsRepository _instance = FlashcardsRepository._();

  FlashcardsRepository._();

  // replace MockFlashcardsRepository() with _instance
  factory FlashcardsRepository() =>
      // MockFlashcardsRepository();
      _instance;

  Map<String, List<Map<String, String>>> toJson() {
    Map<String, List<Map<String, String>>> tempMap = {};
    for (var collection in collections) {
      tempMap.addAll(
        {
          collection.collectionName: [
            for (var flashcard in collection.flashcards)
              {
                'frontSide': flashcard.frontSide,
                'backSide': flashcard.backSide,
              }
          ]
        },
      );
    }
    return tempMap;
  }

  void parseFromJson(Map<String, dynamic> json) {
    for (var entry in json.entries) {
      collections.add(
        Collection(
          collectionName: entry.key,
          flashcards: [
            for (var flashcard in entry.value) Flashcard.fromJson(flashcard)
          ],
        ),
      );
    }
  }

  @override
  String toString() {
    String output = '';
    for (var collection in collections) {
      output = '$output$collection\n';
    }
    return '[\n$output]';
  }
}
