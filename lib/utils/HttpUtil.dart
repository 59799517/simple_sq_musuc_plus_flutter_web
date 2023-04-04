// import 'package:dio/dio.dart';
//
// class HttpUtil {
//
//   static final HttpUtil _instance = HttpUtil._internal();
//
//   factory HttpUtil() => _instance;
//
//   HttpUtil._internal();
//
//   final Dio _dio = Dio();
//
//   void setDefaultHeaders(Map<String, String> headers) {
//     _dio.options.headers.addAll(headers);
//     _dio.interceptors.add(InterceptorsWrapper(
//       onRequest: ( RequestOptions options,RequestInterceptorHandler handler){
//         if (options.method == 'OPTIONS') {
//           handler.resolve(Response(data: null, statusCode: 200, requestOptions: options));
//         }
//         handler.next(options);
//       }
//     ));
//
//   }
//
//   Future<Response> get(String url, {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) async {
//     final response = await _dio.get(url, queryParameters: queryParameters, options: Options(headers: headers));
//     return response;
//   }
//   Future<Response> getNotParameters(String url) async {
//     Map<String, dynamic> modifiedHeaders =  _dio.options.headers;
//     modifiedHeaders.remove('Content-Type');
//     final options = Options(headers: modifiedHeaders);
//     print(modifiedHeaders);
//     print(url);
//     final response = await _dio.get(url,options: options);
//     return response;
//
//
//   }
//   Future<Response> post(String url, {Map<String, dynamic>? queryParameters, data, Map<String, String>? headers}) async {
//     final response = await _dio.post(url, queryParameters: queryParameters, data: data, options: Options(headers: headers,contentType: Headers.jsonContentType));
//     return response;
//   }
//
//   Future<Response> put(String url, {data, Map<String, String>? headers}) async {
//     final response = await _dio.put(url, data: data, options: Options(headers: headers));
//     return response;
//   }
//
//   Future<Response> delete(String url, {data, Map<String, String>? headers}) async {
//     final response = await _dio.delete(url, data: data, options: Options(headers: headers));
//     return response;
//   }
// }