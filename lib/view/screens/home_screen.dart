import 'package:flashcards/model/model.dart';
import 'package:flashcards/persistence/persistence_manager.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/view/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/view_model/view_model.dart';

class HomeScreen extends StatelessWidget {
  final String title = 'My Collections';
  final String addCollectionsText = 'Press + to add a new collection';

  static MaterialPage page() {
    return MaterialPage(
      name: Paths.homeScreenPath,
      key: ValueKey(Paths.homeScreenPath),
      child: const HomeScreen(),
    );
  }

  const HomeScreen({
    Key? key,
    //  required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEmptyCollections = context
        .watch<FlashcardManager>()
        .flashcardsRepository
        .collections
        .isEmpty;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(title)),
      body: (isEmptyCollections) ? buildTextForEmptyScreen() : TitlesListView(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              // choose a random set to study and move to the details screen.
              onPressed: () {},
              icon: IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: const Icon(
                  Icons.question_mark_outlined,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<NavigationManager>().setEditorScreen(true);
                context
                    .read<FlashcardManager>()
                    .setIsCreatingNewCollection(true);
              },
              icon: const Icon(
                Icons.add_outlined,
              ),
            ),
            const CustomPopupMenuButton(),
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
