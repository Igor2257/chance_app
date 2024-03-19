import 'dart:async';

import 'package:chance_app/ui/pages/navigation/place_picker/src/models/address_component.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/bounds.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/geocoding_result.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/geometry.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/location.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ux/enum/day_periodicity.dart';
import 'package:chance_app/ux/enum/instruction.dart';
import 'package:chance_app/ux/enum/medicine_type.dart';
import 'package:chance_app/ux/enum/periodicity.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/model/product_model.dart';
import 'package:chance_app/ux/model/settings.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

late final Box<MeUser> userBox;
late final Box<TaskModel> tasksBox;
late final Box<MedicineModel> medicineBox;
late final Box<PickResult> addressesBox;
late final Box<Settings> settingsBox;
late final Box<ProductModel> itemsBox;
late final Box<SosContactModel> groupBox;

class HiveCRUD {
  HiveCRUD._();

  factory HiveCRUD() => instance;

  static final HiveCRUD instance = HiveCRUD._();
  var _initialized = false;

  bool get isInitialized => _initialized;

  List<TaskModel> get myTasks => List.unmodifiable(tasksBox.values);

  List<MedicineModel> get myMedicines => List.unmodifiable(medicineBox.values);

  List<PickResult> get savedAddresses => List.unmodifiable(addressesBox.values);

  List<ProductModel> get myItems => List.unmodifiable(itemsBox.values);

  List<SosContactModel> get myContacts => List.unmodifiable(groupBox.values);

  MeUser? get user => userBox.get('user');

  Settings get setting => settingsBox.get('settings') ?? const Settings();

  Future addContact(SosGroupModel contactModel) async {
    await groupBox.put(contactModel.id, contactModel as SosContactModel);
  }

  Future removeLocalContact(String id) async {
    await groupBox.delete(id);
  }

  Future<bool> initialize() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    Hive.init(documentsDirectory.path);
    //await Repository().deleteCookie();
    //await Hive.deleteBoxFromDisk('user');
    //await Hive.deleteBoxFromDisk('myTasks');
    //await Hive.deleteBoxFromDisk('savedAddresses');
    //await Hive.deleteBoxFromDisk('myMedicines');
    //await Hive.deleteBoxFromDisk('settings');
    //await Hive.deleteBoxFromDisk('items');
    // models
    Hive.registerAdapter(MeUserAdapter());
    Hive.registerAdapter(MedicineModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(SettingsAdapter());
    Hive.registerAdapter(SosContactModelAdapter());
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(AddressComponentAdapter());
    Hive.registerAdapter(BoundsAdapter());
    Hive.registerAdapter(GeocodingResultAdapter());
    Hive.registerAdapter(GeometryAdapter());
    Hive.registerAdapter(LocationAdapter());
    Hive.registerAdapter(PickResultAdapter());
    // enums
    Hive.registerAdapter(DayPeriodicityAdapter());
    Hive.registerAdapter(InstructionAdapter());
    Hive.registerAdapter(MedicineTypeAdapter());
    Hive.registerAdapter(PeriodicityAdapter());

    try {
      userBox = await Hive.openBox("user");
      tasksBox = await Hive.openBox("myTasks");
      medicineBox = await Hive.openBox("myMedicines");
      addressesBox = await Hive.openBox("savedAddresses");
      itemsBox = await Hive.openBox("items");
      settingsBox = await Hive.openBox("settings");
      groupBox = await Hive.openBox("sosContactsModel");
      final setting = settingsBox.get('settings') ?? const Settings();
      if (setting.firstEnter == null) {
        updateSettings(Settings(firstEnter: DateTime.now()));
      }
      _initialized = true;
    } catch (_) {
      _initialized = false;
    }

    return _initialized;
  }

  Future<void> addMedicine(MedicineModel medicineModel) async {
    await medicineBox.put(medicineModel.id, medicineModel);
  }

  Future<void> updateLocalMedicine(MedicineModel medicineModel) async {
    await medicineBox.put(medicineModel.id, medicineModel);
  }

  Future<void> removeLocalMedicine(
    MedicineModel medicineModel, {
    bool permanently = false,
  }) async {
    if (permanently) {
      await medicineBox.delete(medicineModel.id);
    } else {
      await medicineBox.put(
        medicineModel.id,
        medicineModel.copyWith(isRemoved: true, updatedAt: DateTime.now()),
      );
    }
  }

  Future<void> updateSettings(Settings settings) async {
    await settingsBox.put("settings", settings);
  }

  Future<void> removeSettings(String id) async {
    await settingsBox.delete(id);
  }

  Future<void> clearTasks() async {
    await tasksBox.clear();
  }

  Future<void> clearMedicines() async {
    await medicineBox.clear();
  }

  Future<void> addTask(TaskModel taskModel) async {
    await tasksBox.put(taskModel.id, taskModel);
  }

  Future<void> updateLocalTask(TaskModel taskModel) async {
    await tasksBox.put(taskModel.id, taskModel);
  }

  Future<void> removeLocalTask(
    TaskModel taskModel, {
    bool permanently = false,
  }) async {
    if (permanently) {
      await tasksBox.delete(taskModel.id);
    } else {
      await tasksBox.put(
        taskModel.id,
        taskModel.copyWith(isRemoved: true, updatedAt: DateTime.now()),
      );
    }
  }

  Future<void> addUser(MeUser meUser) async {
    await userBox.put("user", meUser);
  }

  Future<void> updateUser(MeUser meUser) async {
    await userBox.put("user", meUser);
  }

  Future<void> removeUser() async {
    await userBox.delete("user");
  }

  Future<void> addSavedAddresses(PickResult savedAddress) async {
    if (savedAddresses
        .any((element) => element.placeId == savedAddress.placeId)) {
      return;
    }

    await addressesBox.put(savedAddress.placeId, savedAddress);
  }

  Future<void> updateSavedAddresses(PickResult savedAddresses) async {
    await addressesBox.put(savedAddresses.placeId, savedAddresses);
  }

  Future<void> removeSavedAddresses(int id) async {
    await addressesBox.delete(id);
  }

  Future<void> addItem(ProductModel productModel) async {
    await itemsBox.put(productModel.id, productModel);
  }

  Future<void> removeItem(String id) async {
    await itemsBox.delete(id);
  }

  Future<void> rewriteItems(List<ProductModel> items) async {
    await itemsBox.clear().whenComplete(() {
      for (var item in items) {
        unawaited(itemsBox.put(item.id, item));
      }
    });
  }
}