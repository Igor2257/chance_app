import 'dart:async';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/helpers/reminders_helper.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:chance_app/ux/repository/medicine_repository.dart';
import 'package:chance_app/ux/repository/tasks_repository.dart';
import 'package:flutter/material.dart' show DateTimeRange, DateUtils;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminders_event.dart';
part 'reminders_state.dart';
part 'reminders_bloc.freezed.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc()
      : super(
          RemindersState(
            selectedDay: DateUtils.dateOnly(DateTime.now()),
          ),
        ) {
    on<LoadData>(_onLoadData);
    on<SelectDay>(_onSelectedDay);
    // Tasks
    on<SaveTask>(_onSaveTask);
    on<TaskIsDone>(_onTaskIsDone);
    on<TaskIsPostponed>(_onTaskIsPostponed);
    on<DeleteTask>(_onDeleteTask);
    // Medicines
    on<SaveMedicine>(_onSaveMedicine);
    on<MedicineIsDone>(_onMedicineIsDone);
    on<MedicineIsPostponed>(_onMedicineIsPostponed);
    on<DeleteMedicine>(_onDeleteMedicine);
  }

  final _tasksRepository = TasksRepository();
  final _medicineRepository = MedicineRepository();

  Future<void> _onLoadData(LoadData event, Emitter<RemindersState> emit) async {
    emit(state.copyWith(isLoading: true));
    final reminders = await Future.wait([
      _tasksRepository.updateLocalTasks(),
      _medicineRepository.updateLocalMedicines(),
    ]);
    emit(state.copyWith(isLoading: false));

    final permissionGranted = await RemindersHelper.requestPermissions();
    if (!permissionGranted) return;

    unawaited(
      Future.wait([
        for (final task in reminders[0] as List<TaskModel>)
          RemindersHelper.addTaskReminder(task),
        for (final medicine in reminders[1] as List<MedicineModel>)
          RemindersHelper.addMedicineReminders(
            medicine,
            dateRange: DateTimeRange(
              start: DateTime.now(),
              end: DateUtils.addDaysToDate(DateTime.now(), kScheduleDays),
            ),
          ),
      ]),
    );
  }

  void _onSelectedDay(SelectDay event, Emitter<RemindersState> emit) {
    emit(state.copyWith(selectedDay: DateUtils.dateOnly(event.dayDate)));
  }

  Future<void> _onSaveTask(SaveTask event, Emitter<RemindersState> emit) async {
    final task = event.task;
    await RemindersHelper.addTaskReminder(task);
    await tasksBox.put(task.id, task);
    await _tasksRepository.saveTask(task);
  }

  Future<void> _onTaskIsDone(
      TaskIsDone event, Emitter<RemindersState> emit) async {
    final task = event.task.copyWith(isDone: !event.task.isDone);
    if (task.isDone) {
      await RemindersHelper.cancelTaskReminder(task);
    } else {
      await RemindersHelper.addTaskReminder(task);
    }
    await tasksBox.put(task.id, task.copyWith(isSentToDB: false));
    await _tasksRepository.updateTask(id: task.id, isDone: task.isDone);
  }

  Future<void> _onTaskIsPostponed(
      TaskIsPostponed event, Emitter<RemindersState> emit) async {
    final task = event.task.reschedule(Duration(minutes: event.minutes));
    await RemindersHelper.cancelTaskReminder(task);
    await RemindersHelper.addTaskReminder(task);
    await tasksBox.put(task.id, task.copyWith(isSentToDB: false));
    // TODO: task isn't updated
    // await _repository.updateTask(task);
  }

  Future<void> _onDeleteTask(
      DeleteTask event, Emitter<RemindersState> emit) async {
    final task = event.task.copyWith(isRemoved: true);
    await RemindersHelper.cancelTaskReminder(task);
    await tasksBox.put(task.id, task.copyWith(isSentToDB: false));
    await _tasksRepository.removeTask(task);
  }

  Future<void> _onSaveMedicine(
      SaveMedicine event, Emitter<RemindersState> emit) async {
    final medicine = event.medicine;
    await RemindersHelper.addMedicineReminders(
      medicine,
      dateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateUtils.addDaysToDate(DateTime.now(), kScheduleDays),
      ),
    );
    await medicineBox.put(medicine.id, medicine.copyWith(isSentToDB: false));
    await _medicineRepository.saveMedicine(medicine);
  }

  Future<void> _onMedicineIsDone(
      MedicineIsDone event, Emitter<RemindersState> emit) async {
    final medicine = event.medicine.setDoneAt(event.at);
    await RemindersHelper.cancelMedicineReminder(medicine, dateTime: event.at);
    await medicineBox.put(medicine.id, medicine.copyWith(isSentToDB: false));
    await _medicineRepository.updateMedicine(medicine);
  }

  Future<void> _onMedicineIsPostponed(
      MedicineIsPostponed event, Emitter<RemindersState> emit) async {
    final doseTime = event.doseTime;
    final medicine = event.medicine.reschedule(
      doseTime,
      Duration(minutes: event.minutes),
    );
    await RemindersHelper.cancelMedicineReminder(medicine, dateTime: doseTime);
    await RemindersHelper.addMedicineReminder(medicine, dateTime: doseTime);
    await medicineBox.put(medicine.id, medicine.copyWith(isSentToDB: false));
    await _medicineRepository.updateMedicine(medicine);
  }

  Future<void> _onDeleteMedicine(
      DeleteMedicine event, Emitter<RemindersState> emit) async {
    final medicine = event.medicine.copyWith(isRemoved: true);
    await RemindersHelper.cancelMedicineReminders(medicine);
    await medicineBox.put(medicine.id, medicine.copyWith(isSentToDB: false));
    await _medicineRepository.removeMedicine(medicine);
  }
}
