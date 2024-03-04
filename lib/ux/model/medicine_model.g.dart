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
      reminderIds: (fields[1] as List).cast<int>(),
      name: fields[2] as String,
      type: fields[3] as MedicineType,
      periodicity: fields[4] as Periodicity,
      startDate: fields[5] as DateTime,
      weekdays: (fields[6] as List).cast<int>(),
      doses: (fields[7] as Map).cast<int, int>(),
      instruction: fields[8] as Instruction,
      doneAt: (fields[9] as List).cast<DateTime>(),
      userId: fields[11] as String,
      isSentToDB: fields[12] as bool,
      isRemoved: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.reminderIds)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.periodicity)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.weekdays)
      ..writeByte(7)
      ..write(obj.doses)
      ..writeByte(8)
      ..write(obj.instruction)
      ..writeByte(9)
      ..write(obj.doneAt)
      ..writeByte(11)
      ..write(obj.userId)
      ..writeByte(12)
      ..write(obj.isSentToDB)
      ..writeByte(13)
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicineModelImpl _$$MedicineModelImplFromJson(Map<String, dynamic> json) =>
    _$MedicineModelImpl(
      id: json['id'] as String? ?? "",
      reminderIds:
          (json['reminderIds'] as List<dynamic>).map((e) => e as int).toList(),
      name: json['name'] as String,
      type: $enumDecode(_$MedicineTypeEnumMap, json['type']),
      periodicity: $enumDecode(_$PeriodicityEnumMap, json['periodicity']),
      startDate: DateTime.parse(json['startDate'] as String),
      weekdays:
          (json['weekdays'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
      doses: (json['doses'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
      instruction:
          $enumDecodeNullable(_$InstructionEnumMap, json['instruction']) ??
              Instruction.noMatter,
      doneAt: (json['doneAt'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      userId: json['userId'] as String? ?? "",
      isSentToDB: json['isSentToDB'] as bool? ?? false,
      isRemoved: json['isRemoved'] as bool? ?? false,
    );

Map<String, dynamic> _$$MedicineModelImplToJson(_$MedicineModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reminderIds': instance.reminderIds,
      'name': instance.name,
      'type': _$MedicineTypeEnumMap[instance.type]!,
      'periodicity': _$PeriodicityEnumMap[instance.periodicity]!,
      'startDate': instance.startDate.toIso8601String(),
      'weekdays': instance.weekdays,
      'doses': instance.doses.map((k, e) => MapEntry(k.toString(), e)),
      'instruction': _$InstructionEnumMap[instance.instruction]!,
      'doneAt': instance.doneAt.map((e) => e.toIso8601String()).toList(),
      'userId': instance.userId,
      'isSentToDB': instance.isSentToDB,
      'isRemoved': instance.isRemoved,
    };

const _$MedicineTypeEnumMap = {
  MedicineType.pill: 'pill',
  MedicineType.injection: 'injection',
  MedicineType.solution: 'solution',
  MedicineType.drops: 'drops',
  MedicineType.powder: 'powder',
  MedicineType.other: 'other',
};

const _$PeriodicityEnumMap = {
  Periodicity.everyDay: 'everyDay',
  Periodicity.certainDays: 'certainDays',
};

const _$InstructionEnumMap = {
  Instruction.beforeEating: 'beforeEating',
  Instruction.whileEating: 'whileEating',
  Instruction.afterEating: 'afterEating',
  Instruction.noMatter: 'noMatter',
};
