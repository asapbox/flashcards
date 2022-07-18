import 'package:flashcards/model/flashcard.dart';

class Collection {
  String collectionName;
  final List<Flashcard> flashcards;

  Collection({required this.collectionName, required this.flashcards});

  @override
  String toString() {
    String output = '';
    for (var flashcard in flashcards) {
      output = '$output$flashcard\n';
    }
    return 'Collection(\ntitle: \'$collectionName\',\nflashcards: [\n$output  ],\n ),';
  }
}
