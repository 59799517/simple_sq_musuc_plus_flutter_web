import 'package:flutter/material.dart';
import 'dart:html';


class CookieManager {

  static  CookieManager? _manager;

  static CookieManager getInstance() {
    if (_manager == null) {
      _manager = CookieManager();
    }
    return _manager!;
  }

  void addToCookie(String key, String value) {
    // 2592000 sec = 30 days.
    document.cookie = "$key=$value; max-age=2592000; path=/;";
  }
  void save(String key, String value) {
    addToCookie(key,value);
  }

  String getCookie(String key) {
    String cookies = document.cookie as String;
    List<String> listValues = cookies.isNotEmpty ? cookies.split(";") : [];
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String _key = map[0].trim();
      String _val = map[1].trim();
      if (key == _key) {
        matchVal = _val;
        break;
      }
    }
    return matchVal;
  }

  String get(String key ){
    return getCookie(key);
  }

  void deleteCookie(String key) {
    document.cookie = "$key=; max-age=0; path=/;";
  }

  void clearAllCookies() {
    List<String> cookies = document.cookie!.split(";");
    for (int i = 0; i < cookies.length; i++) {
      String key = cookies[i].split("=")[0].trim();
      document.cookie = "$key=; max-age=0; path=/;";
    }
  }
}
