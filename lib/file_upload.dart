import 'dart:async';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:studio/app_state.dart';
import 'package:studio/data_explorer.dart';

import 'upload_status_enum.dart';

class FileUpload extends StatefulWidget {
  @override
  _FileUploadState createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  StreamSubscription _dragOverSubscription;
  StreamSubscription _dropSubscription;

  @override
  void initState() {
    super.initState();

    _dropSubscription = document.body.onDragOver.listen(_onDragOver);
    _dropSubscription = document.body.onDrop.listen(_onDrop);
  }

  void _onDragOver(MouseEvent event) {
    event.stopPropagation();
    event.preventDefault();
  }

  void _onDrop(MouseEvent event) {
    event.stopPropagation();
    event.preventDefault();
    var files = event.dataTransfer.files;

    if (files == null || files.isEmpty) return;

    var file = files.first;
    var reader = FileReader();
    reader.onLoadEnd.listen((e) {
      process(file.name, reader.result as Uint8List, context);
    });
    reader.readAsArrayBuffer(file);

    var appState = Provider.of<AppState>(context, listen: false);
    appState.status = UploadStatus.processing;
  }

  void process(String name, Uint8List bytes, BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);
    scheduleMicrotask(() async {
      try {
        var box = await Hive.openBox('box', bytes: bytes);
        var map = box.toMap();
        appState.boxName = name;
        appState.entries = map;
        appState.status = UploadStatus.success;
      } catch (e) {
        appState.status = UploadStatus.failed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var app = Provider.of<AppState>(context);
    switch (app.status) {
      case UploadStatus.none:
        return Center(
          child: Text('Drop a .hive file to begin\n\n(This is a preview version)'),
        );
      case UploadStatus.processing:
        return Center(
          child: Text('Processing file'),
        );
      case UploadStatus.failed:
        return Center(
          child: Text('Invalid file'),
        );
      case UploadStatus.success:
        return DataExplorer();
    }
  }

  @override
  void dispose() {
    _dragOverSubscription?.cancel();
    _dropSubscription?.cancel();
    super.dispose();
  }
}
