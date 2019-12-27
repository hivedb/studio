import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studio/app_state.dart';

class PathView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState app, Widget child) {
        return Row(
          children: <Widget>[
            _buildPathElement(app.boxName, () {
              app.path = [];
            }, divider: false),
            for (var i = 0; i < app.path.length; i++)
              _buildPathElement(app.path[i], () {
                app.path = app.path.sublist(0, i + 1);
              }),
          ],
        );
      },
    );
  }

  Widget _buildPathElement(String name, VoidCallback goto,
      {bool divider = true}) {
    return InkWell(
      onTap: goto,
      child: Text(
        divider ? '> $name' : name,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
