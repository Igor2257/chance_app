import 'dart:async';
import 'dart:convert';

import 'package:chance_app/main.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Repository {
  List<TaskModel> get myTasks =>
      tasksBox?.values.cast<TaskModel>().toList() ?? List.empty();

  MeUser? get user =>
      userBox!.get('user') != null ? userBox!.get('user') as MeUser : null;

  Future<String?> sendLoginData(String email, String password) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
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
                await FirebaseMessaging.instance.getToken().then((token) {
                  patchUserData(token: token);
                });
              } else {
                error = jsonDecode(value.body)["message"]
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", "");
                Fluttertoast.showToast(
                    msg: error!, toastLength: Toast.LENGTH_LONG);
              }
            });
          } else {
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

  Future<String?> sendRegisterData(String name, String lastName, String phone,
      String email, String password) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
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
          } else {
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

  Future<String?> checkIsCodeValid(
      String code, String email, String passwordFirst) async {
    if (code.length != 4) {
      return "Код має бути із 4 символів";
    }
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
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
            .then((value)async {
          if (value.statusCode > 199 && value.statusCode < 300) {
            await sendLoginData(email, passwordFirst).then((value) {
              error=value;
            });
          } else {
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

  Future<String?> patchUserData(
      {String? name, String? lastName, String? phone, String? token}) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
      var url = Uri.parse('http://139.28.37.11:56565/stage/api/user');
      try {
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
            if (!(value.statusCode > 199 && value.statusCode < 300)) {
              error = jsonDecode(value.body)["message"]
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "");
              Fluttertoast.showToast(
                  msg: error!, toastLength: Toast.LENGTH_LONG);
            }
          });
        });
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }

  Future<String?> resendCode(String email) async {
    if (email.isEmpty) {
      return "Електрона пошта пуста";
    }
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
      var url =
          Uri.parse('http://139.28.37.11:56565/stage/api/auth/resend-code');

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
          } else {
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

  Future<String?> forgotPassword(String email) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
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
          } else {
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

  Future<String?> resetPassword(
      String email, String code, String newPassword) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
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
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
          } else {
            await sendLoginData(email, newPassword).then((value) {
              error = value;
            });
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }

  Future<List<TaskModel>> updateLocalTasks() async {
    List<TaskModel> list = [];
    await loadTasks().then((value) {
      clearTasks();
      list = value;
      for (var task in list) {
        addTask(task);
      }
    });

    return list;
  }

  Future<List<TaskModel>> loadTasks() async {
    List<TaskModel> tasks = [];
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
    } else {
      var url = Uri.parse('http://139.28.37.11:56565/stage/api/task');

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
                date: DateTime.parse(list[i]["date"]).toLocal(),
                isDone: list[i]["isDone"],
                isSended: list[i]["isSended"],
              );
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
      if (isDone != null) {
        setIsDoneInLocalTask(id, isDone);
      }
    } else {
      var url = Uri.parse('http://139.28.37.11:56565/stage/api/task/$id');

      try {
        final cookie = await getCookie();
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
            .then((value) {
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

  Future<String?> saveTask(TaskModel taskModel) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
      var url = Uri.parse('http://139.28.37.11:56565/stage/api/task');
      try {
        final cookie = await getCookie();
        String date = taskModel.date!.toUtc().toString();

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
            .then((value) {
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

  Future<MeUser?> getUser() async {
    MeUser? meUser;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
    } else {
      var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/me');
      try {
        final cookie = await getCookie();
        if (cookie != null) {
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
              print(value.body);
              String error = jsonDecode(value.body)["message"]
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "");
              Fluttertoast.showToast(
                  msg: error, toastLength: Toast.LENGTH_LONG);
            }
          });
        }
      } catch (error) {
        print(error.toString());
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return meUser;
  }

  Future<String?> removeTask(String taskId) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      //Fluttertoast.showToast(
      //    msg: "Немає підключення до інтернету",
      //    toastLength: Toast.LENGTH_LONG);
      //error = "Немає підключення до інтернету";
      removeLocalTask(taskId);
    } else {
      var url = Uri.parse('http://139.28.37.11:56565/stage/api/task/$taskId');
      try {
        final cookie = await getCookie();
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

  Future<bool> sendAllLocalData() async {
    List<TaskModel> dbTasks = await loadTasks(),
        localTasks = List.from(myTasks);
    for (int i = 0; i < localTasks.length; i++) {
      if (dbTasks.any((element) => element.id == localTasks[i].id)) {
        if (localTasks[i].isRemoved) {
          await removeTask(localTasks[i].id);
          continue;
        }
        if (localTasks[i].isDone !=
            dbTasks
                .firstWhere((element) => element.id == localTasks[i].id)
                .isDone) {
          updateTask(id: localTasks[i].id);
        }
      } else {
        if (localTasks[i].isRemoved) {
          continue;
        }
        saveTask(localTasks[i]);
      }
    }
    await updateLocalTasks();

    return true;
  }

  Future<bool> getIdTokenFromAuthCode() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(signInOption: SignInOption.standard).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      //print("value.credential?.accessToken ${value.credential?.accessToken}");
    });

    return true;
  }

  Future<String?> logout()async{
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";

    } else {
      var url = Uri.parse('http://139.28.37.11:56565/stage/api/auth/logout');
      try {
        final cookie = await getCookie();
        await http.post(url, headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': cookie.toString(),
        }).then((value) {
          if (value.statusCode > 199 && value.statusCode < 300) {
            deleteCookie();
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }

  Future clearTasks() async {
    await tasksBox!.clear();
  }

  Future addTask(TaskModel taskModel) async {
    await tasksBox!.put(taskModel.id, taskModel);
  }

  Future setIsDoneInLocalTask(String id, bool isDone) async {
    TaskModel taskModel = myTasks.firstWhere((element) => element.id == id);
    taskModel = taskModel.copyWith(isDone: isDone);
    await tasksBox!.put(taskModel.id, taskModel);
  }

  Future removeLocalTask(String id) async {
    TaskModel taskModel = myTasks.firstWhere((element) => element.id == id);
    taskModel = taskModel.copyWith(isRemoved: true);
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

  Future<void> deleteCookie() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "set-cookie");
  }
}
