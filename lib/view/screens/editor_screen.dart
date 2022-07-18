import 'package:flashcards/model/model.dart';
import 'package:flashcards/view_model/flashcard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditorScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Paths.editorScreenPath,
      key: ValueKey(Paths.editorScreenPath),
      child: EditorScreen(),
    );
  }

  static List<String> appBarTitles = [
    'Creating Set',
    'Creating Flashcard',
    'Editing',
  ];

  EditorScreen({
    Key? key,
    // required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String appBarTitle = context.read<FlashcardManager>().fetchAppBarTitle;

    return FlashcardForm(appBarTitle: appBarTitle);
  }
}
