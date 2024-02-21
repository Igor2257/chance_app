import 'dart:async';
import 'dart:convert';

import 'package:chance_app/main.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Repository {
  List<TaskModel> get myTasks =>
      tasksBox?.values.cast<TaskModel>().toList() ?? List.empty();

  MeUser? get user =>
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
        final cookie = _parseCookieFromLogin(value);
        if (value.statusCode > 199 && value.statusCode < 300) {
          var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/me');
          await http.get(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json',
              if (cookie != null) 'Cookie': cookie,
            },
          ).then((value) async {
            if (value.statusCode > 199 && value.statusCode < 300) {
              isOkay = true;
              await FirebaseMessaging.instance.getToken().then((token) {
                patchUserData(token: token);
              });
            } else {
              //Fluttertoast.showToast(msg: value.body);
            }
          });
        } else {
          //Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      //Fluttertoast.showToast(msg: error.toString());
    }
    return isOkay;
  }

  Future<bool> sendRegisterData(String name, String lastName, String phone,
      String email, String password) async {
    bool isOkayPost = false;
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
              }))
          .then((value) async {
        if (value.statusCode > 199 && value.statusCode < 300) {
          String? cookie = value.headers['set-cookie'];
          saveCookie(cookie);
          isOkayPost = true;
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return isOkayPost;
  }

  Future<bool> checkIsCodeValid(
      String code, String email, String passwordFirst) async {
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
            sendLoginData(email, passwordFirst);
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

  Future<bool> patchUserData(
      {String? name, String? lastName, String? phone, String? token}) async {
    bool isOkay = false;
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/user');
    await getCookie().then((cookie) async {
      await http
          .patch(url,
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Cookie': cookie.toString(),
              },
              body: jsonEncode({
                if (name != null) "name": name,
                if (lastName != null) "lastName": lastName,
                if (phone != null) "phone": phone,
                if (token != null) "deviceId": token,
              }))
          .then((value) {
        if (value.statusCode > 199 && value.statusCode < 300) {
          isOkay = true;
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    });

    return isOkay;
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

  Future<List<TaskModel>> getTasks() async {
    List<TaskModel> list = [];

    var url = Uri.parse('http://139.28.37.11:56565/stage/api/task');
    clearTasks();
    try {
      final cookie = await getCookie();
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
              userId: list[i]["userId"],
              date: DateTime.parse(list[i]["date"]),
              isDone: list[i]["isDone"],
              isSended: list[i]["isSended"],
            );
            addTask(taskModel);
          }
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return list;
  }

  Future<bool> updateTask(TaskModel taskModel) async {
    bool isOkay = false;

    var url =
        Uri.parse('http://139.28.37.11:56565/stage/api/task/${taskModel.id}');

    try {
      final cookie = await getCookie();
      await http
          .patch(url,
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Cookie': cookie.toString(),
              },
              body: jsonEncode({}))
          .then((value) {
        if (value.statusCode > 199 && value.statusCode < 300) {
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return isOkay;
  }

  Future<bool> saveTask(TaskModel taskModel) async {
    bool isOkay = false;
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/task');
    try {
      final cookie = await getCookie();
      String date = taskModel.date!.toIso8601String().toString();
      print("date1 ${taskModel.date!.toIso8601String()}");
      print("date1 ${taskModel.date!.toUtc()}");
      print("date1 ${taskModel.date!.toLocal()}");
      await http
          .post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': cookie.toString(),
        },
        body: jsonEncode({"message": taskModel.message, "date": date}),
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

  Future<MeUser?> getUser() async {
    MeUser? meUser;
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/me');
    try {
      final cookie = await getCookie();
      await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': cookie.toString(),
        },
      ).then((value) async {
        if (value.statusCode > 199 && value.statusCode < 300) {
          Map<String, dynamic> map = jsonDecode(value.body);
          meUser = MeUser(
            id: map["_id"],
            email: map["email"],
            name: map["name"],
            lastName: map["lastName"],
            phone: map["phone"],
            isGoogle: map["isGoogle"],
            isConfirmed: map["isConfirmed"],
            deviceId: map["deviceId"],
          );
          await addUser(meUser!);
          return user;
        } else {
          Fluttertoast.showToast(msg: value.body);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return meUser;
  }

  Future<bool> removeTask(String taskId) async {
    bool isOkay = false;
    var url = Uri.parse('http://139.28.37.11:56565/stage/api/task/$taskId');
    print("taskId $taskId");
    try {
      final cookie = await getCookie();
      await http.delete(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookie.toString(),
      }).then((value) {
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

  Future clearTasks() async {
    await tasksBox!.clear();
  }

  Future addTask(TaskModel taskModel) async {
    await tasksBox!.put(taskModel.id, taskModel);
  }

  Future addUser(MeUser meUser) async {
    await userBox!.put("user", meUser);
  }

  String? _parseCookieFromLogin(http.Response response) {
    final rawCookie = response.headers['set-cookie'];
    if (rawCookie == null) return null;
    final index = rawCookie.indexOf(';');
    final cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    saveCookie(cookie);
    return cookie;
  }

  void saveCookie(String? header) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: "set-cookie", value: header);
  }

  Future<String?> getCookie() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: "set-cookie");
  }
}
