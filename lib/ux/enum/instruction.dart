import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'instruction.g.dart';

@JsonEnum()
@HiveType(typeId: HiveTypeId.instruction)
enum Instruction {
  @HiveField(0)
  beforeEating,
  @HiveField(1)
  whileEating,
  @HiveField(2)
  afterEating,
  @HiveField(3)
  noMatter;

  String toLocalizedString() {
    switch (this) {
      case Instruction.beforeEating:
        return "Перед іжею";
      case Instruction.whileEating:
        return "Під час їжі";
      case Instruction.afterEating:
        return "Після їжі";
      case Instruction.noMatter:
        return "Не має значення";
    }
  }
}
