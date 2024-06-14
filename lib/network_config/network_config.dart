import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../utilis/app_preferences.dart';



class ApiResponse {
  String? responseString;
  String? errorMsg;
  bool? done;

  ApiResponse({this.done, this.errorMsg, this.responseString});
}



class NetworkConfig{
  static Future<ApiResponse> getApiCall(String url) async {
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your connection",
          responseString: null);
    }
  }

  static ApiResponse _checkResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponse(
            done: true, errorMsg: null, responseString: response.body);
      case 400:
        return ApiResponse(
            done: true, errorMsg: "Bad Request", responseString: response.body);
      case 401:
        return ApiResponse(
            done: false, errorMsg: "Bad Request", responseString: null);
      case 403:
        return ApiResponse(
            done: false, errorMsg: "Unauthorized Request", responseString: null);
      case 404:
        return ApiResponse(
            done: true, errorMsg: "Page not Found", responseString: response.body);
      case 500:
        return ApiResponse(
            done: false, errorMsg: "Server Error", responseString: null);
      default:
        return ApiResponse(
            done: false,
            errorMsg: "Error occurred while Communication with or timeout",
            responseString: null);
    }
  }

  static Future<ApiResponse> checkStreamResponse(http.StreamedResponse response) async{
    switch (response.statusCode) {
      case 200:
        return ApiResponse(
            done: true, errorMsg: null, responseString: await response.stream.bytesToString());
      case 400:
        return ApiResponse(
            done: true, errorMsg: "Bad Request", responseString: await response.stream.bytesToString());
      case 401:
        return ApiResponse(
            done: false, errorMsg: "Session Expired", responseString: null);
      case 403:
        return ApiResponse(
            done: false, errorMsg: "Unauthorized Request", responseString: null);
      case 404:
        return ApiResponse(
            done: true, errorMsg: "Page not Found", responseString: await response.stream.bytesToString());
      case 500:
        return ApiResponse(
            done: false, errorMsg: "Server Error", responseString: null);
      default:
        return ApiResponse(
            done: false,
            errorMsg: "Error occurred while Communication with or timeout",
            responseString: null);
    }
  }

  static Future<ApiResponse> getApiCallWithToken(String url) async {
    bearerToken=preferences.getString(AppPrefs.keyToken)?? '';
    print(bearerToken);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };

      var response = await http.get(Uri.parse(url), headers: headers);
      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your connection",
          responseString: null);
    }
  }

  static Future postApiCall(String url, Map map) async {
    print(url);
    print(map);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(map),
      );
      debugPrint(response.statusCode.toString());
      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your connection",
          responseString: null);
    }
  }

  static Future postApiWithTokenCall(String url, Map map) async {
    bearerToken=preferences.getString(AppPrefs.keyToken);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearerToken',
          // 'Origin':''
        },
        body: jsonEncode(map),
      );
      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your connection",
          responseString: null);
    }
  }


  static Future postWebCall(String url, Map map) async {
    print(url);
    print(map);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(map),
      );
      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your connection",
          responseString: null);
    }
  }
  // static Future<ApiResponse> postMultipartCallBroadCast(String url, Map<String, dynamic> map) async {
  //   try {
  //     final request = http.MultipartRequest('POST', Uri.parse(url));
  //
  //     map.forEach((key, value) {
  //       if (value is http.MultipartFile) {
  //         request.files.add(http.MultipartFile.fromBytes(
  //           key,
  //           value,
  //           filename: 'your_filename.jpg', // Replace with the desired filename
  //         ));
  //       } else {
  //         request.fields[key] = value.toString();
  //       }
  //     });
  //
  //     request.headers["Authorization"] = '78ygyugfregf874357438t54yuyfgfyueygyrgeygr4378t47';
  //
  //     final response = await request.send();
  //
  //     // Handle the response stream only once
  //     final responseString = await response.stream.bytesToString();
  //     return ApiResponse(
  //       done: true,
  //       responseString: responseString,
  //     );
  //   } on SocketException {
  //     return ApiResponse(
  //       done: false,
  //       errorMsg: "Please check your connection",
  //       responseString: null,
  //     );
  //   } catch (e) {
  //     return ApiResponse(
  //       done: false,
  //       errorMsg: "Something went wrong: $e",
  //       responseString: null,
  //     );
  //   }
  // }


  static Future postMultipartCall(String url, Map map) async {
    print(url);
    print(map);
    try{
      final request = http.MultipartRequest('POST', Uri.parse(url));
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      request.headers["Content-Type"] = "multipart/form-data; boundary=<calculated when request is sent>";
      request.headers["Accept"] = "*/*";
      request.headers['Authorization']='78ygyugfregf874357438t54yuyfgfyueygyrgeygr4378t47';
      final response = await request.send();
      return checkStreamResponse(response);
    } on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your connection",
          responseString: null);
    }
  }

  // static Future postMultipartCallBroadcast(String url, Map map) async {
  //   print(url);
  //   print(map);
  //   try {
  //     final request = http.MultipartRequest('POST', Uri.parse(url));
  //     map.forEach((key, value) {
  //       request.fields[key] = value;
  //     });
  //     request.headers["Content-Type"] = "multipart/form-data; boundary=<calculated when request is sent>";
  //     request.headers["Accept"] = "*/*";
  //     request.headers['Authorization'] = '78ygyugfregf874357438t54yuyfgfyueygyrgeygr4378t47';
  //
  //     final response = await request.send();
  //
  //     // Convert the response stream to a broadcast stream
  //     final responseStream = response.stream.asBroadcastStream();
  //
  //     // Pass the broadcast stream to checkStreamResponse
  //     return await checkStreamResponse(responseStream);
  //   } on SocketException {
  //     return ApiResponse(
  //         done: false,
  //         errorMsg: "Please check your connection",
  //         responseString: null);
  //   }
  // }
  //
  // static Future<ApiResponse> uploadFile(
  //     {String? url, Map? map, String? imagePath}) async {
  //   try {
  //     var postUri = Uri.parse(url!);
  //     var request = http.MultipartRequest("POST", postUri);
  //
  //     map!.forEach((key, value) {
  //       request.fields[key] = value;
  //     });
  //     var multipartFile = await http.MultipartFile.fromPath("image", imagePath!,
  //         contentType: MediaType('image', 'jpeg'));
  //     request.files.add(multipartFile);
  //
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     return _checkResponse(response);
  //   } on SocketException {
  //     return ApiResponse(
  //         done: false,
  //         errorMsg: "Please check your connection",
  //         responseString: null);
  //   }
  // }
  //
  // static Future<ApiResponse> uploadFileWithToken(
  //     String url, Map map, String imagePath) async {
  //   try {
  //     Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $bearerToken',
  //     };
  //
  //     var postUri = Uri.parse(url);
  //     var request = http.MultipartRequest("POST", postUri);
  //     map.forEach((key, value) {
  //       request.fields[key] = value;
  //     });
  //     var multipartFile = http.MultipartFile.fromString("image", imagePath,
  //         contentType: MediaType('image', 'jpeg'));
  //     request.files.add(multipartFile);
  //     request.headers.addAll(headers);
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     return _checkResponse(response);
  //   } on SocketException {
  //     return ApiResponse(
  //         done: false,
  //         errorMsg: "Please check your connection",
  //         responseString: null);
  //   }
  // }
  //
  // static Future<ApiResponse> uploadProfileFileWithToken(
  //     String url, Map map, String imagePath) async {
  //   try {
  //     Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $bearerToken',
  //     };
  //
  //     var postUri = Uri.parse(url);
  //     var request = http.MultipartRequest("POST", postUri);
  //     map.forEach((key, value) {
  //       request.fields[key] = value;
  //     });
  //     var multipartFile = await http.MultipartFile.fromPath(
  //         "image[]", imagePath,
  //         contentType: MediaType('image', 'jpeg'));
  //     request.files.add(multipartFile);
  //     request.headers.addAll(headers);
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     return _checkResponse(response);
  //   } on SocketException {
  //     return ApiResponse(
  //         done: false,
  //         errorMsg: "Please check your connection",
  //         responseString: null);
  //   }
  // }
  //
  // static Future<ApiResponse> uploadFiles(
  //     {required String url,
  //       required Map<String, dynamic> map,
  //       String keyName =  'image',
  //       required List<File> images,
  //       bool token = false}) async {
  //   try {
  //     Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     };
  //
  //     if (token) {
  //       headers['Authorization'] = 'Bearer $bearerToken';
  //     }
  //
  //     var postUri = Uri.parse(url);
  //     var request = http.MultipartRequest("POST", postUri);
  //     map.forEach((key, value) {
  //       request.fields[key] = '$value';
  //     });
  //     if (images.isNotEmpty) {
  //       keyName = '$keyName[]';
  //     }
  //     for (var element in images){
  //       if (element is File) {
  //         var multipartFile = await http.MultipartFile.fromPath(
  //             keyName, element.path,
  //             contentType: MediaType('image', 'jpeg'));
  //         request.files.add(multipartFile);
  //       }
  //     }
  //
  //     request.headers.addAll(headers);
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     return _checkResponse(response);
  //   } on SocketException {
  //     return ApiResponse(
  //         done: false,
  //         errorMsg: "Please check your connection",
  //         responseString: null);
  //   }
  // }

  static Future<ApiResponse> postMultipartApiBytesWithToken({required String url,required Uint8List imageData,required String fileName,required Map map}) async {
    try {
      final http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      map.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      http.MultipartFile file = http.MultipartFile.fromBytes('image', imageData, filename: fileName);
      request.files.add(file);
      request.headers['Authorization'] = 'Bearer $bearerToken';
      final http.Response response = await http.Response.fromStream(await request.send());
      return _checkResponse(response);
    }
    on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your connection",
          responseString: null);
    }
  }
}