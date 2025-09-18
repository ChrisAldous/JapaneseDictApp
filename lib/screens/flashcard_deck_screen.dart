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
  int? folderId;

  @override
  void initState() {
    super.initState();
    deckTitle = widget.deckName;

    Future.microtask(() async {
      db = context.read<DbHelper>();
    });
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
      body: Placeholder(),
    );
  }
}
