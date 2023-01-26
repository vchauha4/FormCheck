// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelClassStats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataStatsAdapter extends TypeAdapter<DataStats> {
  @override
  final int typeId = 0;

  @override
  DataStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataStats()
      ..BenchCount = fields[0] as int
      ..SquatsCount = fields[1] as int
      ..DeadliftCount = fields[2] as int
      ..BenchScore = fields[3] as double
      ..SquatsScore = fields[4] as double
      ..DeadliftScore = fields[5] as double
      ..Name = fields[6] as String
      ..picture = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, DataStats obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.BenchCount)
      ..writeByte(1)
      ..write(obj.SquatsCount)
      ..writeByte(2)
      ..write(obj.DeadliftCount)
      ..writeByte(3)
      ..write(obj.BenchScore)
      ..writeByte(4)
      ..write(obj.SquatsScore)
      ..writeByte(5)
      ..write(obj.DeadliftScore)
      ..writeByte(6)
      ..write(obj.Name)
      ..writeByte(7)
      ..write(obj.picture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
