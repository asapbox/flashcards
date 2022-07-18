import 'package:flashcards/model/flashcards_repository.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class PersistenceManager extends ChangeNotifier {
  final flashcardRepository = FlashcardsRepository();

  // delete
  // Map<String, dynamic> decodedJson = {};

  // Finding the correct local path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Creating a reference to the file location
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/flashcards_json.txt');
  }

  Future<File> writingToFile(
      Map<String, List<Map<String, String>>> jsonCollections) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(json.encode(jsonCollections));
  }

  Future<String> readingFromFile() async {
    try {
      final file = await _localFile;
      final rawString = await file.readAsString();

      return rawString;
    } catch (e) {
      debugPrint(e.toString());
      return 'readingFromFile() method returned an Error: $e';
    }
  }

  Future<void> persistingDataToLocalStorage() async {
    await writingToFile(flashcardRepository.toJson());
    notifyListeners();
    // delete
    // flashcardRepository.collections.clear();
    // debugPrint(FlashcardsRepository().toString());
  }

  // returning the execution time in milliseconds.
  Future<int> restoringData() async {
    final beginningTime = DateTime.now();

    final rawString = await readingFromFile();
    final decodedJson = json.decode(rawString) as Map<String, dynamic>;
    debugPrint('decodedJson.isNotEmpty = ${decodedJson.isNotEmpty}');

    if (decodedJson.isNotEmpty) {
      flashcardRepository.collections.clear();
      // parsing from Json file and adding flashcards into collections
      flashcardRepository.parseFromJson(decodedJson);
      notifyListeners();
    }

    // delete
    debugPrint('$flashcardRepository');

    final endingTime = DateTime.now();
    int executionTime = endingTime.difference(beginningTime).inMilliseconds;
    debugPrint('executionTime: $executionTime milliseconds');

    return executionTime;
  }
}
