import 'package:flutter/material.dart';
import 'dart:math';

class FlippingAnimation extends StatefulWidget {
  final String frontSide;
  final String backSide;
  final int selectedFlashcardIndex;

  const FlippingAnimation({
    Key? key,
    required this.frontSide,
    required this.backSide,
    required this.selectedFlashcardIndex,
  }) : super(key: key);

  @override
  State<FlippingAnimation> createState() => _FlippingAnimationState();
}

class _FlippingAnimationState extends State<FlippingAnimation> {
  late bool _showFrontSide;
  late bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Center(
          child: _buildFlipAnimation(
        frontSide: widget.frontSide,
        backSide: widget.backSide,
        selectedFlashcardIndex: widget.selectedFlashcardIndex,
      )),
    );
  }

  void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipAnimation({
    required String frontSide,
    required String backSide,
    required int selectedFlashcardIndex,
  }) {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide
            ? _buildFrontSide(frontSide, selectedFlashcardIndex)
            : _buildBackSide(backSide, selectedFlashcardIndex),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFrontSide(String frontSide, int selectedFlashcardIndex) {
    return Card(
      key: ValueKey('frontSideIndex:$selectedFlashcardIndex'),
      child: SizedBox(
        width: 300.0,
        height: 600.0,
        child: Center(
          child: Text(frontSide),
        ),
      ),
    );
  }

  Widget _buildBackSide(String backSide, int selectedFlashcardIndex) {
    return Card(
      key: ValueKey('backSideIndex:$selectedFlashcardIndex'),
      child: SizedBox(
        width: 300.0,
        height: 600.0,
        child: Center(
          child: Text(backSide),
        ),
      ),
    );
  }
}

// need to add Scrollbar class
// pageView for detailsScreen
