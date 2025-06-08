// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_incident.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateIncidentAdapter extends TypeAdapter<CreateIncident> {
  @override
  final int typeId = 0;

  @override
  CreateIncident read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateIncident(
      id: fields[0] as int?,
      title: fields[1] as String,
      description: fields[2] as String,
      category: fields[3] as String,
      location: fields[4] as String,
      dateTime: fields[5] as String,
      status: fields[6] as String,
      photo: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CreateIncident obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateIncidentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
