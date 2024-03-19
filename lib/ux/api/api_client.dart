import 'dart:async';
import 'dart:convert';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/api/api_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show debugPrintStack;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  const ApiClient();

  Uri getUrl(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return Uri.parse([apiUrl, path].join())
        .replace(queryParameters: queryParameters);
  }

  Future<dynamic> get(
    String path, {
    required String cookie,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await http.get(
        getUrl(path, queryParameters: queryParameters),
        headers: _getHeaders(cookie: cookie),
      );
      return _parseResponse(response);
    } catch (error, stackTrace) {
      _onCatchError(error, stackTrace);
      rethrow;
    }
  }

  Future<dynamic> post(
    String path, {
    required String cookie,
    required Map<String, dynamic> json,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await http.post(
        getUrl(path, queryParameters: queryParameters),
        headers: _getHeaders(cookie: cookie),
        body: jsonEncode(json),
      );
      return _parseResponse(response);
    } catch (error, stackTrace) {
      _onCatchError(error, stackTrace);
      rethrow;
    }
  }

  Future<dynamic> patch(
    String path, {
    required String cookie,
    required Map<String, dynamic> json,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await http.patch(
        getUrl(path, queryParameters: queryParameters),
        headers: _getHeaders(cookie: cookie),
        body: jsonEncode(json),
      );
      return _parseResponse(response);
    } catch (error, stackTrace) {
      _onCatchError(error, stackTrace);
      rethrow;
    }
  }

  Future<dynamic> delete(
    String path, {
    required String cookie,
    Map<String, dynamic>? json,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await http.delete(
        getUrl(path, queryParameters: queryParameters),
        headers: _getHeaders(cookie: cookie),
        body: (json != null) ? jsonEncode(json) : null,
      );
      return _parseResponse(response);
    } catch (error, stackTrace) {
      _onCatchError(error, stackTrace);
      rethrow;
    }
  }

  Map<String, String> _getHeaders({required String cookie}) {
    return {
      'Content-Type': 'application/json',
      'Cookie': cookie,
    };
  }

  dynamic _parseResponse(http.Response response) {
    if (response.body.isEmpty) return null;
    final data = jsonDecode(response.body);
    if (response.statusCode ~/ 100 == 2) return data;
    throw ApiException.fromJson(data as Map<String, dynamic>);
  }

  Future<void> _onCatchError(Object error, [StackTrace? stackTrace]) async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      unawaited(
        Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG,
        ),
      );
    } else if (error is ApiException) {
      unawaited(
        Fluttertoast.showToast(
          msg: error.toString(), // Parsed error message
          toastLength: Toast.LENGTH_LONG,
        ),
      );
    } else {
      unawaited(
        Fluttertoast.showToast(
          msg: ApiException.unknown().toString(), // Default error message
          toastLength: Toast.LENGTH_LONG,
        ),
      );
      debugPrintStack(label: error.toString(), stackTrace: stackTrace);
    }
  }
}
