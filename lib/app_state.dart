import 'package:flutter/foundation.dart';

import 'upload_status_enum.dart';

class AppState extends ChangeNotifier {
  UploadStatus _status = UploadStatus.none;
  UploadStatus get status => _status;
  set status(UploadStatus status) {
    _status = status;
    notifyListeners();
  }

  String _boxName = '';
  String get boxName => _boxName;
  set boxName(String boxName) {
    _boxName = boxName;
    notifyListeners();
  }

  Map<dynamic, dynamic> _entries = {};
  Map<dynamic, dynamic> get entries => _entries;
  set entries(Map<dynamic, dynamic> entries) {
    _entries = entries;
    notifyListeners();
  }

  List<String> _path = [];
  List<String> get path => _path;
  set path(List<String> path) {
    _path = path;
    notifyListeners();
  }
}
