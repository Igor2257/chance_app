import 'dart:async';
import 'dart:convert';

import 'package:chance_app/main.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Repository {
  final db = "139.28.37.11";
  List<TaskModel> myTasks =
      tasksBox?.values.cast<TaskModel>().toList() ?? List.empty();
  MeUser? user =
      userBox!.get('user') != null ? userBox!.get('user') as MeUser : null;

  Future<bool> sendLoginData(String email, String password) async {
    bool isOkay = false;
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/login');
    var salt = 'UVocjgjgXg8P7zIsC93kKlRU8sPbTBhsAMFLnLUPDRYFIWAk';
    var saltedPassword = salt + password;
    var bytes = utf8.encode(saltedPassword);
    var hash = sha256.convert(bytes);
    try {
      await http
          .post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {"password": hash.toString().substring(0, 13), "email": email}),
      )
          .then((value) async {
        if (value.statusCode > 199 && value.statusCode < 300) {
          var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/me');
          await http.get(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
          ).then((value) {
            if (value.statusCode > 199 && value.statusCode < 300) {
              isOkay = true;
            } else {
              Fluttertoast.showToast(msg: value.body);
            }
          });
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return isOkay;
  }

  Future<bool> sendRegisterData(String name, String lastName, String phone,
      String email, String password) async {
    bool isOkay = false;
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/register');
    var salt = 'UVocjgjgXg8P7zIsC93kKlRU8sPbTBhsAMFLnLUPDRYFIWAk';
    var saltedPassword = salt + password;
    var bytes = utf8.encode(saltedPassword);
    var hash = sha256.convert(bytes);

    try {
      await http
          .post(url,
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                "password": hash.toString().substring(0, 13),
                "email": email,
                "name": name,
                "lastName": lastName,
                "phone": phone,
                "deviceId": await FirebaseMessaging.instance.getToken(),
              }))
          .then((value) {
        if (value.statusCode > 199 && value.statusCode < 300) {
          isOkay = true;
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return isOkay;
  }

  Future<bool> checkIsCodeValid(String code, String email) async {
    if (code.isEmpty) {
      return false;
    }
    if (code.length == 4) {
      bool isOkay = false;
      var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/confirm');

      try {
        await http
            .post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"code": code, "email": email}),
        )
            .then((value) {
          if (value.statusCode > 199 && value.statusCode < 300) {
            isOkay = true;
          } else {
            Fluttertoast.showToast(msg: value.body);
          }
        });
      } catch (error) {
        Fluttertoast.showToast(msg: error.toString());
      }
      return isOkay;
    } else {
      return false;
    }
  }

  Future<bool> resendCode(String email) async {
    if (email.isEmpty) {
      return false;
    }
    bool isOkay = false;
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/resend-code');

    try {
      await http
          .post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email}),
      )
          .then((value) {
        if (value.statusCode > 199 && value.statusCode < 300) {
          isOkay = true;
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return isOkay;
  }

  Future<bool> forgotPassword(String email) async {
    bool isOkay = false;
    var url =
        Uri.parse('http://139.28.37.11:56565/stage/api/auth/forget-password');

    try {
      await http
          .post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email}),
      )
          .then((value) {
        print(value.body);
        if (value.statusCode > 199 && value.statusCode < 300) {
          isOkay = true;
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return isOkay;
  }

  Future<bool> resetPassword(
      String email, String code, String newPassword) async {
    bool isOkay = false;
    var salt = 'UVocjgjgXg8P7zIsC93kKlRU8sPbTBhsAMFLnLUPDRYFIWAk';
    var saltedPassword = salt + newPassword;
    var bytes = utf8.encode(saltedPassword);
    var hash = sha256.convert(bytes);
    var url =
        Uri.parse('http://139.28.37.11:56565/stage/api/auth/reset-password');

    try {
      await http
          .post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "password": hash.toString().substring(0, 13),
          "email": email,
          "code": code
        }),
      )
          .then((value) {
        print("value.body ${value.body}");
        if (value.statusCode > 199 && value.statusCode < 300) {
          isOkay = true;
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return isOkay;
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

  Future addUser(MeUser meUser) async {
    await userBox!.put("user", meUser);
  }

  Future updateUser(MeUser meUser) async {
    userBox!.put('user', meUser);
  }
}
