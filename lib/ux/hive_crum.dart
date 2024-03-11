import 'dart:async';

import 'package:chance_app/main.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/model/product_model.dart';
import 'package:chance_app/ux/model/settings.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:hive/hive.dart';

class HiveCRUM {
  List<TaskModel> get myTasks =>
      tasksBox?.values.cast<TaskModel>().toList() ?? List.empty();

  List<PickResult> get savedAddresses =>
      savedAddressesBox?.values.cast<PickResult>().toList() ?? List.empty();

  List<MedicineModel> get myMedicines =>
      medicineBox?.values.cast<MedicineModel>().toList() ?? List.empty();

  List<ProductModel> get myItems =>
      itemsBox?.values.cast<ProductModel>().toList() ?? List.empty();

  List<SosContactModel> get myContacts =>
      groupBox?.values.cast<SosContactModel>().toList() ?? List.empty();

  MeUser? get user =>
      userBox!.get('user') != null ? userBox!.get('user') as MeUser : null;
  Settings setting = settingsBox != null
      ? settingsBox!.get('settings') != null
          ? settingsBox!.get('settings') as Settings
          : const Settings()
      : const Settings();
  Future addMedicine(MedicineModel medicineModel) async {
    await medicineBox!.put(medicineModel.id, medicineModel);
  }

  Box<SosContactModel>? get groupBox =>
      Hive.box<SosContactModel>('sosContactsModel');

  Future addContact(SosGroupModel contactModel) async {
    await groupBox?.put(contactModel.id, contactModel as SosContactModel);
  }

  Future removeLocalContact(String id) async {
    await groupBox?.delete(id);
  }

  Future updateLocalMedicine(MedicineModel medicineModel) async {
    await medicineBox!.put(medicineModel.id, medicineModel);
  }

  Future removeLocalMedicine(String id) async {
    await medicineBox!.delete(id);
  }

  Future updateSettings(Settings settings) async {
    await settingsBox!.put("settings", settings);
  }

  Future removeSettings(String id) async {
    await settingsBox!.delete(id);
  }

  Future clearTasks() async {
    await tasksBox!.clear();
  }

  Future clearMedicines() async {
    await medicineBox!.clear();
  }

  Future addTask(TaskModel taskModel) async {
    await tasksBox!.put(taskModel.id, taskModel);
  }

  Future setIsDoneInLocalTask(String id, bool isDone) async {
    TaskModel taskModel = myTasks.firstWhere((element) => element.id == id);
    taskModel = taskModel.copyWith(isDone: isDone, isSentToDB: false);
    await tasksBox!.put(taskModel.id, taskModel);
  }

  Future setIsSentInLocalTask(bool isSentToDB,
      {String? id, TaskModel? taskModel}) async {
    if (id != null) {
      TaskModel taskModel = myTasks.firstWhere((element) => element.id == id);
      taskModel = taskModel.copyWith(isSentToDB: isSentToDB);
      await tasksBox!.put(taskModel.id, taskModel);
    }
    if (taskModel != null) {
      taskModel = taskModel.copyWith(isSentToDB: isSentToDB);
      await tasksBox!.put(taskModel.id, taskModel);
    }
  }

  Future setIsSentInLocalMedicine(bool isSentToDB,
      {String? id, MedicineModel? medicineModel}) async {
    if (id != null) {
      MedicineModel medicineModel =
          HiveCRUM().myMedicines.firstWhere((element) => element.id == id);
      medicineModel = medicineModel.copyWith(isSentToDB: isSentToDB);
      await medicineBox!.put(medicineModel.id, medicineModel);
    }
    if (medicineModel != null) {
      medicineModel = medicineModel.copyWith(isSentToDB: isSentToDB);
      await medicineBox!.put(medicineModel.id, medicineModel);
    }
  }

  Future removeLocalTask(String id) async {
    TaskModel taskModel = myTasks.firstWhere((element) => element.id == id);
    taskModel = taskModel.copyWith(isRemoved: true, isSentToDB: false);
    await tasksBox!.put(taskModel.id, taskModel);
  }

  Future addUser(MeUser meUser) async {
    await userBox!.put("user", meUser);
  }

  Future updateUser(MeUser meUser) async {
    await userBox!.put("user", meUser);
  }

  Future removeUser() async {
    await userBox!.delete("user");
  }

  Future addSavedAddresses(PickResult savedAddress) async {
    if (savedAddresses
        .any((element) => element.placeId == savedAddress.placeId)) {
      return;
    }

    await savedAddressesBox!.put(savedAddress.placeId, savedAddress);
  }

  Future updateSavedAddresses(PickResult savedAddresses) async {
    await savedAddressesBox!.put(savedAddresses.placeId, savedAddresses);
  }

  Future removeSavedAddresses(int id) async {
    await savedAddressesBox!.delete(id);
  }

  Future addItem(ProductModel productModel) async {
    await itemsBox!.put(productModel.id, productModel);
  }

  Future removeItem(String id) async {
    await itemsBox!.delete(id);
  }

  Future rewriteItems(List<ProductModel> items) async {
    await itemsBox!.clear().whenComplete(() {
      for (var item in items) {
        unawaited(itemsBox!.put(item.id, item));
      }
    });
  }
}
