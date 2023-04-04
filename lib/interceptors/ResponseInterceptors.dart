// import 'package:dio/dio.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:simple_sq_music_plus_flutter_web/utils/StorageUtils.dart';
//
// class ResponseInterceptors extends InterceptorsWrapper{
//
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     if(response.statusCode==401){
//       Get.offAllNamed("/login");
//       print("token过期需要登录");
//     }else{
//       handler.next(response);
//     }
//   }
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     String path = options.path;
//     if(path.contains("/set/getSetList")||path.contains("/login")){
//     }else{
//       var logintokenname = StorageUtils.box.read("logintokenname");
//       var logintoken = StorageUtils.box.read("logintoken");
//       if(logintokenname!=null&&logintoken!=null){
//         Map<String, dynamic> headers = new Map();
//          headers[logintokenname] = logintoken;
//         options.headers.addAll(headers);
//       }else{
//         Get.offAllNamed("/login");
//       }
//     }
//     handler.next(options);
//   }
// }