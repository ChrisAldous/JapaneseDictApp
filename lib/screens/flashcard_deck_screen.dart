import 'package:flutter/material.dart';
import 'package:japanese_dict/data/db_helper.dart';
import 'package:provider/provider.dart';

class FlashcardDeckScreen extends StatefulWidget {
  const FlashcardDeckScreen({super.key, required String deckName});

  @override
  State<FlashcardDeckScreen> createState() => _FlashcardDeckScreenState();
}

class _FlashcardDeckScreenState extends State<FlashcardDeckScreen> {
  late DbHelper db;
  int? folderId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      db = context.read<DbHelper>();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
