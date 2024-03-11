// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminders_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RemindersEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemindersEventCopyWith<$Res> {
  factory $RemindersEventCopyWith(
          RemindersEvent value, $Res Function(RemindersEvent) then) =
      _$RemindersEventCopyWithImpl<$Res, RemindersEvent>;
}

/// @nodoc
class _$RemindersEventCopyWithImpl<$Res, $Val extends RemindersEvent>
    implements $RemindersEventCopyWith<$Res> {
  _$RemindersEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadDataImplCopyWith<$Res> {
  factory _$$LoadDataImplCopyWith(
          _$LoadDataImpl value, $Res Function(_$LoadDataImpl) then) =
      __$$LoadDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadDataImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$LoadDataImpl>
    implements _$$LoadDataImplCopyWith<$Res> {
  __$$LoadDataImplCopyWithImpl(
      _$LoadDataImpl _value, $Res Function(_$LoadDataImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadDataImpl implements LoadData {
  const _$LoadDataImpl();

  @override
  String toString() {
    return 'RemindersEvent.loadData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return loadData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return loadData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (loadData != null) {
      return loadData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return loadData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return loadData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (loadData != null) {
      return loadData(this);
    }
    return orElse();
  }
}

abstract class LoadData implements RemindersEvent {
  const factory LoadData() = _$LoadDataImpl;
}

/// @nodoc
abstract class _$$SelectDayImplCopyWith<$Res> {
  factory _$$SelectDayImplCopyWith(
          _$SelectDayImpl value, $Res Function(_$SelectDayImpl) then) =
      __$$SelectDayImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime dayDate});
}

/// @nodoc
class __$$SelectDayImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$SelectDayImpl>
    implements _$$SelectDayImplCopyWith<$Res> {
  __$$SelectDayImplCopyWithImpl(
      _$SelectDayImpl _value, $Res Function(_$SelectDayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayDate = null,
  }) {
    return _then(_$SelectDayImpl(
      null == dayDate
          ? _value.dayDate
          : dayDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$SelectDayImpl implements SelectDay {
  const _$SelectDayImpl(this.dayDate);

  @override
  final DateTime dayDate;

  @override
  String toString() {
    return 'RemindersEvent.selectDay(dayDate: $dayDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectDayImpl &&
            (identical(other.dayDate, dayDate) || other.dayDate == dayDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dayDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectDayImplCopyWith<_$SelectDayImpl> get copyWith =>
      __$$SelectDayImplCopyWithImpl<_$SelectDayImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return selectDay(dayDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return selectDay?.call(dayDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (selectDay != null) {
      return selectDay(dayDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return selectDay(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return selectDay?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (selectDay != null) {
      return selectDay(this);
    }
    return orElse();
  }
}

abstract class SelectDay implements RemindersEvent {
  const factory SelectDay(final DateTime dayDate) = _$SelectDayImpl;

  DateTime get dayDate;
  @JsonKey(ignore: true)
  _$$SelectDayImplCopyWith<_$SelectDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveTaskImplCopyWith<$Res> {
  factory _$$SaveTaskImplCopyWith(
          _$SaveTaskImpl value, $Res Function(_$SaveTaskImpl) then) =
      __$$SaveTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskModel task});

  $TaskModelCopyWith<$Res> get task;
}

/// @nodoc
class __$$SaveTaskImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$SaveTaskImpl>
    implements _$$SaveTaskImplCopyWith<$Res> {
  __$$SaveTaskImplCopyWithImpl(
      _$SaveTaskImpl _value, $Res Function(_$SaveTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$SaveTaskImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskModelCopyWith<$Res> get task {
    return $TaskModelCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$SaveTaskImpl implements SaveTask {
  const _$SaveTaskImpl(this.task);

  @override
  final TaskModel task;

  @override
  String toString() {
    return 'RemindersEvent.saveTask(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveTaskImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveTaskImplCopyWith<_$SaveTaskImpl> get copyWith =>
      __$$SaveTaskImplCopyWithImpl<_$SaveTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return saveTask(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return saveTask?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (saveTask != null) {
      return saveTask(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return saveTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return saveTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (saveTask != null) {
      return saveTask(this);
    }
    return orElse();
  }
}

abstract class SaveTask implements RemindersEvent {
  const factory SaveTask(final TaskModel task) = _$SaveTaskImpl;

  TaskModel get task;
  @JsonKey(ignore: true)
  _$$SaveTaskImplCopyWith<_$SaveTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskIsDoneImplCopyWith<$Res> {
  factory _$$TaskIsDoneImplCopyWith(
          _$TaskIsDoneImpl value, $Res Function(_$TaskIsDoneImpl) then) =
      __$$TaskIsDoneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskModel task});

  $TaskModelCopyWith<$Res> get task;
}

/// @nodoc
class __$$TaskIsDoneImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$TaskIsDoneImpl>
    implements _$$TaskIsDoneImplCopyWith<$Res> {
  __$$TaskIsDoneImplCopyWithImpl(
      _$TaskIsDoneImpl _value, $Res Function(_$TaskIsDoneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$TaskIsDoneImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskModelCopyWith<$Res> get task {
    return $TaskModelCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$TaskIsDoneImpl implements TaskIsDone {
  const _$TaskIsDoneImpl(this.task);

  @override
  final TaskModel task;

  @override
  String toString() {
    return 'RemindersEvent.taskIsDone(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskIsDoneImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskIsDoneImplCopyWith<_$TaskIsDoneImpl> get copyWith =>
      __$$TaskIsDoneImplCopyWithImpl<_$TaskIsDoneImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return taskIsDone(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return taskIsDone?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (taskIsDone != null) {
      return taskIsDone(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return taskIsDone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return taskIsDone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (taskIsDone != null) {
      return taskIsDone(this);
    }
    return orElse();
  }
}

abstract class TaskIsDone implements RemindersEvent {
  const factory TaskIsDone(final TaskModel task) = _$TaskIsDoneImpl;

  TaskModel get task;
  @JsonKey(ignore: true)
  _$$TaskIsDoneImplCopyWith<_$TaskIsDoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskIsPostponedImplCopyWith<$Res> {
  factory _$$TaskIsPostponedImplCopyWith(_$TaskIsPostponedImpl value,
          $Res Function(_$TaskIsPostponedImpl) then) =
      __$$TaskIsPostponedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskModel task, int minutes});

  $TaskModelCopyWith<$Res> get task;
}

/// @nodoc
class __$$TaskIsPostponedImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$TaskIsPostponedImpl>
    implements _$$TaskIsPostponedImplCopyWith<$Res> {
  __$$TaskIsPostponedImplCopyWithImpl(
      _$TaskIsPostponedImpl _value, $Res Function(_$TaskIsPostponedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? minutes = null,
  }) {
    return _then(_$TaskIsPostponedImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskModelCopyWith<$Res> get task {
    return $TaskModelCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$TaskIsPostponedImpl implements TaskIsPostponed {
  const _$TaskIsPostponedImpl(this.task, {required this.minutes});

  @override
  final TaskModel task;
  @override
  final int minutes;

  @override
  String toString() {
    return 'RemindersEvent.taskIsPostponed(task: $task, minutes: $minutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskIsPostponedImpl &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.minutes, minutes) || other.minutes == minutes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task, minutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskIsPostponedImplCopyWith<_$TaskIsPostponedImpl> get copyWith =>
      __$$TaskIsPostponedImplCopyWithImpl<_$TaskIsPostponedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return taskIsPostponed(task, minutes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return taskIsPostponed?.call(task, minutes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (taskIsPostponed != null) {
      return taskIsPostponed(task, minutes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return taskIsPostponed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return taskIsPostponed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (taskIsPostponed != null) {
      return taskIsPostponed(this);
    }
    return orElse();
  }
}

abstract class TaskIsPostponed implements RemindersEvent {
  const factory TaskIsPostponed(final TaskModel task,
      {required final int minutes}) = _$TaskIsPostponedImpl;

  TaskModel get task;
  int get minutes;
  @JsonKey(ignore: true)
  _$$TaskIsPostponedImplCopyWith<_$TaskIsPostponedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTaskImplCopyWith<$Res> {
  factory _$$DeleteTaskImplCopyWith(
          _$DeleteTaskImpl value, $Res Function(_$DeleteTaskImpl) then) =
      __$$DeleteTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskModel task});

  $TaskModelCopyWith<$Res> get task;
}

/// @nodoc
class __$$DeleteTaskImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$DeleteTaskImpl>
    implements _$$DeleteTaskImplCopyWith<$Res> {
  __$$DeleteTaskImplCopyWithImpl(
      _$DeleteTaskImpl _value, $Res Function(_$DeleteTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$DeleteTaskImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskModelCopyWith<$Res> get task {
    return $TaskModelCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$DeleteTaskImpl implements DeleteTask {
  const _$DeleteTaskImpl(this.task);

  @override
  final TaskModel task;

  @override
  String toString() {
    return 'RemindersEvent.deleteTask(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTaskImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTaskImplCopyWith<_$DeleteTaskImpl> get copyWith =>
      __$$DeleteTaskImplCopyWithImpl<_$DeleteTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return deleteTask(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return deleteTask?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (deleteTask != null) {
      return deleteTask(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return deleteTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return deleteTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (deleteTask != null) {
      return deleteTask(this);
    }
    return orElse();
  }
}

abstract class DeleteTask implements RemindersEvent {
  const factory DeleteTask(final TaskModel task) = _$DeleteTaskImpl;

  TaskModel get task;
  @JsonKey(ignore: true)
  _$$DeleteTaskImplCopyWith<_$DeleteTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveMedicineImplCopyWith<$Res> {
  factory _$$SaveMedicineImplCopyWith(
          _$SaveMedicineImpl value, $Res Function(_$SaveMedicineImpl) then) =
      __$$SaveMedicineImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MedicineModel medicine});

  $MedicineModelCopyWith<$Res> get medicine;
}

/// @nodoc
class __$$SaveMedicineImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$SaveMedicineImpl>
    implements _$$SaveMedicineImplCopyWith<$Res> {
  __$$SaveMedicineImplCopyWithImpl(
      _$SaveMedicineImpl _value, $Res Function(_$SaveMedicineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medicine = null,
  }) {
    return _then(_$SaveMedicineImpl(
      null == medicine
          ? _value.medicine
          : medicine // ignore: cast_nullable_to_non_nullable
              as MedicineModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MedicineModelCopyWith<$Res> get medicine {
    return $MedicineModelCopyWith<$Res>(_value.medicine, (value) {
      return _then(_value.copyWith(medicine: value));
    });
  }
}

/// @nodoc

class _$SaveMedicineImpl implements SaveMedicine {
  const _$SaveMedicineImpl(this.medicine);

  @override
  final MedicineModel medicine;

  @override
  String toString() {
    return 'RemindersEvent.saveMedicine(medicine: $medicine)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveMedicineImpl &&
            (identical(other.medicine, medicine) ||
                other.medicine == medicine));
  }

  @override
  int get hashCode => Object.hash(runtimeType, medicine);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveMedicineImplCopyWith<_$SaveMedicineImpl> get copyWith =>
      __$$SaveMedicineImplCopyWithImpl<_$SaveMedicineImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return saveMedicine(medicine);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return saveMedicine?.call(medicine);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (saveMedicine != null) {
      return saveMedicine(medicine);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return saveMedicine(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return saveMedicine?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (saveMedicine != null) {
      return saveMedicine(this);
    }
    return orElse();
  }
}

abstract class SaveMedicine implements RemindersEvent {
  const factory SaveMedicine(final MedicineModel medicine) = _$SaveMedicineImpl;

  MedicineModel get medicine;
  @JsonKey(ignore: true)
  _$$SaveMedicineImplCopyWith<_$SaveMedicineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MedicineIsDoneImplCopyWith<$Res> {
  factory _$$MedicineIsDoneImplCopyWith(_$MedicineIsDoneImpl value,
          $Res Function(_$MedicineIsDoneImpl) then) =
      __$$MedicineIsDoneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MedicineModel medicine, DateTime at});

  $MedicineModelCopyWith<$Res> get medicine;
}

/// @nodoc
class __$$MedicineIsDoneImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$MedicineIsDoneImpl>
    implements _$$MedicineIsDoneImplCopyWith<$Res> {
  __$$MedicineIsDoneImplCopyWithImpl(
      _$MedicineIsDoneImpl _value, $Res Function(_$MedicineIsDoneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medicine = null,
    Object? at = null,
  }) {
    return _then(_$MedicineIsDoneImpl(
      null == medicine
          ? _value.medicine
          : medicine // ignore: cast_nullable_to_non_nullable
              as MedicineModel,
      at: null == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MedicineModelCopyWith<$Res> get medicine {
    return $MedicineModelCopyWith<$Res>(_value.medicine, (value) {
      return _then(_value.copyWith(medicine: value));
    });
  }
}

/// @nodoc

class _$MedicineIsDoneImpl implements MedicineIsDone {
  const _$MedicineIsDoneImpl(this.medicine, {required this.at});

  @override
  final MedicineModel medicine;
  @override
  final DateTime at;

  @override
  String toString() {
    return 'RemindersEvent.medicineIsDone(medicine: $medicine, at: $at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicineIsDoneImpl &&
            (identical(other.medicine, medicine) ||
                other.medicine == medicine) &&
            (identical(other.at, at) || other.at == at));
  }

  @override
  int get hashCode => Object.hash(runtimeType, medicine, at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicineIsDoneImplCopyWith<_$MedicineIsDoneImpl> get copyWith =>
      __$$MedicineIsDoneImplCopyWithImpl<_$MedicineIsDoneImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return medicineIsDone(medicine, at);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return medicineIsDone?.call(medicine, at);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (medicineIsDone != null) {
      return medicineIsDone(medicine, at);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return medicineIsDone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return medicineIsDone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (medicineIsDone != null) {
      return medicineIsDone(this);
    }
    return orElse();
  }
}

abstract class MedicineIsDone implements RemindersEvent {
  const factory MedicineIsDone(final MedicineModel medicine,
      {required final DateTime at}) = _$MedicineIsDoneImpl;

  MedicineModel get medicine;
  DateTime get at;
  @JsonKey(ignore: true)
  _$$MedicineIsDoneImplCopyWith<_$MedicineIsDoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MedicineIsPostponedImplCopyWith<$Res> {
  factory _$$MedicineIsPostponedImplCopyWith(_$MedicineIsPostponedImpl value,
          $Res Function(_$MedicineIsPostponedImpl) then) =
      __$$MedicineIsPostponedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MedicineModel medicine, DateTime doseTime, int minutes});

  $MedicineModelCopyWith<$Res> get medicine;
}

/// @nodoc
class __$$MedicineIsPostponedImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$MedicineIsPostponedImpl>
    implements _$$MedicineIsPostponedImplCopyWith<$Res> {
  __$$MedicineIsPostponedImplCopyWithImpl(_$MedicineIsPostponedImpl _value,
      $Res Function(_$MedicineIsPostponedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medicine = null,
    Object? doseTime = null,
    Object? minutes = null,
  }) {
    return _then(_$MedicineIsPostponedImpl(
      null == medicine
          ? _value.medicine
          : medicine // ignore: cast_nullable_to_non_nullable
              as MedicineModel,
      doseTime: null == doseTime
          ? _value.doseTime
          : doseTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MedicineModelCopyWith<$Res> get medicine {
    return $MedicineModelCopyWith<$Res>(_value.medicine, (value) {
      return _then(_value.copyWith(medicine: value));
    });
  }
}

/// @nodoc

class _$MedicineIsPostponedImpl implements MedicineIsPostponed {
  const _$MedicineIsPostponedImpl(this.medicine,
      {required this.doseTime, required this.minutes});

  @override
  final MedicineModel medicine;
  @override
  final DateTime doseTime;
  @override
  final int minutes;

  @override
  String toString() {
    return 'RemindersEvent.medicineIsPostponed(medicine: $medicine, doseTime: $doseTime, minutes: $minutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicineIsPostponedImpl &&
            (identical(other.medicine, medicine) ||
                other.medicine == medicine) &&
            (identical(other.doseTime, doseTime) ||
                other.doseTime == doseTime) &&
            (identical(other.minutes, minutes) || other.minutes == minutes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, medicine, doseTime, minutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicineIsPostponedImplCopyWith<_$MedicineIsPostponedImpl> get copyWith =>
      __$$MedicineIsPostponedImplCopyWithImpl<_$MedicineIsPostponedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return medicineIsPostponed(medicine, doseTime, minutes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return medicineIsPostponed?.call(medicine, doseTime, minutes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (medicineIsPostponed != null) {
      return medicineIsPostponed(medicine, doseTime, minutes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return medicineIsPostponed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return medicineIsPostponed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (medicineIsPostponed != null) {
      return medicineIsPostponed(this);
    }
    return orElse();
  }
}

abstract class MedicineIsPostponed implements RemindersEvent {
  const factory MedicineIsPostponed(final MedicineModel medicine,
      {required final DateTime doseTime,
      required final int minutes}) = _$MedicineIsPostponedImpl;

  MedicineModel get medicine;
  DateTime get doseTime;
  int get minutes;
  @JsonKey(ignore: true)
  _$$MedicineIsPostponedImplCopyWith<_$MedicineIsPostponedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteMedicineImplCopyWith<$Res> {
  factory _$$DeleteMedicineImplCopyWith(_$DeleteMedicineImpl value,
          $Res Function(_$DeleteMedicineImpl) then) =
      __$$DeleteMedicineImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MedicineModel medicine});

  $MedicineModelCopyWith<$Res> get medicine;
}

/// @nodoc
class __$$DeleteMedicineImplCopyWithImpl<$Res>
    extends _$RemindersEventCopyWithImpl<$Res, _$DeleteMedicineImpl>
    implements _$$DeleteMedicineImplCopyWith<$Res> {
  __$$DeleteMedicineImplCopyWithImpl(
      _$DeleteMedicineImpl _value, $Res Function(_$DeleteMedicineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medicine = null,
  }) {
    return _then(_$DeleteMedicineImpl(
      null == medicine
          ? _value.medicine
          : medicine // ignore: cast_nullable_to_non_nullable
              as MedicineModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MedicineModelCopyWith<$Res> get medicine {
    return $MedicineModelCopyWith<$Res>(_value.medicine, (value) {
      return _then(_value.copyWith(medicine: value));
    });
  }
}

/// @nodoc

class _$DeleteMedicineImpl implements DeleteMedicine {
  const _$DeleteMedicineImpl(this.medicine);

  @override
  final MedicineModel medicine;

  @override
  String toString() {
    return 'RemindersEvent.deleteMedicine(medicine: $medicine)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteMedicineImpl &&
            (identical(other.medicine, medicine) ||
                other.medicine == medicine));
  }

  @override
  int get hashCode => Object.hash(runtimeType, medicine);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteMedicineImplCopyWith<_$DeleteMedicineImpl> get copyWith =>
      __$$DeleteMedicineImplCopyWithImpl<_$DeleteMedicineImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(DateTime dayDate) selectDay,
    required TResult Function(TaskModel task) saveTask,
    required TResult Function(TaskModel task) taskIsDone,
    required TResult Function(TaskModel task, int minutes) taskIsPostponed,
    required TResult Function(TaskModel task) deleteTask,
    required TResult Function(MedicineModel medicine) saveMedicine,
    required TResult Function(MedicineModel medicine, DateTime at)
        medicineIsDone,
    required TResult Function(
            MedicineModel medicine, DateTime doseTime, int minutes)
        medicineIsPostponed,
    required TResult Function(MedicineModel medicine) deleteMedicine,
  }) {
    return deleteMedicine(medicine);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(DateTime dayDate)? selectDay,
    TResult? Function(TaskModel task)? saveTask,
    TResult? Function(TaskModel task)? taskIsDone,
    TResult? Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult? Function(TaskModel task)? deleteTask,
    TResult? Function(MedicineModel medicine)? saveMedicine,
    TResult? Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult? Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult? Function(MedicineModel medicine)? deleteMedicine,
  }) {
    return deleteMedicine?.call(medicine);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(DateTime dayDate)? selectDay,
    TResult Function(TaskModel task)? saveTask,
    TResult Function(TaskModel task)? taskIsDone,
    TResult Function(TaskModel task, int minutes)? taskIsPostponed,
    TResult Function(TaskModel task)? deleteTask,
    TResult Function(MedicineModel medicine)? saveMedicine,
    TResult Function(MedicineModel medicine, DateTime at)? medicineIsDone,
    TResult Function(MedicineModel medicine, DateTime doseTime, int minutes)?
        medicineIsPostponed,
    TResult Function(MedicineModel medicine)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (deleteMedicine != null) {
      return deleteMedicine(medicine);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(SelectDay value) selectDay,
    required TResult Function(SaveTask value) saveTask,
    required TResult Function(TaskIsDone value) taskIsDone,
    required TResult Function(TaskIsPostponed value) taskIsPostponed,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(SaveMedicine value) saveMedicine,
    required TResult Function(MedicineIsDone value) medicineIsDone,
    required TResult Function(MedicineIsPostponed value) medicineIsPostponed,
    required TResult Function(DeleteMedicine value) deleteMedicine,
  }) {
    return deleteMedicine(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(SelectDay value)? selectDay,
    TResult? Function(SaveTask value)? saveTask,
    TResult? Function(TaskIsDone value)? taskIsDone,
    TResult? Function(TaskIsPostponed value)? taskIsPostponed,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(SaveMedicine value)? saveMedicine,
    TResult? Function(MedicineIsDone value)? medicineIsDone,
    TResult? Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult? Function(DeleteMedicine value)? deleteMedicine,
  }) {
    return deleteMedicine?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(SelectDay value)? selectDay,
    TResult Function(SaveTask value)? saveTask,
    TResult Function(TaskIsDone value)? taskIsDone,
    TResult Function(TaskIsPostponed value)? taskIsPostponed,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(SaveMedicine value)? saveMedicine,
    TResult Function(MedicineIsDone value)? medicineIsDone,
    TResult Function(MedicineIsPostponed value)? medicineIsPostponed,
    TResult Function(DeleteMedicine value)? deleteMedicine,
    required TResult orElse(),
  }) {
    if (deleteMedicine != null) {
      return deleteMedicine(this);
    }
    return orElse();
  }
}

abstract class DeleteMedicine implements RemindersEvent {
  const factory DeleteMedicine(final MedicineModel medicine) =
      _$DeleteMedicineImpl;

  MedicineModel get medicine;
  @JsonKey(ignore: true)
  _$$DeleteMedicineImplCopyWith<_$DeleteMedicineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RemindersState {
  DateTime get selectedDay => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RemindersStateCopyWith<RemindersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemindersStateCopyWith<$Res> {
  factory $RemindersStateCopyWith(
          RemindersState value, $Res Function(RemindersState) then) =
      _$RemindersStateCopyWithImpl<$Res, RemindersState>;
  @useResult
  $Res call({DateTime selectedDay, bool isLoading});
}

/// @nodoc
class _$RemindersStateCopyWithImpl<$Res, $Val extends RemindersState>
    implements $RemindersStateCopyWith<$Res> {
  _$RemindersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDay = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      selectedDay: null == selectedDay
          ? _value.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StateImplCopyWith<$Res>
    implements $RemindersStateCopyWith<$Res> {
  factory _$$StateImplCopyWith(
          _$StateImpl value, $Res Function(_$StateImpl) then) =
      __$$StateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDay, bool isLoading});
}

/// @nodoc
class __$$StateImplCopyWithImpl<$Res>
    extends _$RemindersStateCopyWithImpl<$Res, _$StateImpl>
    implements _$$StateImplCopyWith<$Res> {
  __$$StateImplCopyWithImpl(
      _$StateImpl _value, $Res Function(_$StateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDay = null,
    Object? isLoading = null,
  }) {
    return _then(_$StateImpl(
      selectedDay: null == selectedDay
          ? _value.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StateImpl implements _State {
  const _$StateImpl({required this.selectedDay, this.isLoading = false});

  @override
  final DateTime selectedDay;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'RemindersState(selectedDay: $selectedDay, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateImpl &&
            (identical(other.selectedDay, selectedDay) ||
                other.selectedDay == selectedDay) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDay, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StateImplCopyWith<_$StateImpl> get copyWith =>
      __$$StateImplCopyWithImpl<_$StateImpl>(this, _$identity);
}

abstract class _State implements RemindersState {
  const factory _State(
      {required final DateTime selectedDay,
      final bool isLoading}) = _$StateImpl;

  @override
  DateTime get selectedDay;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$StateImplCopyWith<_$StateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
