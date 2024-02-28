import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:studio/app_state.dart';
import 'package:studio/file_upload.dart';
import 'package:studio/object_adapter.dart';

void main() {
  for (var i = 0; i < 224; i++) {
    Hive.registerAdapter(ObjectAdapter(i));
  }
  runApp(MyApp());
}

final appState = AppState();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Studio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFE6EBEB),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Image.asset('assets/logo.png'),
              ),
              onTap: () {
                appState.status = UploadStatus.none;
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ChangeNotifierProvider(
                child: FileUpload(),
                create: (context) => appState,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
