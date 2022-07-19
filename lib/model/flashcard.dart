class Flashcard {
  Flashcard(
      {required this.frontSide,
      required this.backSide,
      required this.isFavorite});

  String frontSide;
  String backSide;
  bool isFavorite;

  factory Flashcard.fromJson(dynamic json) => Flashcard(
        frontSide: json['frontSide'] as String,
        backSide: json['backSide'] as String,
        isFavorite: json['isFavorite'] as bool,
      );

  @override
  String toString() =>
      'Flashcard(frontSide: $frontSide, backSide: $backSide, isFavorite: $isFavorite)';
}
