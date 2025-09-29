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
  SwipableStackController? _controller;
  bool reachedEndOfDeck = false;

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
        flashcards = List.from(fetchedCards)..shuffle();
        _controller = SwipableStackController();
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
          ? Center(
              child: Text(
                'This deck is Empty',
                style: TextStyle(fontSize: 24.0),
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: reachedEndOfDeck
                        ? Center(
                            child: Text(
                              "End of the Deck!",
                              style: TextStyle(fontSize: 24.0),
                            ),
                          )
                        : Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 400,
                              child: SwipableStack(
                                controller: _controller!,
                                itemCount: flashcards.length,
                                detectableSwipeDirections: const {
                                  SwipeDirection.right,
                                  SwipeDirection.left,
                                },
                                stackClipBehaviour: Clip.none,
                                onSwipeCompleted: (index, direction) {
                                  print(
                                    'Swiped card $index: $direction ${flashcards.length}',
                                  );
                                  if (index + 1 == flashcards.length) {
                                    setState(() {
                                      reachedEndOfDeck = true;
                                    });
                                  }
                                },
                                builder: (context, properties) {
                                  final card = flashcards[properties.index];
                                  return FlipFlashcard(card: card);
                                },
                              ),
                            ),
                          ),
                  ),

                  Expanded(flex: 1, child: ResetBtn(deckTitle)),
                ],
              ),
            ),
    );
  }

  Widget ResetBtn(String deckName) {
    return SizedBox(
      width: 100,
      height: 20,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: TextButton(
          onPressed: () async {
            setState(() {
              reachedEndOfDeck = false;
              isLoading = true;
            });
            await _getFolderIDByName(deckName);
          },
          style: TextButton.styleFrom(backgroundColor: Colors.red),
          child: Text(
            'RESET',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
