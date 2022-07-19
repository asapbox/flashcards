import 'package:flutter/material.dart';
import 'package:flashcards/view/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/view_model/view_model.dart';

class SwipingAnimation extends StatefulWidget {
  final int selectedFlashcardIndex;

  const SwipingAnimation({
    Key? key,
    required this.selectedFlashcardIndex,
  }) : super(key: key);

  @override
  State<SwipingAnimation> createState() => _SwipingAnimationState();
}

class _SwipingAnimationState extends State<SwipingAnimation> {
  PageController pageController = PageController();
  var currentPageValue = 0.0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  // didChangeDependencies is called immediately after initState to
  // set the index of a chosen flashcard as an initial page.
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.selectedFlashcardIndex);
      currentPageValue = pageController.page!;
    });
    super.didChangeDependencies();
  }

  void updateCurrentPageValue() {
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcards = context.read<FlashcardManager>().fetchSelectedFlashcards;

    return PageView.builder(
      pageSnapping: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (position) {
        debugPrint('Page: ${position + 1}');
        debugPrint('PageValue: ${pageController.page}');
        updateCurrentPageValue();

        context.read<FlashcardManager>().setSelectedFlashcardIndex(position);

      },
      controller: pageController,
      itemCount: flashcards.length,
      itemBuilder: (context, int position) {
        if (position == currentPageValue.floor()) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(currentPageValue - position)
              ..rotateY(currentPageValue - position)
              ..rotateZ(currentPageValue - position),
            child: FlippingAnimation(
              frontSide: flashcards[position].frontSide,
              backSide: flashcards[position].backSide,
              selectedFlashcardIndex: position,
            ),
          );
        } else if (position == currentPageValue.floor() + 1) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(currentPageValue - position)
              ..rotateY(currentPageValue - position)
              ..rotateZ(currentPageValue - position),
            child: FlippingAnimation(
              frontSide: flashcards[position].frontSide,
              backSide: flashcards[position].backSide,
              selectedFlashcardIndex: position,
            ),
          );
        } else {
          return FlippingAnimation(
            frontSide: flashcards[position].frontSide,
            backSide: flashcards[position].backSide,
            selectedFlashcardIndex: position,
          );
        }
      },
    );
  }
}
