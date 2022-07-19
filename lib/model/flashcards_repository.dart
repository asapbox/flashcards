import 'package:flashcards/model/model.dart';
import 'package:flashcards/model/mock_flashcard_repository.dart';
import 'package:flashcards/model/mock_json_source.dart';

// Implementing a singleton class to store the flashcards.
class FlashcardsRepository {
  final List<Collection> collections = <Collection>[
    Collection(
      collectionName: 'Animals (Test collection)',
      flashcards: [
        Flashcard(frontSide: 'cat', backSide: 'кошка', isFavorite: false),
        Flashcard(frontSide: 'dog', backSide: 'собака', isFavorite: false),
        Flashcard(frontSide: 'duck', backSide: 'утка', isFavorite: false),
      ],
    ),
  ];

  static final FlashcardsRepository _instance = FlashcardsRepository._();

  FlashcardsRepository._();

  // replace _instance with MockFlashcardsRepository() to retrieve mock data
  // MockFlashcardsRepository();
  factory FlashcardsRepository() => _instance;

  Map<String, List<Map<String, dynamic>>> toJson() {
    Map<String, List<Map<String, dynamic>>> tempMap = {};
    for (var collection in collections) {
      tempMap.addAll(
        {
          collection.collectionName: [
            for (var flashcard in collection.flashcards)
              {
                'frontSide': flashcard.frontSide,
                'backSide': flashcard.backSide,
                'isFavorite': flashcard.isFavorite,
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
