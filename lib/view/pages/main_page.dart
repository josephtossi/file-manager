import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:file_manager_project/constants.dart';
import 'package:file_manager_project/view/pages/create_folder_or_file.dart';
import 'package:file_manager_project/view/pages/folders_contents_screen.dart';
import 'package:file_manager_project/view/widgets/file_explorer_folder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
    return VisibilityDetector(
      onVisibilityChanged: (VisibilityInfo visibility) {
        if (visibility.visibleFraction > 0.0 && mounted) {
          checkPermission();
          _getCurrentDirectory();
        }
      },
      key: const ObjectKey('main_page'),
      child: Scaffold(
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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateFolderOrFile(folderPath: _currentDirectory.path)),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
