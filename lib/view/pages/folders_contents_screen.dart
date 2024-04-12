import 'dart:io';
import 'package:file_manager_project/constants.dart';
import 'package:file_manager_project/view/widgets/file_explorer_folder.dart';
import 'package:flutter/material.dart';

class FolderContentsScreen extends StatefulWidget {
  final String folderPath;

  const FolderContentsScreen({super.key, required this.folderPath});

  @override
  // ignore: library_private_types_in_public_api
  _FolderContentsScreenState createState() => _FolderContentsScreenState();
}

class _FolderContentsScreenState extends State<FolderContentsScreen> {
  late Directory _currentDirectory;
  late List<FileSystemEntity> _filesAndFolders;

  void _navigateToDirectory(String path) {
    if (FileSystemEntity.isDirectorySync(path)) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FolderContentsScreen(folderPath: path)),
      );
    } else {
      // Handle opening files
    }
  }

  @override
  void initState() {
    super.initState();
    _currentDirectory = Directory(widget.folderPath);
    _filesAndFolders = _currentDirectory.listSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.grey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Constant.lightBlue,
        title: Text(
          'Contents of ${widget.folderPath.split('/').last}',
          style: Constant.subtitle2,
        ),
      ),
      body: ListView.builder(
        itemCount: _filesAndFolders.length,
        itemBuilder: (context, index) {
          return FileExplorerFolder(
            navigateToDirectory: _navigateToDirectory,
            entity: _filesAndFolders[index],
          );
        },
      ),
    );
  }
}
