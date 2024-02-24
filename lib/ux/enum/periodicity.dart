enum Periodicity {
  everyDay,
  inADay,
  certainDays;

  String toLocalizedString() {
    switch (this) {
      case Periodicity.everyDay:
        return "Щодня";
      case Periodicity.inADay:
        return "Кожні 2 дні";
      case Periodicity.certainDays:
        return "Певні дні тижня";
    }
  }
}
