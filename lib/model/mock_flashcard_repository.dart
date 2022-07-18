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
        Flashcard(frontSide: 'platypus', backSide: 'утконос'),
        Flashcard(frontSide: 'cat', backSide: 'кошка'),
        Flashcard(frontSide: 'dog', backSide: 'собака'),
        Flashcard(frontSide: 'duck', backSide: 'утка'),
        Flashcard(frontSide: 'ape', backSide: 'обезьяна'),
        Flashcard(frontSide: 'lion', backSide: 'лев'),
        Flashcard(frontSide: 'horse', backSide: 'лошадь'),
        Flashcard(frontSide: 'monkey', backSide: 'обезьяна'),
      ],
    ),
    Collection(
      collectionName: 'family',
      flashcards: [
        Flashcard(frontSide: 'father', backSide: 'отец'),
        Flashcard(frontSide: 'mother', backSide: 'мать'),
        Flashcard(frontSide: 'son', backSide: 'сын'),
        Flashcard(frontSide: 'daughter', backSide: 'дочь'),
        Flashcard(frontSide: 'brother', backSide: 'брат'),
        Flashcard(frontSide: 'husband', backSide: 'муж'),
        Flashcard(frontSide: 'wife', backSide: 'жена'),
        Flashcard(frontSide: 'sister', backSide: 'сестра'),
      ],
    ),
    Collection(
      collectionName: 'birds',
      flashcards: [
        Flashcard(frontSide: 'Pigeon', backSide: 'голубь'),
        Flashcard(frontSide: 'Peacock', backSide: 'павлин'),
        Flashcard(frontSide: 'Parrot', backSide: 'попугай'),
      ],
    ),
    Collection(
      collectionName: 'vehicles',
      flashcards: [
        Flashcard(frontSide: 'van', backSide: 'минивэн'),
        Flashcard(frontSide: 'bus', backSide: 'автобус'),
        Flashcard(frontSide: 'ambulance', backSide: 'скорая помощь'),
      ],
    ),
    Collection(
      collectionName: 'food',
      flashcards: [
        Flashcard(frontSide: 'Milk', backSide: 'молоко'),
        Flashcard(frontSide: 'Bread', backSide: 'хлеб'),
        Flashcard(frontSide: 'Butter', backSide: 'масло'),
      ],
    ),
  ];

  @override
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

