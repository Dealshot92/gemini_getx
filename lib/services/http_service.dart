import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../core/constants.dart';
import 'http_helper.dart';

class Network {
  static bool isTester = true;
  static String SERVER_DEV = "randomuser.me";
  static String SERVER_PROD = "randomuser.me";

  static final client = InterceptedClient.build(
    interceptors: [HttpInterceptor()],
    retryPolicy: HttpRetryPolicy(),
  );

  static String getServer() {
    if (isTester) return SERVER_DEV;
    return SERVER_PROD;
  }

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> POST(String api, Map<String, String> body) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.post(uri, body: jsonEncode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.put(uri, body: jsonEncode(params));
      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.delete(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static _throwException(Response response) {
    String reason = response.reasonPhrase!;
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(reason);
      case 401:
        throw InvalidInputException(reason);
      case 403:
        throw UnauthorisedException(reason);
      case 404:
        throw FetchDataException(reason);
      case 500:
      default:
        throw FetchDataException(reason);
    }
  }

  /* Http Apis*/
  static String API_TEXT_ONLY_INPUT = "/api";
  static String API_TEXT_AND_IMAGE = '';

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  //limit=20&page=0&order=DESC
  static Map<String, String> paramsRandomUserList(int page) {
    Map<String, String> params = {};
    params.addAll({'results': "20", 'page': page.toString()});
    return params;
  }

/* Http Parsing */

  static Map<String, String> paramsApiKey() {
    Map<String, String> params = {};
    params.addAll({
      'key': GEMINI_API_KEY,
    });
    return params;
  }

  static Map<String, String> paramsTextOnly() {
    Map<String, String> params = {};
    params.addAll({
      'key': GEMINI_API_KEY,
    });
    return params;
  }
}
