import 'dart:convert';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class TasksRepository {
  final _userRepository = UserRepository();

  Future<List<TaskModel>> updateLocalTasks({bool? forcePush}) async {
    List<TaskModel> list = [];

    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      list = List.from(
          HiveCRUM().myTasks.where((element) => element.isRemoved == false));
    } else {
      if ((forcePush != null && forcePush) || !checkIsAnyTasksNotSent()) {
        await loadTasks().then((value) async {
          await HiveCRUM().clearTasks().whenComplete(() {
            list = value;

            for (var task in list) {
              HiveCRUM().addTask(task);
            }
          });
        });
      }
    }
    return list;
  }

  Future<List<TaskModel>> loadTasks() async {
    List<TaskModel> tasks = [];
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
    } else {
      try {
        var url = Uri.parse('$apiUrl/task');
        final cookie = await _userRepository.getCookie();
        await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
        ).then((value) {
          if (value.statusCode > 199 && value.statusCode < 300) {
            List<dynamic> list = jsonDecode(value.body);

            for (int i = 0; i < list.length; i++) {
              TaskModel taskModel = TaskModel(
                  id: list[i]["_id"],
                  message: list[i]["message"],
                  date: DateTime.parse(list[i]["date"]).toLocal(),
                  isDone: list[i]["isDone"],
                  isSentToDB: true);
              tasks.add(taskModel);
            }
          } else {
            String error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            Fluttertoast.showToast(msg: error, toastLength: Toast.LENGTH_LONG);
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return tasks;
  }

  Future<String?> updateTask(
      {String? name, DateTime? date, bool? isDone, required String id}) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      //Fluttertoast.showToast(
      //    msg: "Немає підключення до інтернету",
      //    toastLength: Toast.LENGTH_LONG);
      //error = "Немає підключення до інтернету";
      if (isDone != null) await HiveCRUM().setIsDoneInLocalTask(id, isDone);
    } else {
      try {
        var url = Uri.parse('$apiUrl/task/$id');
        final cookie = await _userRepository.getCookie();
        String? newDate = date?.toUtc().toString();
        await http
            .patch(url,
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Cookie': cookie.toString(),
                },
                body: jsonEncode({
                  if (name != null) "message": name,
                  if (newDate != null) "date": newDate,
                  if (isDone != null) "isDone": isDone
                }))
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
          } else {
            await HiveCRUM().setIsSentInLocalTask(id: id, true);
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }

  Future<String?> saveTask(TaskModel taskModel) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      error = "Немає підключення до інтернету";
      await HiveCRUM().addTask(taskModel);
    } else {
      try {
        var url = Uri.parse('$apiUrl/task');
        final cookie = await _userRepository.getCookie();
        String date = taskModel.date.toUtc().toString();

        await http
            .post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
          body: jsonEncode({
            "message": taskModel.message,
            "date": date,
            "isDone": taskModel.isDone,
          }),
        )
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
          } else {
            await HiveCRUM().addTask(taskModel).whenComplete(() async {
              await HiveCRUM().setIsSentInLocalTask(true, taskModel: taskModel);
            });
          }
        });
      } catch (e) {
        error = error.toString();
      }
    }
    if (error != null) {
      Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
    }
    return error;
  }

  Future<String?> removeTask(TaskModel taskModel) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      //Fluttertoast.showToast(
      //    msg: "Немає підключення до інтернету",
      //    toastLength: Toast.LENGTH_LONG);
      //error = "Немає підключення до інтернету";
      HiveCRUM().removeLocalTask(taskModel);
    } else {
      try {
        var url = Uri.parse('$apiUrl/task/${taskModel.id}');
        final cookie = await _userRepository.getCookie();
        await http.delete(url, headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': cookie.toString(),
        }).then((value) {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }

  Future<String?> deleteAllTasks() async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      //Fluttertoast.showToast(
      //    msg: "Немає підключення до інтернету",
      //    toastLength: Toast.LENGTH_LONG);
      //error = "Немає підключення до інтернету";
      for (var task in HiveCRUM().myTasks) {
        HiveCRUM().removeLocalTask(task);
      }
    } else {
      for (var task in HiveCRUM().myTasks) {
        try {
          var url = Uri.parse('$apiUrl/task/${task.id}');
          final cookie = await _userRepository.getCookie();
          await http.delete(url, headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          }).then((value) {
            if (!(value.statusCode > 199 && value.statusCode < 300)) {
              error = jsonDecode(value.body)["message"]
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "");
              Fluttertoast.showToast(
                  msg: error!, toastLength: Toast.LENGTH_LONG);
            }
          });
        } catch (error) {
          Fluttertoast.showToast(
              msg: error.toString(), toastLength: Toast.LENGTH_LONG);
        }
      }
    }
    return error;
  }

  Future<bool> sendAllLocalTasksData() async {
    List<TaskModel> dbTasks = await loadTasks(),
        localTasks = List.from(
            HiveCRUM().myTasks.where((element) => element.isSentToDB == false));
    for (int i = 0; i < localTasks.length; i++) {
      if (dbTasks.any((element) => element.id == localTasks[i].id)) {
        if (localTasks[i].isRemoved) {
          await removeTask(localTasks[i]);
          continue;
        }
        await updateTask(id: localTasks[i].id);
      } else {
        if (localTasks[i].isRemoved) {
          continue;
        }
        await saveTask(localTasks[i]);
      }
    }
    await updateLocalTasks(forcePush: true);

    return true;
  }

  bool checkIsAnyTasksNotSent() {
    List<TaskModel> myTasks = List.from(HiveCRUM().myTasks);
    return myTasks.isNotEmpty
        ? myTasks.any((element) => element.isSentToDB == false)
        : false;
  }
}
