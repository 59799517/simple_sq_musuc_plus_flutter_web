import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simple_sq_music_plus_flutter_web/utils/StorageUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/ToastUtils.dart';


class NetworkUtil {
  static final NetworkUtil _singleton = NetworkUtil._internal();
  static Map<String, String> _headers = {};
  // static String _baseUrl = '';

  factory NetworkUtil() {
    return _singleton;
  }

  NetworkUtil._internal();

  void setHeaders(Map<String, String> headers) {
    _headers = headers;
  }

  // void setBaseUrl(String baseUrl) {
  //   _baseUrl = baseUrl;
  // }

  Future<http.Response> get(String url) async {
    _headers.remove("Content-Type");
    Uri parse = Uri.parse( url);
     http.Response response = await http.get(parse, headers: _headers).timeout(Duration(seconds: 10));
     int statusCode = response.statusCode;
     if(statusCode==401){
       ToastUtils.showToast("登录超时请重新登录");
       Get.offAndToNamed("/login");
     }
    return response;
  }

  Future<http.Response> post(String url, {Map<String, String>? headers, body}) async {
    if(headers !=null){
      headers["Content-Type"] = "application/json";
    }else{
      _headers["Content-Type"] = "application/json";
    }
    var putBody=jsonEncode({"":""});
    if(body!=null){
      putBody = jsonEncode(body);
    }
    http.Response response = await http.post(Uri.parse( url), headers: headers ?? _headers, body: putBody, encoding: Encoding.getByName("utf-8")).timeout(Duration(seconds: 10));
    int statusCode = response.statusCode;
    if(statusCode==401){
      ToastUtils.showToast("登录超时请重新登录");
      Get.offAndToNamed("/login");
    }
  return response;
  }

  Future<http.Response> postVoidBody(String url, { body}) async {
      _headers["Content-Type"] = "application/json";
    var putBody=jsonEncode({"":""});
    if(body!=null){
      putBody = jsonEncode(body);
    }
    http.Response response = await http.post(Uri.parse( url), headers:_headers, body: putBody, encoding: Encoding.getByName("utf-8")).timeout(Duration(seconds: 10));
    int statusCode = response.statusCode;
    if(statusCode==401){
      ToastUtils.showToast("登录超时请重新登录");
      Get.offAndToNamed("/login");
    }
    return response;
  }
}
