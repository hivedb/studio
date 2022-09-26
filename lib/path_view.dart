import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studio/app_state.dart';

class PathView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState app, Widget? child) {
        return Row(
          children: <Widget>[
            _buildPathElement(app.boxName),
            for (var i = 0; i < app.path.length; i++) _buildPathElement(app.path[i]),
          ],
        );
      },
    );
  }

  Widget _buildPathElement(String name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
