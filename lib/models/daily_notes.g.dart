// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_notes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyNotesAdapter extends TypeAdapter<DailyNotes> {
  @override
  final int typeId = 0;

  @override
  DailyNotes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyNotes(
      date: fields[0] as String,
      content: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyNotes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyNotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
