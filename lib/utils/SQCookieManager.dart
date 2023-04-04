// import 'dart:io';
//
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:simple_sq_music_plus_flutter_web/utils/StorageUtils.dart';
//
//
// class SQCookieManager   extends Interceptor{
//   /// Cookie manager for http requests。Learn more details about
//   /// CookieJar please refer to [cookie_jar](https://github.com/flutterchina/cookie_jar)
//   CookieJar? cookieJar;
//   static dynamic kwCookies;
//   SQCookieManager(this.cookieJar);
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     cookieJar!.loadForRequest(options.uri).then((cookies) {
//       // cookies
//      Map<String,String>  map = {};
//       cookies.map((e) => {
//         map[e.name] = e.value
//       });
//       options.headers.addAll(map);
//       var cookie = getCookies(cookies);
//       kwCookies=cookies;
//       if (cookie.isNotEmpty) {
//         options.headers[HttpHeaders.cookieHeader] = cookie;
//       }
//
//      String path = options.path;
//      if(path.contains("/set/getSetList")||path.contains("/login")){
//      }else{
//        var logintokenname = StorageUtils.box.read("logintokenname");
//        var logintoken = StorageUtils.box.read("logintoken");
//        if(logintokenname!=null&&logintoken!=null){
//          Map<String, dynamic> headers = new Map();
//          headers[logintokenname] = logintoken;
//          options.headers.addAll(headers);
//        }else{
//          Get.offAndToNamed("/login");
//        }
//      }
//
//       handler.next(options);
//     }).catchError((e, stackTrace) {
//       var err = DioError(requestOptions: options, error: e);
//       err.stackTrace = stackTrace;
//       handler.reject(err, true);
//     });
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     _saveCookies(response)
//         .then((_) => handler.next(response))
//         .catchError((e, stackTrace) {
//       var err = DioError(requestOptions: response.requestOptions, error: e);
//       err.stackTrace = stackTrace;
//       handler.reject(err, true);
//     });
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     if (err.response != null) {
//       _saveCookies(err.response!)
//           .then((_) => handler.next(err))
//           .catchError((e, stackTrace) {
//         var _err = DioError(
//           requestOptions: err.response!.requestOptions,
//           error: e,
//         );
//         _err.stackTrace = stackTrace;
//         handler.next(_err);
//       });
//     } else {
//       handler.next(err);
//     }
//   }
//
//   Future<void> _saveCookies(Response response) async {
//     var cookies = response.headers[HttpHeaders.setCookieHeader];
//
//     if (cookies != null) {
//       await cookieJar!.saveFromResponse(
//         response.requestOptions.uri,
//         cookies.map((str) => Cookie.fromSetCookieValue(str)).toList(),
//       );
//     }
//   }
//
//   static String getCookies(List<Cookie> cookies) {
//     return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
//   }
// }