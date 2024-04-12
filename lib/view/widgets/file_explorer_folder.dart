import 'dart:io';
import 'package:file_manager_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class FileExplorerFolder extends StatefulWidget {
  final FileSystemEntity entity;
  Function navigateToDirectory;

  FileExplorerFolder(
      {super.key, required this.entity, required this.navigateToDirectory});

  @override
  State<FileExplorerFolder> createState() => _FileExplorerFolderState();
}

class _FileExplorerFolderState extends State<FileExplorerFolder> {
  late FileSystemEntity _fileSystemEntity;

  Future<void> _launchFile(String filePath) async {
    try {
      OpenFile.open(filePath);
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Could not launch file.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    _fileSystemEntity = widget.entity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDirectory =
        FileSystemEntity.isDirectorySync(_fileSystemEntity.path);

    return GestureDetector(
      onTap: () async {
        if (isDirectory) {
          widget.navigateToDirectory(_fileSystemEntity.path);
        } else {
          _launchFile(_fileSystemEntity.path);
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          gradient:
              isDirectory ? Constant.whiteLinearGradient : Constant.redGradient,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  Icon(
                    isDirectory ? Icons.folder : Icons.insert_drive_file,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _fileSystemEntity.path.split('/').last.length > 35
                        ? '${_fileSystemEntity.path.split('/').last.substring(0, 35)} ...'
                        : _fileSystemEntity.path.split('/').last,
                    overflow: TextOverflow.ellipsis,
                    style: Constant.subtitle2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Icon(
                isDirectory ? Icons.arrow_forward_ios : Icons.open_in_browser,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
