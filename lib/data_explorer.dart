import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import 'package:provider/provider.dart';
import 'package:studio/app_state.dart';
import 'package:studio/path_view.dart';

class DataExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var app = Provider.of<AppState>(context);
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: PathView(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              if (app.path.isEmpty)
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: app.entries.length,
                      itemBuilder: (context, index) {
                        var mapEntry = app.entries.entries.elementAt(index);
                        return EntryWidget(mapEntry.key.toString(), mapEntry.value);
                      },
                    ),
                  ),
                ),

              /// Adds a little buffer between the last json and the bottom of the view
              SizedBox(height: 16),
              /*else
                Expanded(
                  child: ListView.builder(
                    itemCount: app.entries.length,
                    itemBuilder: (context, index) {
                      return EntryWidget(app.entries[index]);
                    },
                  ),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class EntryWidget extends StatelessWidget {
  final String entryKey;
  final dynamic value;

  EntryWidget(this.entryKey, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.grey[300]!),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: JsonViewer({entryKey: jsonDecode(jsonEncode(value))}),
      ),
    );
  }
}
