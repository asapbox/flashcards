import 'package:flashcards/model/flashcards_repository.dart';

class MockJson {
  static final Map<String, List<Map<String, String>>> json = {
    'animals1': [
      {
        'frontSide': 'platypus1',
        'backSide': 'утконос1',
      },
      {
        'frontSide': 'cat1',
        'backSide': 'кошка1',
      }
    ],
    'family1': [
      {
        'frontSide': 'father1',
        'backSide': 'отец1',
      },
      {
        'frontSide': 'wife1',
        'backSide': 'жена1',
      }
    ],
  };




}

// delete
// main() {
//   print(FlashcardsRepository().toJson());
// }
