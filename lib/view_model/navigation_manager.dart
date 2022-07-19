import 'dart:async';
import 'package:flashcards/persistence/persistence_manager.dart';
import 'package:flutter/material.dart';

class NavigationManager extends ChangeNotifier {
  bool isInitialized = false;
  bool isLoggedIn = false;
  bool isOnBoardingScreen = false;
  bool isHomeScreen = false;
  bool isFlashcardListScreen = false;
  bool isDetailsScreen = false;
  bool isEditorScreen = false;

  final persistenceManager = PersistenceManager();

  void setOnBoardingScreen(bool isActive) {
    isOnBoardingScreen = isActive;
    notifyListeners();
    debugPrint('${DateTime.now()} - isOnBoardingScreen = $isOnBoardingScreen');
  }

  void setHomeScreen(bool isActive) {
    isHomeScreen = isActive;
    notifyListeners();
    debugPrint('${DateTime.now()} - isHomeScreen = $isHomeScreen');
  }

  void setFlashcardListScreen(bool isActive) {
    isFlashcardListScreen = isActive;
    notifyListeners();
    debugPrint(
      '${DateTime.now()} - isFlashcardListScreen = $isFlashcardListScreen',
    );
  }

  void setEditorScreen(bool isActive) {
    isEditorScreen = isActive;
    notifyListeners();
    debugPrint('${DateTime.now()} - isEditorScreen = $isEditorScreen');
  }

  void setDetailsScreen(bool isActive) {
    isDetailsScreen = isActive;
    notifyListeners();
    debugPrint('${DateTime.now()} - isDetailsScreen = $isDetailsScreen');
  }

  void setInitialized() {
    isInitialized = true;
    notifyListeners();
    debugPrint(
        '${DateTime.now()} - isInitialized = $isInitialized');
  }

  Future<void> initializingApp() async {
    // restoringData method returning the execution time in milliseconds
    final int difference =
    // 0;
    await persistenceManager.restoringData();

    //if-condition to extend the time of showing the splash screen.
    if (difference < 2000) {
      await Future<void>.delayed(
        const Duration(milliseconds: 1000),
        () {
          setInitialized();
        },
      );
    } else {
      setInitialized();
    }
  }

  // need to make an API request to log in.
  void login(String username, String password) {
    isLoggedIn = true;
    notifyListeners();
    debugPrint('${DateTime.now()} - isLoggedIn = ${isLoggedIn.toString()}');
  }

  void logout() {
    isLoggedIn = false;
    isOnBoardingScreen = false;
    isInitialized = false;
    notifyListeners();
  }
}
