import 'package:flutter/material.dart';
import 'package:flashcards/view_model/view_model.dart';
import 'package:provider/provider.dart';
import 'custom_popup_menu_button.dart';

class FlashcardForm extends StatefulWidget {
  final String appBarTitle;

  FlashcardForm({Key? key, required this.appBarTitle}) : super(key: key);

  @override
  State<FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  //Validating the form
  final _inputFormKey = GlobalKey<FormState>();

  final collectionTitleTextEditingController = TextEditingController();
  final frontSideTextEditingController = TextEditingController();
  final backSideTextEditingController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    collectionTitleTextEditingController.dispose();
    frontSideTextEditingController.dispose();
    backSideTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isCreatingNewFlashcard =
        context.read<FlashcardManager>().isCreatingNewFlashcard;

    bool isCreatingNewCollection =
        context.read<FlashcardManager>().isCreatingNewCollection;

    collectionTitleTextEditingController.text = isCreatingNewCollection
        ? ''
        : context
            .read<FlashcardManager>()
            .fetchSelectedCollection
            .collectionName;

    // setting initial values if the existing flashcard is updating
    frontSideTextEditingController.text =
        (isCreatingNewCollection || isCreatingNewFlashcard)
            ? ''
            : context.read<FlashcardManager>().fetchSelectedFlashcard.frontSide;

    backSideTextEditingController.text =
        (isCreatingNewCollection || isCreatingNewFlashcard)
            ? ''
            : context.read<FlashcardManager>().fetchSelectedFlashcard.backSide;

    return Scaffold(
      appBar: AppBar(
        // hiding the back button when automaticallyImplyLeading is false.
        automaticallyImplyLeading: false,
        title: Text(widget.appBarTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _inputFormKey,
          child: ListView(
            children: <Widget>[
              // collection name
              TextFormField(
                minLines: 1,
                maxLines: 10,
                controller: collectionTitleTextEditingController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('collection name'),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                minLines: 10,
                maxLines: 30,
                controller: frontSideTextEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('front side'),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                minLines: 10,
                maxLines: 20,
                controller: backSideTextEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('back side'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                context.read<NavigationManager>().setEditorScreen(false);
              },
              icon: const Icon(Icons.arrow_back_outlined),
            ),
            IconButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_inputFormKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved')),
                  );
                  // moving to the flashcard list screen and creating or updating
                  // either collection or flashcard.
                  context.read<FlashcardManager>().saveFlashcard(
                        collectionTitle:
                            collectionTitleTextEditingController.text,
                        frontSide: frontSideTextEditingController.text,
                        backSide: backSideTextEditingController.text,
                      );
                  context.read<NavigationManager>().setEditorScreen(false);
                }
              },
              icon: const Icon(Icons.done_outlined),
            ),
            CustomPopupMenuButton(),
          ],
        ),
      ),
    );
  }
}
