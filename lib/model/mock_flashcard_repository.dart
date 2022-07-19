import 'package:flashcards/model/flashcard.dart';
import 'package:flashcards/model/collection.dart';
import 'package:flashcards/model/flashcards_repository.dart';

class MockFlashcardsRepository implements FlashcardsRepository {
  static final MockFlashcardsRepository _instance =
      MockFlashcardsRepository._();

  MockFlashcardsRepository._();

  factory MockFlashcardsRepository() => _instance;

  @override
  List<Collection> collections = <Collection>[
    Collection(
      collectionName: 'animals',
      flashcards: [
        Flashcard(
            frontSide: 'platypus', backSide: 'утконос', isFavorite: false),
        Flashcard(frontSide: 'cat', backSide: 'кошка', isFavorite: false),
        Flashcard(frontSide: 'dog', backSide: 'собака', isFavorite: false),
        Flashcard(frontSide: 'duck', backSide: 'утка', isFavorite: false),
        Flashcard(frontSide: 'ape', backSide: 'обезьяна', isFavorite: false),
        Flashcard(frontSide: 'lion', backSide: 'лев', isFavorite: false),
        Flashcard(frontSide: 'horse', backSide: 'лошадь', isFavorite: false),
        Flashcard(frontSide: 'monkey', backSide: 'обезьяна', isFavorite: false),
      ],
    ),
    Collection(
      collectionName: 'family',
      flashcards: [
        Flashcard(frontSide: 'father', backSide: 'отец', isFavorite: false),
        Flashcard(frontSide: 'mother', backSide: 'мать', isFavorite: false),
        Flashcard(frontSide: 'son', backSide: 'сын', isFavorite: false),
        Flashcard(frontSide: 'daughter', backSide: 'дочь', isFavorite: false),
        Flashcard(frontSide: 'brother', backSide: 'брат', isFavorite: false),
        Flashcard(frontSide: 'husband', backSide: 'муж', isFavorite: false),
        Flashcard(frontSide: 'wife', backSide: 'жена', isFavorite: false),
        Flashcard(frontSide: 'sister', backSide: 'сестра', isFavorite: false),
      ],
    ),
    Collection(
      collectionName: 'birds',
      flashcards: [
        Flashcard(frontSide: 'Pigeon', backSide: 'голубь', isFavorite: false),
        Flashcard(frontSide: 'Peacock', backSide: 'павлин', isFavorite: false),
        Flashcard(frontSide: 'Parrot', backSide: 'попугай', isFavorite: false),
      ],
    ),
    Collection(
      collectionName: 'vehicles',
      flashcards: [
        Flashcard(frontSide: 'van', backSide: 'минивэн', isFavorite: false),
        Flashcard(frontSide: 'bus', backSide: 'автобус', isFavorite: false),
      ],
    ),
    Collection(
      collectionName: 'food',
      flashcards: [
        Flashcard(frontSide: 'Milk', backSide: 'молоко', isFavorite: false),
        Flashcard(frontSide: 'Bread', backSide: 'хлеб', isFavorite: false),
        Flashcard(frontSide: 'Butter', backSide: 'масло', isFavorite: false),
      ],
    ),
  ];

  @override
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

  @override
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
