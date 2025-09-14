import 'package:flutter/material.dart';
import 'package:japanese_dict/screens/search_screen.dart';
import 'package:japanese_dict/screens/folders_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 72.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Search"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: Text("Flashcards"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => FoldersScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
