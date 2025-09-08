import 'package:flutter/material.dart';
import 'package:japanese_dict/data/db_helper.dart';
import 'package:japanese_dict/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DbHelper>(
      create: (_) => DbHelper(), // DbHelper is created once here
      dispose: (_, db) => db.close(), // Optional: closes DB when app exits
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SearchScreen(),
        ),
      );
  }
}
