import 'dart:convert';

import 'package:chance_app/main.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final db = "139.28.37.11";
  List<TaskModel> myTasks =
      tasksBox?.values.cast<TaskModel>().toList() ?? List.empty();

  Future<bool> sendLoginData(String email, String password) async {
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/login');

    try {
      await http
          .post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',

        },
        body: jsonEncode({
          "password": password,
          "email": email
        }),
      )
          .then((value) {
        print(value.statusCode);
        print(value.body);
      });
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }

  Future<bool> sendRegisterData(String name, String lastName, String phone,
      String email, String password) async {
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/register');


    try {
      await http
          .post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',

        },
        body: jsonEncode({
          "password": password,
          "email": email,
          "name": name,
          "lastName": lastName,
          "phone": "+38$phone"
        })
      )
          .then((value) {
        print(value.statusCode);
        print(value.body);
        print(value.headers);
        print(value.isRedirect);
        print(value.reasonPhrase);
        print(value.bodyBytes);
      });
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }

  Future addTask(TaskModel taskModel) async {
    await tasksBox!.put(taskModel.id ~/ 1000, taskModel);
  }

  Future updateTask(TaskModel taskModel) async {
    var list = tasksBox!.values.where((element) => element.id != taskModel.id);
    for (var task in list) {
      tasksBox!.put(task.id, task);
    }
    tasksBox!.put(taskModel.id ~/ 1000, taskModel);
  }

  Future removeTask(int id) async {
    await tasksBox!.delete(id ~/ 1000);
  }
}
