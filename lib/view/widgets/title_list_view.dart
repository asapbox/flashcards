import 'package:flashcards/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/view_model/flashcard_manager.dart';

class TitlesListView extends StatefulWidget {
  const TitlesListView({Key? key}) : super(key: key);

  @override
  State<TitlesListView> createState() => _TitlesListViewState();
}

class _TitlesListViewState extends State<TitlesListView> {
  @override
  Widget build(BuildContext context) {
    final List<String> collectionTitles =
        context.read<FlashcardManager>().fetchCollectionTitles;

    return Container(
      padding: const EdgeInsets.all(5.0),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        itemCount: collectionTitles.length,
        itemBuilder: (context, index) {
          return Dismissible(
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
              setState(
                () {
                  context.read<FlashcardManager>().removeCollectionAt(index);
                },
              );
              //showing a snackBar.
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('set is deleted')));
            },
            confirmDismiss: (DismissDirection direction) {
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text(
                        "Are you sure you want to delete this collection?"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Yes")),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("No"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              elevation: 5.0,
              child: SizedBox(
                height: 110,
                child: ListTile(
                  title: Center(
                    child: Text(
                      collectionTitles[index],
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  onTap: () {
                    context
                        .read<FlashcardManager>()
                        .setSelectedCollectionIndex(index);
                    context
                        .read<NavigationManager>()
                        .setFlashcardListScreen(true);
                  },
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 4.0,
          );
        },
      ),
    );
  }
}
