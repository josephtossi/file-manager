import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:file_manager_project/constants.dart';
import 'package:file_manager_project/view/pages/folders_contents_screen.dart';
import 'package:file_manager_project/view/widgets/file_explorer_folder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Directory _currentDirectory;
  List<FileSystemEntity> _filesAndFolders = [];

  checkPermission() async {
    if (Platform.isAndroid) {
      await Permission.manageExternalStorage.request();
    } else {
      await Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
    _getCurrentDirectory();
  }

  void _navigateToDirectory(String path) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FolderContentsScreen(folderPath: path)),
    );
  }

  Future<void> _getCurrentDirectory() async {
    try {
      List<String> mainPaths =
          await ExternalPath.getExternalStorageDirectories();
      if (mainPaths.isNotEmpty) {
        Directory? appDirectory = Directory(mainPaths.first);
        setState(() {
          _currentDirectory = appDirectory;
          _filesAndFolders = appDirectory.listSync();
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.grey,
      appBar: AppBar(
        backgroundColor: Constant.lightBlue,
        title: const Text(
          'File Explorer',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement functionality to create new files and folders
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
