import 'package:flutter/material.dart';
import 'package:japanese_dict/data/db_helper.dart';
import 'package:japanese_dict/data/tables/flashcards.dart';

class FlipFlashcard extends StatefulWidget {
  final FlashCard card;

  const FlipFlashcard({super.key, required this.card});

  @override
  State<FlipFlashcard> createState() => _FlipFlashcardState();
}

class _FlipFlashcardState extends State<FlipFlashcard> {
  bool isFlipped = false;

  void toggleCard() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation){
          return RotationYTransition(
            turns: animation,
            child: child,
          );
        },
        child: isFlipped
          ? _buildCard(widget.card.back, Colors.grey[300]!)
          : widget.card.front_kanji.isNotEmpty
            ? _buildCard('${widget.card.front_kanji}(${widget.card.front_kana})', Colors.white)
            :  _buildCard(widget.card.front_kana ?? '', Colors.white)
      ),
    );
  }

  Widget _buildCard(String text, Color color){
    return Container(
      key: ValueKey<bool>(isFlipped),
      height: 300,
      width: 400,
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class RotationYTransition extends AnimatedWidget {
  final Widget child;
  RotationYTransition({required Animation<double> turns, required this.child})
      : super(listenable: turns);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final angle = animation.value * 3.1416;

    return Transform(
      transform: Matrix4.rotationY(angle),
      alignment: Alignment.center,
      child: animation.value > 0.5
          ? Transform(
              transform: Matrix4.rotationY(3.1416),
              alignment: Alignment.center,
              child: child,
            )
          : child,
    );
  }
}
