import 'package:flashcards/view/widgets/flipping_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/view_model/view_model.dart';
import 'package:flashcards/view/widgets/widgets.dart';
import 'package:flashcards/model/model.dart';
import 'dart:math';

class DetailsScreen extends StatefulWidget {

  static MaterialPage page() {
    return MaterialPage(
      name: Paths.detailsScreenPath,
      key: ValueKey(Paths.detailsScreenPath),
      child: DetailsScreen(),
    );
  }

  DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // delete
    final Flashcard flashcard =
        context.read<FlashcardManager>().fetchSelectedFlashcard;
    final int? selectedFlashcardIndex =
        context.read<FlashcardManager>().selectedFlashcardIndex;
    final bool isFavorite =
        context.watch<FlashcardManager>().fetchSelectedFlashcard.isFavorite;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Details screen'),
      ),
      body: SwipingAnimation(
        selectedFlashcardIndex: selectedFlashcardIndex!,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                context.read<NavigationManager>().setDetailsScreen(false);
              },
              icon: const Icon(Icons.arrow_back_outlined),
            ),
            IconButton(
              onPressed: () {
                context.read<FlashcardManager>().updateIsFavorite();
              },
              icon: Icon(
                (isFavorite)
                    ? Icons.favorite_outlined
                    : Icons.favorite_border_outlined,
              ),
            ),
            CustomPopupMenuButton(),
          ],
        ),
      ),
    );
  }
}
