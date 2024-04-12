import 'dart:io';

import 'package:file_manager_project/constants.dart';
import 'package:flutter/material.dart';

class CreateFolderOrFile extends StatefulWidget {
  final String folderPath;

  const CreateFolderOrFile({super.key, required this.folderPath});

  @override
  State<CreateFolderOrFile> createState() => _CreateFolderOrFileState();
}

class _CreateFolderOrFileState extends State<CreateFolderOrFile> {
  List<Map> buttons = [
    {'name': 'Folder', 'isOn': true},
    {'name': 'File', 'isOn': false},
  ];
  final TextEditingController _fileNameController = TextEditingController();

  Future<void> _createFile() async {
    String filePath = '${widget.folderPath}/${_fileNameController.text}.txt';
    File file = File(filePath);
    if (!(await file.exists())) {
      file.createSync();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      print('File already exists: $filePath');
    }
  }

  Future<void> _createFolder() async {
    String folderPath = '${widget.folderPath}/${_fileNameController.text}';
    Directory folder = Directory(folderPath);
    if (!(await folder.exists())) {
      folder.createSync(recursive: true);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      print('Folder already exists: $folderPath');
    }
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.disabledColor,
          title: const Text(
            'Folder and File Creation',
            style: Constant.subtitle2,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 25, left: 25, bottom: 50),
                child: TextField(
                  controller: _fileNameController,
                  decoration: InputDecoration(
                    labelText:
                        'Enter ${buttons[0]['isOn'] ? 'Folder' : 'File'} Name',
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: buttons.map((button) {
                    return Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (buttons[0]['isOn']) {
                                buttons[0]['isOn'] = false;
                                buttons[1]['isOn'] = true;
                              } else {
                                buttons[1]['isOn'] = false;
                                buttons[0]['isOn'] = true;
                              }
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  gradient: button['isOn']
                                      ? Constant.redGradient
                                      : Constant.whiteLinearGradient),
                              child: Center(
                                  child: Text(
                                '${button['name']}',
                                style: Constant.hintStyle,
                              ))),
                        ));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (buttons[0]['isOn']) {
                    _createFolder();
                  } else {
                    _createFile();
                  }
                },
                child: Text('Create ${buttons[0]['isOn'] ? 'Folder' : 'File'}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
