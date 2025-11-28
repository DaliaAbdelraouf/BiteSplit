// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeopleGroupAdapter extends TypeAdapter<PeopleGroup> {
  @override
  final int typeId = 1;

  @override
  PeopleGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeopleGroup(
      name: fields[0] as String,
      people: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PeopleGroup obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.people);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeopleGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
