import 'dart:typed_data';

import 'package:hive/hive.dart';

class ObjectAdapter extends TypeAdapter<Object> {
  final int _typeId;

  ObjectAdapter(this._typeId);

  @override
  int get typeId => _typeId;

  @override
  Object read(BinaryReader reader) {
    var bytes = reader.peekBytes(reader.availableBytes);
    try {
      var numOfFields = reader.readByte();
      return {
        for (var i = 0; i < numOfFields; i++)
          'field ${reader.readByte()}': reader.read(),
      };
    } catch (e) {
      return Uint8List.fromList(bytes);
    }
  }

  @override
  void write(BinaryWriter writer, Object obj) {
    throw UnimplementedError();
  }
}
