enum MedicineInstruction {
  beforeEating,
  whileEating,
  afterEating,
  noMatter;

  String toLocalizedString() {
    switch (this) {
      case MedicineInstruction.beforeEating:
        return "Перед іжею";
      case MedicineInstruction.whileEating:
        return "Під час їжі";
      case MedicineInstruction.afterEating:
        return "Після їжі";
      case MedicineInstruction.noMatter:
        return "Не має значення";
    }
  }
}
