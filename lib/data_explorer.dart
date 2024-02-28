import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studio/app_state.dart';
import 'package:studio/path_view.dart';

class DataExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var app = Provider.of<AppState>(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 900),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
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
                    if (false)
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 250),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            hintText: 'Search the box',
                            contentPadding: EdgeInsets.fromLTRB(20, 8, 12, 8),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                if (app.path.isEmpty)
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: app.entries.length,
                        itemBuilder: (context, index) {
                          var mapEntry = app.entries.entries.elementAt(index);
                          return EntryWidget(
                              mapEntry.key.toString(), mapEntry.value);
                        },
                      ),
                    ),
                  )
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
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  entryKey,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
