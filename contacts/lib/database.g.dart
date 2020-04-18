// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseAdapter extends TypeAdapter<Database> {
  @override
  final typeId = 0;

  @override
  Database read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Database(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Database obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email);
  }
}
