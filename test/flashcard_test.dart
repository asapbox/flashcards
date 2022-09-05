import 'package:flashcards/view_model/flashcard_manager.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:flashcards/model/flashcard.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  group('class Flashcard', () {
    test(
      'String should be returned',
      () {
        final flashcard = Flashcard(
          frontSide: 'cat',
          backSide: 'кошка',
          isFavorite: false,
        );

        expect(flashcard.toString(),
            'Flashcard(frontSide: cat, backSide: кошка, isFavorite: false)');
      },
    );

    test('An instance should be returned', () {
      Map<String, dynamic> map = {
        'frontSide': 'cat',
        'backSide': 'кошка',
        'isFavorite': false,
      };
      final flashcard = Flashcard.fromJson(map);
      expect(
        flashcard.toString(),
        'Flashcard(frontSide: cat, backSide: кошка, isFavorite: false)',
      );
    });
  });

  group('class FlashcardManager', () {

    test(
      'A new flashcard should be created',
      () {
        final flashcardManager = FlashcardManager();

        flashcardManager
          ..isCreatingNewFlashcard = true
          ..selectedCollectionIndex = 0;

        // Tested method.
        flashcardManager.createNewFlashcard(
            frontSide: 'frontTest', backSide: 'backTest');

        expect(
            flashcardManager.flashcardsRepository.collections[0].flashcards
                .firstWhere((e) => e.frontSide == 'frontTest')
                .toString(),
            'Flashcard(frontSide: frontTest, backSide: backTest, isFavorite: false)');
      },
    );
  });
}
