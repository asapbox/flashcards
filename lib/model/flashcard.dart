class Flashcard {
  Flashcard({
    required this.frontSide,
    required this.backSide,
  });

  String frontSide;
  String backSide;

  factory Flashcard.fromJson(dynamic json) => Flashcard(
        frontSide: json['frontSide'] as String,
        backSide: json['backSide'] as String,
      );

  @override
  String toString() {
    return 'Flashcard(frontSide: $frontSide, backSide: $backSide)';
  }
}
