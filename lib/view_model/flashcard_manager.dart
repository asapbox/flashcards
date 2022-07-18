import 'package:flashcards/persistence/persistence_manager.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/model/model.dart';
import 'package:flashcards/view/screens/screens.dart';

///Managing add, read, update and delete operations
///for the class Flashcard
class FlashcardManager extends ChangeNotifier {
  final flashcardsRepository = FlashcardsRepository();
  final persistenceManager = PersistenceManager();

  late String selectedCollectionTitle;
  int? selectedCollectionIndex;
  int? selectedFlashcardIndex;

  bool isCreatingNewCollection = false;
  bool isCreatingNewFlashcard = false;
  bool isUpdatingFlashcard = false;
  bool isFavorite = false;

  // choosing appBar title for the Editor screen.
  String get fetchAppBarTitle {
    if (isCreatingNewCollection) {
      return EditorScreen.appBarTitles[0];
    }
    if (isCreatingNewFlashcard) {
      return EditorScreen.appBarTitles[1];
    } else {
      return EditorScreen.appBarTitles[2];
    }
  }

  Flashcard get fetchFlashcard {
    Collection selectedCollection =
        flashcardsRepository.collections[selectedCollectionIndex!];
    Flashcard flashcard =
        selectedCollection.flashcards[selectedFlashcardIndex!];
    return flashcard;
    notifyListeners(); //delete
  }

  List<Flashcard> get fetchSelectedFlashcards {
    List<Flashcard> flashcards =
        flashcardsRepository.collections[selectedCollectionIndex!].flashcards;
    return flashcards;
    notifyListeners(); // delete
  }

  Collection get fetchSelectedCollection {
    Collection collection =
        flashcardsRepository.collections[selectedCollectionIndex!];
    return collection;
    notifyListeners(); // delete
  }

  List<String> get fetchCollectionTitles {
    List<String> collectionTitles = [];
    for (final collection in flashcardsRepository.collections) {
      collectionTitles.add(collection.collectionName.toString());
    }
    return collectionTitles;
  }

  void setIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
    debugPrint('isFavorite = $isFavorite');
  }

  void setSelectedFlashcardIndex(int selectedFlashcardIndex) {
    this.selectedFlashcardIndex = selectedFlashcardIndex;
    notifyListeners();
    debugPrint('selectedFlashcardIndex = $selectedFlashcardIndex');
  }

  void setSelectedCollectionIndex(int selectedCollectionIndex) {
    this.selectedCollectionIndex = selectedCollectionIndex;
    notifyListeners();
    debugPrint('selectedCollectionIndex = $selectedCollectionIndex');
  }

  void setIsCreatingNewCollection(bool isSelected) {
    isCreatingNewCollection = isSelected;
    isCreatingNewFlashcard = false;
    isUpdatingFlashcard = false;
    notifyListeners();
    debugPrint('isCreatingNewCollection = $isCreatingNewCollection');
  }

  void setIsCreatingNewFlashcard(bool isSelected) {
    isCreatingNewFlashcard = isSelected;
    isCreatingNewCollection = false;
    isUpdatingFlashcard = false;
    notifyListeners();
    debugPrint('isCreatingNewFlashcard = $isCreatingNewFlashcard');
  }

  void setIsUpdatingFlashcard(bool isSelected) {
    isUpdatingFlashcard = isSelected;
    isCreatingNewCollection = false;
    isCreatingNewFlashcard = false;
    notifyListeners();
    debugPrint('isUpdatingFlashcard = $isUpdatingFlashcard');
  }

  // delete
  // void setAction(String actionName, bool isActive) {
  //   if (actionName == 'isCreatingNewFlashcard') {
  //     isCreatingNewFlashcard = isActive;
  //     debugPrint('isCreatingNewFlashcard = $isCreatingNewFlashcard');
  //   } else {
  //     isCreatingNewFlashcard = false;
  //   }
  //   if (actionName == 'isUpdatingFlashcard') {
  //     isUpdatingFlashcard = isActive;
  //     debugPrint('isUpdatingFlashcard = $isUpdatingFlashcard');
  //   } else {
  //     isUpdatingFlashcard = false;
  //   }
  // }

  void removeFlashcardAt(int index) {
    flashcardsRepository
        .collections[selectedCollectionIndex!].flashcards.removeAt(index);
    notifyListeners();
    persistenceManager.persistingDataToLocalStorage();

  }

  // set onDismissible
  void removeCollectionAt(int index) {
    flashcardsRepository.collections.removeAt(index);
    notifyListeners();
    persistenceManager.persistingDataToLocalStorage();
  }

  // eiter create a new flashcard or update a chosen flashcard.
  void saveFlashcard({
    required collectionTitle,
    required String frontSide,
    required String backSide,
  }) {
    if (isCreatingNewCollection) {
      createNewCollection(collectionTitle, frontSide, backSide);
    }
    else if (isCreatingNewFlashcard) {
      updateCollectionTitle(collectionTitle);
      createNewFlashcard(frontSide: frontSide, backSide: backSide);
    } else {
      updateCollectionTitle(collectionTitle);
      updateFlashcard(frontSide: frontSide, backSide: backSide);
    }
  }

  void createNewFlashcard({
    required String frontSide,
    required String backSide,
  }) {
    Flashcard newFlashcard =
        Flashcard(frontSide: frontSide, backSide: backSide);
    flashcardsRepository.collections[selectedCollectionIndex!].flashcards.add(
      newFlashcard,
    );
    isCreatingNewFlashcard = false;
    debugPrint('isCreatingNewFlashcard = $isCreatingNewFlashcard');
    notifyListeners();
    persistenceManager.persistingDataToLocalStorage();
  }

  void updateFlashcard({
    required String frontSide,
    required String backSide,
  }) {
    flashcardsRepository.collections[selectedCollectionIndex!]
        .flashcards[selectedFlashcardIndex!].frontSide = frontSide;
    flashcardsRepository.collections[selectedCollectionIndex!]
        .flashcards[selectedFlashcardIndex!].backSide = backSide;
    isUpdatingFlashcard = false;
    notifyListeners();
    debugPrint('isUpdatingFlashcard = $isUpdatingFlashcard');
    persistenceManager.persistingDataToLocalStorage();
  }

  void createNewCollection(
    String collectionTitle,
    String frontSide,
    String backSide,
  ) {
    flashcardsRepository.collections.add(
      Collection(
        collectionName: collectionTitle,
        flashcards: [
          Flashcard(frontSide: frontSide, backSide: backSide),
        ],
      ),
    );
    isCreatingNewCollection = false;
    notifyListeners();
    persistenceManager.persistingDataToLocalStorage();
  }

  void updateCollectionTitle(String collectionTitle) {
    fetchSelectedCollection.collectionName = collectionTitle;
    notifyListeners();
    persistenceManager.persistingDataToLocalStorage();
  }
}
