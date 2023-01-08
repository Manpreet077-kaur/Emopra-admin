import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_emporasports/untils/sharedpref/shared_prefrence.dart';
import 'package:http/http.dart' as http;
import 'sharedpref/preferences.dart';
import 'package:http_parser/src/media_type.dart';
class NetworkUtil {
  //Next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;
  final JsonDecoder _decoder = new JsonDecoder();


  Future<dynamic> get(String url, Map<String, String> headers) {
    return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //  throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postApi(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
        //"lang": SessionManager.getString(Preferences.IS_LANGUAGE),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 || statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }


  Future<dynamic> postSignUpApi(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
         // "lang": SessionManager.getString(Preferences.IS_LANGUAGE),
          "os_version": "flutter",
          "device_token": "232dffdf",
          "app_version": "1.0",
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 || statusCode == 201 ||
          statusCode == 400 ||  statusCode == 404 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postApiWithHeaderLanuage(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
       headers: {
       // "lang": SessionManager.getString(Preferences.IS_LANGUAGE),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
  Future<dynamic> postApiWithHeader(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
          "Authorization": "b "+SessionManager.getString(Preferences.ACCESS_TOKEN),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postWithHeader(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
          "Authorization": "b "+ SessionManager.getString(Preferences.ACCESS_TOKEN),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

/*
  Future<dynamic> multipartApi(String url,
      String phoneNumber,
      String email_id,
      String password,
      String first_name,
      String birthday,
      String gender,
      File profile,
      String lat,
      String lng,
      String device_type,
      String device_token) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['email_id'] = email_id;
    request.fields['password'] = password;
    request.fields['first_name'] = first_name;
    request.fields['phone_number'] = phoneNumber;
    request.fields['birthday'] = birthday;
    request.fields['gender'] = gender;
    request.files
        .add(await http.MultipartFile.fromPath('profile', profile.path));
    request.fields['lat'] = lat;
    request.fields['log'] = lng;
    request.fields['device_type'] = device_type;
    request.fields['device_token'] = device_token;
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }
*/

/*
  Future<dynamic> multipartEditApi(
      String url,
      Map<String, String> headers,
      String name,
      String age,
      String address,
      String lat,
      String long,
      File profile
      ) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    request.fields['name'] = name;
    request.fields['ageGroup'] = age;
    request.fields['address'] = address;
    request.fields['lat'] = lat;
    request.fields['long'] = long;
    if (profile.path.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', profile.path));
    }
       var res = await request.send();
       var result = await http.Response.fromStream(res);
       return _decoder.convert(result.body);

  }
*/


  Future<dynamic> post(String url, String auth_token,
      {Map? headers, body, encoding}) {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {"Authorization": auth_token},
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        // throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
 /* Future<dynamic> multipartApi(String url,
      Map<String, String> headers,
      String category_name,
      File category_image) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['category_name'] = category_name;
    if (category_image.path.isNotEmpty) {
      var multipartFile = await http.MultipartFile.fromPath("category_image", category_image.path, contentType: MediaType.parse("image/jpg"),);
      request.files.add(multipartFile);
    }
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  } */
  Future<dynamic> multipartApi(String url,
      Map<String, String> headers,
      String category_name,
      List<int>? category_image) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['category_name'] = category_name;
    request.files.add(await http.MultipartFile.fromBytes('category_image', category_image!,
        contentType: new MediaType.parse("image/jpg"),
        filename: "category_image"));
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });
    return _decoder.convert(result.body);
  }
 ///Edit category
  Future<dynamic> editMultipartApi(String url,
      Map<String, String> headers,
      String category_id,
      String category_name,
      List<int> category_image,
      String status) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['category_id'] = category_id;
    request.fields['category_name'] = category_name;
    request.fields['status'] = status;
    request.files.add(await http.MultipartFile.fromBytes('category_image', category_image,
        contentType: new MediaType.parse("image/jpg"),
        filename: "category_image"));
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });
    return _decoder.convert(result.body);
  }
}
