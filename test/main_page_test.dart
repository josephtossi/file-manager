import 'package:file_manager_project/view/pages/create_folder_or_file.dart';
import 'package:file_manager_project/view/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('MainPage displays correct initial state',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: MainPage(),
    ));

    expect(find.text('File Explorer'), findsOneWidget);

    await tester.pump();
  });

  testWidgets('MainPage navigates to folder contents screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: MainPage(),
    ));

    // Tap on a file or folder to navigate
    await tester.tap(find.byType(GestureDetector).first);
  });

  testWidgets('CreateFolderOrFile - Folder creation test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CreateFolderOrFile(
          folderPath: '/some/test/path',
        ),
      ),
    ));

    await tester.enterText(find.byType(TextField), 'NewFolder');

    await tester.tap(find.text('Create Folder'));

    await tester.pumpAndSettle();

    // Verify that the folder creation is successful
    expect(find.text('NewFolder'), findsOneWidget);
  });
}
