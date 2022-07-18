import 'package:flutter/material.dart';
import 'package:flashcards/view/widgets/widgets.dart';
import 'package:flashcards/model/model.dart';
import 'package:flashcards/view_model/view_model.dart';
import 'package:provider/provider.dart';

class FlashcardsListScreen extends StatelessWidget {
  final String addCollectionsText = 'Press + to add a new flashcard';

  static MaterialPage page() {
    return MaterialPage(
      name: Paths.flashcardsListScreenPath,
      key: ValueKey(Paths.flashcardsListScreenPath),
      child: FlashcardsListScreen(),
    );
  }

  const FlashcardsListScreen({
    Key? key,
    //  required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEmptyCollections = context
        .watch<FlashcardManager>()
        .fetchSelectedCollection
        .flashcards
        .isEmpty;
    final String title =
        context.read<FlashcardManager>().fetchSelectedCollection.collectionName;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: SafeArea(
        child: (isEmptyCollections)
            ? buildTextForEmptyScreen()
            : FlashcardListView(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                context.read<NavigationManager>().setFlashcardListScreen(false);
              },
              icon: const Icon(Icons.arrow_back_outlined),
            ),
            IconButton(
              onPressed: () {
                context.read<NavigationManager>().setEditorScreen(true);
                context
                    .read<FlashcardManager>()
                    .setIsCreatingNewFlashcard(true);
              },
              icon: const Icon(Icons.add_outlined),
            ),
            CustomPopupMenuButton(),
          ],
        ),
      ),
    );
  }

  Widget buildTextForEmptyScreen() {
    return Center(
      child: Text(addCollectionsText),
    );
  }
}
