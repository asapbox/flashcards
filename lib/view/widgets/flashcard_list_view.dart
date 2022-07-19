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

    bool isFavorite(int index) {
     return context.watch<FlashcardManager>().fetchSelectedFlashcards[index].isFavorite;
    }

    return Container(
      padding: const EdgeInsets.all(5.0),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(
          height: 4.0,
        ),
        itemCount: flashcards.length,
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          background: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerStart,
              child: IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: const Icon(
                  Icons.delete_forever,
                ),
              )),
          secondaryBackground: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerEnd,
              child: IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: const Icon(
                  Icons.delete_forever,
                ),
              )),
          onDismissed: (DismissDirection direction) {
            setState(() {
              context.read<FlashcardManager>().removeFlashcardAt(index);
            });

            //showing a snackBar.
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('flashcard is deleted')));
          },
          child: GestureDetector(
            onTap: () {
              context.read<NavigationManager>().setDetailsScreen(true);
              context.read<FlashcardManager>().setSelectedFlashcardIndex(index);
            },
            child: Card(
              elevation: 5.0,
              child: SizedBox(
                height: 100.0,
                child: Center(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 0, 10),
                      child: Text(
                        flashcards[index].frontSide,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: IconTheme(
                              data: Theme.of(context).primaryIconTheme,
                              child: const Icon(Icons.edit)),
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
                        IconButton(
                          onPressed: () {
                            context.read<FlashcardManager>().updateIsFavoriteAt(index);
                          },
                          icon: IconTheme(
                            data: Theme.of(context).primaryIconTheme,
                            child: Icon(
                              (isFavorite(index))
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_border_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
