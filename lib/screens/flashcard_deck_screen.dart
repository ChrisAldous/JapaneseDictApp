import 'package:flutter/material.dart';
import 'package:japanese_dict/data/db_helper.dart';
import 'package:japanese_dict/screens/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

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
      drawer: CustomDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : flashcards.isEmpty
          ? Center(child: Text('This deck is Empty'))
          : ListView.builder(
              itemCount: flashcards.length,
              itemBuilder: (context, index) {
                final card = flashcards[index];
                return ListTile(
                  title: Text(
                    card.front_kanji
                  ),
                  subtitle: Text(card.back),
                );
              },
            ),
    );
  }
}
