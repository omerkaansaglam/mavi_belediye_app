// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facilities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacilitiesAdapter extends TypeAdapter<Facilities> {
  @override
  final int typeId = 1;

  @override
  Facilities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Facilities(
      id: fields[0] as int,
      title: fields[1] as String,
      isFavorited: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Facilities obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isFavorited);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacilitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
