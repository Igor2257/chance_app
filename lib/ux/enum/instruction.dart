import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Instruction {
  beforeEating,
  whileEating,
  afterEating,
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
