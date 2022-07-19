import 'package:test/test.dart';
import 'package:flashcards/model/flashcard.dart';

void main() {
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
}
