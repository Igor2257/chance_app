import 'dart:convert';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SosRepository {
  get convert => null;

  Future<List<SosGroupModel>?> loadContacts() async {
    List<SosGroupModel> contacts = [];
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "Немає підключення до інтернету",
        toastLength: Toast.LENGTH_LONG,
      );
      return null;
    }

    final cookie = await UserRepository().getCookie();
    var url = Uri.parse('$apiUrl/sos');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': cookie.toString(),
        },
      );

      if (response.statusCode > 199 && response.statusCode < 300) {
        String bodyString = response.body;
        Map<String, dynamic> data = json.decode(bodyString);
        List<dynamic> contactList = data['contacts'];

        if (contactList.isNotEmpty) {
          for (int i = 0; i < contactList.length; i++) {
            Map<String, dynamic> groupData = contactList[i];
            String groupId = groupData["_id"];
            String contactName = groupData["contacts"][0]["name"];
            String contactPhone = groupData["contacts"][0]["phone"];
            String contactId = groupData["contacts"][0]["_id"];

            contacts.add(SosGroupModel(id: groupId, name: "", contacts: [
              SosContactModel(
                  name: contactName, phone: contactPhone, id: contactId)
            ]));
          }
        } else {
          Fluttertoast.showToast(
            msg: "Не вдалося отримати список контактів",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      } else {
        String error = jsonDecode(response.body)["message"]
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "");
        Fluttertoast.showToast(msg: error, toastLength: Toast.LENGTH_LONG);
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
    return contacts;
  }

  Future<String?> updateContact({
    String? name,
    String? phone,
    String? groupName,
    required String id,
  }) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
    } else {
      try {
        var url = Uri.parse('$apiUrl/sos/$id');
        final cookie = await UserRepository().getCookie();
        await http
            .patch(url,
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Cookie': cookie.toString(),
                },
                body: jsonEncode({
                  if (name != null) "name": name,
                  if (phone != null) "phone": phone,
                  if (groupName != null) "groupName": groupName,
                }))
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
          } else {}
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }

  Future<SosGroupModel?> saveContact(SosGroupModel contactModel) async {
    String? error;
    SosGroupModel? groupModel;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      // await HiveCRUM().addContact(contactModel);
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
    }
    String? group;
    try {
      var url = Uri.parse('$apiUrl/sos');
      final cookie = await UserRepository().getCookie();

      List<Map<String, String>> contactsData = contactModel.contacts
          .map((e) => {"name": e.name, "phone": e.phone})
          .toList();

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': cookie.toString(),
        },
        body: jsonEncode({
          "group": group,
          "contacts": contactsData,
        }),
      );

      if (response.statusCode > 199 && response.statusCode < 300) {
        String bodyString = response.body;
        Map<String, dynamic> data = json.decode(bodyString);
        List<dynamic> contactList = data['contacts'];

        if (contactList.isNotEmpty) {
          for (int i = 0; i < contactList.length; i++) {
            Map<String, dynamic> groupData = contactList[i];
            // String groupId = groupData["_id"];
            String contactName = groupData["name"];
            String contactPhone = groupData["phone"];
            String contactId = groupData["_id"];
            groupModel = SosGroupModel(name: "", contacts: [
              SosContactModel(
                  name: contactName, phone: contactPhone, id: contactId)
            ]);
          }
        }
        // await HiveCRUM().addContact(contactModel);
      } else {
        error = jsonDecode(response.body)["message"]
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "");
      }
    } catch (e) {
      error = e.toString();
    }

    if (error != null) {
      Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
    }

    return groupModel;
  }

  Future<String?> removeContact(String contactId) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
      error = "Немає підключення до інтернету";
      HiveCRUM().removeLocalContact(contactId);
    } else {
      try {
        var url = Uri.parse('$apiUrl/sos/$contactId');
        final cookie = await UserRepository().getCookie();
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
          } else {}
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }
}
