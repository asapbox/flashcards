import 'package:flashcards/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashcardListView extends StatefulWidget {
  const FlashcardListView({Key? key}) : super(key: key);

  @override
  State<FlashcardListView> createState() => _FlashcardListViewState();
}

class _FlashcardListViewState extends State<FlashcardListView> {
  @override
  Widget build(BuildContext context) {
    final flashcards = context.read<FlashcardManager>().fetchSelectedFlashcards;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
          ),
          itemCount: flashcards.length,
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerStart,
              child: const Icon(
                Icons.delete_forever,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerEnd,
              child: const Icon(
                Icons.delete_forever,
              ),
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                context.read<FlashcardManager>().removeFlashcardAt(index);
              });

              //showing a snackbar.
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('flashcard is deleted')));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  context.read<NavigationManager>().setDetailsScreen(true);
                  context
                      .read<FlashcardManager>()
                      .setSelectedFlashcardIndex(index);
                },
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Text(flashcards[index].frontSide),
                      ),
                    ),
                    Center(
                      // editing an existing flashcard.
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context
                              .read<NavigationManager>()
                              .setEditorScreen(true);
                          context
                              .read<FlashcardManager>()
                              .setSelectedFlashcardIndex(index);
                          context
                              .read<FlashcardManager>()
                              .setIsUpdatingFlashcard(true);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
