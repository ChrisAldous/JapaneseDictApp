import 'package:flutter/material.dart';
import 'package:japanese_dict/data/db_helper.dart';
import 'package:japanese_dict/screens/widgets/custom_drawer.dart';
import 'package:japanese_dict/screens/widgets/flip_flashcard.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FlashcardDeckScreen extends StatefulWidget {
  final String deckName;

  const FlashcardDeckScreen({super.key, required this.deckName});

  @override
  State<FlashcardDeckScreen> createState() => _FlashcardDeckScreenState();
}

class _FlashcardDeckScreenState extends State<FlashcardDeckScreen> {
  late DbHelper db;
  late String deckTitle;
  List<FlashCard> flashcards = [];
  int? folderId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    deckTitle = widget.deckName;

    Future.microtask(() async {
      db = context.read<DbHelper>();
      _getFolderIDByName(deckTitle);
    });
  }

  Future<void> _getFolderIDByName(String deckTitle) async {
    final FlashFolder? folder = await db.foldersDao.selectedFolder(
      folderName: deckTitle,
    );

    if (folder != null) {
      final fetchedCards = await db.flashcardsDao.getAllFlashCardsInDeck(
        folder.id,
      );
      setState(() {
        folderId = folder.id;
        flashcards = fetchedCards;
        flashcards.shuffle();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 210, 24, 11),
          title: Text('$deckTitle'),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : flashcards.isEmpty
          ? Center(child: Text('This deck is Empty'))
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 400,
                        child: SwipableStack(
                          itemCount: flashcards.length,
                          detectableSwipeDirections: const {
                            SwipeDirection.right,
                            SwipeDirection.left,
                          },
                          stackClipBehaviour: Clip.none,
                          onSwipeCompleted: (index, direction) {
                            print('Swiped card $index: $direction');
                          },
                          builder: (context, properties) {
                            final card = flashcards[properties.index];
                            return FlipFlashcard(card: card);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
