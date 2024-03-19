import 'package:chance_app/ux/api/api_client.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:hive_flutter/hive_flutter.dart';

class MedicineRepository {
  final _apiClient = const ApiClient();
  final _userRepository = UserRepository();
  final Box<MedicineModel> _storage = medicineBox;

  List<MedicineModel> getLocalMedicines() {
    return _storage.values.where((e) => !e.isRemoved).toList();
  }

  Future<Set<String>> syncMedicines() async {
    final cookie = await _userRepository.getCookie();
    final fetchedItems = await _apiClient.fetchMedicines(
      cookie: cookie.toString(),
    );
    if (fetchedItems == null) return {}; // There is nothing to sync
    // Sync map is a Map of item IDs and pairs of local and remote items
    final result = <String>{};
    final syncMap = <String, ({MedicineModel? local, MedicineModel? remote})>{
      for (final item in fetchedItems) item.id: (local: null, remote: item),
    };
    for (final item in _storage.values) {
      syncMap[item.id] = (local: item, remote: syncMap[item.id]?.remote);
    }
    // Start to sync the items
    for (final item in syncMap.values) {
      final local = item.local;
      final remote = item.remote;
      if (local == null) {
        await _storage.putMedicine(remote!); // Save remote item
      } else if (remote == null) {
        if (!local.isRemoved) {
          final item = await _apiClient.postMedicine(
            local,
            cookie: cookie.toString(),
          );
          if (item == null) continue;
          await _storage.putMedicine(item);
        }
        await _storage.deleteMedicine(local); // Delete permanently
        result.add(local.id);
      } else if (local.isRemoved) {
        final deleted = await _apiClient.deleteMedicine(
          remote,
          cookie: cookie.toString(),
        );
        if (!deleted) continue;
        await _storage.deleteMedicine(local);
        result.add(local.id);
      } else if (local.updatedAt.isBefore(remote.updatedAt)) {
        await _storage.putMedicine(remote);
        result.add(local.id);
      } else if (local.updatedAt.isAfter(remote.updatedAt)) {
        await _apiClient.patchMedicine(local, cookie: cookie.toString());
      }
    }
    return result;
  }

  Future<MedicineModel> addMedicine(MedicineModel medicine) async {
    final cookie = await _userRepository.getCookie();
    final model = await _apiClient.postMedicine(
      medicine,
      cookie: cookie.toString(),
    );
    medicine = model ?? medicine.copyWith(updatedAt: DateTime.now());
    await _storage.putMedicine(medicine);
    return medicine;
  }

  Future<MedicineModel> updateMedicine(MedicineModel medicine) async {
    final cookie = await _userRepository.getCookie();
    final model = await _apiClient.patchMedicine(
      medicine,
      cookie: cookie.toString(),
    );
    medicine = model ?? medicine.copyWith(updatedAt: DateTime.now());
    await _storage.putMedicine(medicine);
    return medicine;
  }

  Future<bool> removeMedicine(MedicineModel medicine) async {
    final cookie = await _userRepository.getCookie();
    final deleted = await _apiClient.deleteMedicine(
      medicine,
      cookie: cookie.toString(),
    );
    if (deleted) {
      await _storage.deleteMedicine(medicine);
    } else {
      medicine = medicine.copyWith(isRemoved: true);
      await _storage.putMedicine(medicine);
    }
    return deleted;
  }

  Future<void> deleteAllMedicines() => _storage.clear();
}

extension _MedicineStorage on Box<MedicineModel> {
  Future<void> putMedicine(MedicineModel item) => put(item.id, item);
  Future<void> deleteMedicine(MedicineModel item) => delete(item.id);
}

extension _MedicineClient on ApiClient {
  Future<List<MedicineModel>?> fetchMedicines({required String cookie}) async {
    try {
      final items = await get("/medicine", cookie: cookie) as List<dynamic>;
      return items.cast<Map<String, dynamic>>().map(_modelFromJson).toList();
    } catch (_) {
      return null;
    }
  }

  Future<MedicineModel?> postMedicine(
    MedicineModel medicine, {
    required String cookie,
  }) async {
    try {
      final json = await post(
        "/medicine",
        cookie: cookie,
        json: _modelToJson(medicine),
      ) as Map<String, dynamic>;
      return _modelFromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<MedicineModel?> patchMedicine(
    MedicineModel medicine, {
    required String cookie,
  }) async {
    try {
      final json = await patch(
        "/medicine/${medicine.id}",
        cookie: cookie.toString(),
        json: _modelToJson(medicine),
      ) as Map<String, dynamic>;
      return _modelFromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<bool> deleteMedicine(
    MedicineModel medicine, {
    required String cookie,
  }) async {
    try {
      await delete(
        "/medicine/${medicine.id}",
        cookie: cookie.toString(),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Map<String, dynamic> _modelToJson(MedicineModel medicine) {
    return {
      "name": medicine.name,
      "type": medicine.type.name,
      "periodicity": medicine.periodicity.name,
      "startDate": medicine.startDate.toUtc().toIso8601String(),
      "weekdays": medicine.weekdays,
      "doses": medicine.doses.map((k, e) => MapEntry(k.toString(), e)),
      "instruction": medicine.instruction.name,
      "doneAt":
          medicine.doneAt.map((e) => e.toUtc().toIso8601String()).toList(),
      "rescheduledOn": medicine.rescheduledOn
          .map((key, value) => MapEntry(key.toUtc().toIso8601String(), value)),
    };
  }

  MedicineModel _modelFromJson(Map<String, dynamic> json) {
    return MedicineModel.fromJson(json).copyWith(
      startDate: DateUtils.dateOnly(DateTime.parse(json["startDate"])),
    );
  }
}
