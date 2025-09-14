import 'package:flutter/material.dart';
import 'package:japanese_dict/data/db_helper.dart';
import 'package:japanese_dict/data/daos/folders_dao.dart';
import 'package:japanese_dict/data/tables/folders.dart';
import 'package:japanese_dict/screens/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  late DbHelper db;
  List<FlashFolder> folderList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      db = context.read<DbHelper>();
      await _getFolderList();
    });
  }

  Future<void> _getFolderList() async {
    final foldersDao = db.foldersDao;
    final fetchedFolders = await foldersDao.getAllFolders();

    setState(() {
      folderList = fetchedFolders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 210, 24, 11),
          title: Text('Japanese Dictionary'),
        ),
      ),
      drawer: CustomDrawer(),
      body: folderList.isEmpty
          ? Center(child: Text("No folders found."))
          : ListView.builder(
              itemCount: folderList.length,
              itemBuilder: (context, index) {
                final folder = folderList[index];
                return ListTile(
                  leading: Icon(Icons.folder),
                  title: Text(folder.name),
                  onTap: () {
                    // Navigate to that folder's flashcards
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // openDialog();
        },
        backgroundColor: Color.fromARGB(255, 210, 24, 11),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
