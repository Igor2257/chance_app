// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineModelAdapter extends TypeAdapter<MedicineModel> {
  @override
  final int typeId = 4;

  @override
  MedicineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineModel(
      id: fields[0] as String,
      message: fields[1] as String,
      medicineType: fields[2] as String,
      periodicity: fields[3] as String,
      medicineInstruction: fields[4] as String,
      weekdays: (fields[5] as List).cast<int>(),
      doses: (fields[6] as Map).cast<MyTimeOfDay, int>(),
      startDate: fields[7] as DateTime?,
      isDone: fields[8] as bool,
      userId: fields[9] as String,
      isNotificationSent: fields[10] as bool,
      isSentToDB: fields[11] as bool,
      isRemoved: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.medicineType)
      ..writeByte(3)
      ..write(obj.periodicity)
      ..writeByte(4)
      ..write(obj.medicineInstruction)
      ..writeByte(5)
      ..write(obj.weekdays)
      ..writeByte(6)
      ..write(obj.doses)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.isDone)
      ..writeByte(9)
      ..write(obj.userId)
      ..writeByte(10)
      ..write(obj.isNotificationSent)
      ..writeByte(11)
      ..write(obj.isSentToDB)
      ..writeByte(12)
      ..write(obj.isRemoved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
