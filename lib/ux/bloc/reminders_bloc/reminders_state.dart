part of 'reminders_bloc.dart';

@freezed
class RemindersState with _$RemindersState {
  const factory RemindersState({
    required DateTime selectedDay,
    @Default(false) bool isLoading,
  }) = _State;
}
