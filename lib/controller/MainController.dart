import 'dart:collection';
import 'dart:convert' as convert;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:simple_sq_music_plus_flutter_web/interceptors/ResponseInterceptors.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/CookieManager.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/HttpUtil.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/NetworkUtil.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/RequestUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/SQCookieManager.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/StorageUtils.dart';

class MainController  extends GetxController{

  String baseUrl = "http://127.0.0.1:8080/sw";
  // String baseUrl = "";
  String loginUrl = "/login";
  String isLoginUrl = "/isLogin";
  String getSearchTypeUrl = "/set/getSearchType";
  String getSearchTypeBrTypeUrl = "/set/getSearchTypeBrType";

  String searchUrl = "/searchMusic/searchType/searchValue/50/1";
  String searchArtistUrl = "/searchArtist/searchType/searchValue/50/1";
  String ArtistDownloadUrl = "/ArtistDownload";
  String searchAlbumUrl = "/searchAlbum/searchType/searchValue/50/1";
  String AlbumDownloadUrl = "/AlbumDownload";

  String ArtistSongListUrl = "/ArtistSongList";

  String musicDownloadUrl = "/musicDownload";
  String downloadInfoUrl = "/getTask";
  String downloadParserUrl = "/downloadParser";
  String parserUrlAndDownloadUrl = "/parserUrlAndDownload";
  String getSetListUrl = "/set/getSetList";
  String modifySetUrl = "/set/modify";
  String refreshTaskUrl = "/refreshTask";
  String delErrorTaskUrl = "/delErrorTask";
  String delSuccessTaskUrl = "/delSuccessTask";
  String againTaskUrl = "/againTask";
  String delAllTaskUrl = "/delAllTask";



  /**
   * 获取搜索的下拉类型
   */
  Future<dynamic> getSearchType()async{
    Response data = await NetworkUtil().get(baseUrl+getSearchTypeUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      StorageUtils.save("type",convert.jsonEncode(value["data"]));
      return value["data"];
    }
  }

  /**
   * 类型与码率
   */
  Future<dynamic> getSearchTypeBrType()async{
    Response data = await NetworkUtil().get(baseUrl+getSearchTypeBrTypeUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      value["data"].forEach((key,value)=>{
      StorageUtils.save("type_"+key,convert.jsonEncode(value))
      });
      return value["data"];
    }
  }

  /**
   * 搜索
   */
  Future<dynamic> search(String searchValue,String searchType) async{
    var url = searchUrl.replaceAll("searchValue",searchValue );
    url = url.replaceAll("searchType",searchType );
    Response data = await NetworkUtil().get(baseUrl+url);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return value["data"];
    }
  }
  /**
   * 搜索
   */
  Future<dynamic> searchArtist(String searchValue,String searchType) async{
    var url = searchArtistUrl.replaceAll("searchValue",searchValue );
    url = url.replaceAll("searchType",searchType );
    Response data = await NetworkUtil().get(baseUrl+url);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return value["data"];
    }
  }
  /**
   * 搜索
   */
  Future<dynamic> searchAlbum(String searchValue,String searchType) async{
    var url = searchAlbumUrl.replaceAll("searchValue",searchValue );
    url = url.replaceAll("searchType",searchType );
    Response data = await NetworkUtil().get(baseUrl+url);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return value["data"];
    }
  }
  /**
   * 下载
   */
  Future<bool> songDownloadToServer(String id,String subsonicPlayListName,String searchType) async{
    Map  pushdata ={};
    pushdata["id"]=id;
    pushdata["subsonicPlayListName"]=subsonicPlayListName;
    pushdata["plugType"]=searchType;
    String defaultType =  convert.jsonDecode(StorageUtils.get("set_music.download.type"))['configValue'];
   String plugTypeValue = StorageUtils.get("set_plug."+searchType+"."+defaultType+".type");
   pushdata["plugTypeValue"]=convert.jsonDecode(plugTypeValue)["configValue"];
    Response data = await NetworkUtil().postVoidBody(baseUrl+musicDownloadUrl,body: pushdata);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return true;
    }
    return false;
  }

  Future<bool> ArtistDownloadToServer(String id,String subsonicPlayListName,String searchType) async{
    Map  pushdata ={};
    pushdata["id"]=id;
    pushdata["subsonicPlayListName"]=subsonicPlayListName;
    pushdata["plugType"]=searchType;
    String defaultType =  convert.jsonDecode(StorageUtils.get("set_music.download.type"))['configValue'];
    String plugTypeValue = StorageUtils.get("set_plug."+searchType+"."+defaultType+".type");
    pushdata["plugTypeValue"]=convert.jsonDecode(plugTypeValue)["configValue"];
    Response data = await NetworkUtil().postVoidBody(baseUrl+ArtistDownloadUrl,body: pushdata);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return true;
    }
    return false;
  }
  Future<bool>AlbumDownloadToServer(String id,String subsonicPlayListName,String searchType) async{
    Map  pushdata ={};
    pushdata["id"]=id;
    pushdata["subsonicPlayListName"]=subsonicPlayListName;
    pushdata["plugType"]=searchType;
    String defaultType =  convert.jsonDecode(StorageUtils.get("set_music.download.type"))['configValue'];
    String plugTypeValue = StorageUtils.get("set_plug."+searchType+"."+defaultType+".type");
    pushdata["plugTypeValue"]=convert.jsonDecode(plugTypeValue)["configValue"];
    Response data = await NetworkUtil().postVoidBody(baseUrl+AlbumDownloadUrl,body: pushdata);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return true;
    }
    return false;
  }


  Future<bool> ArtistALLDownloadToServer(String id,String subsonicPlayListName,String searchType) async{
    Map  pushdata ={};
    pushdata["id"]=id;
    pushdata["subsonicPlayListName"]=subsonicPlayListName;
    pushdata["plugType"]=searchType;
    String defaultType =  convert.jsonDecode(StorageUtils.get("set_music.download.type"))['configValue'];
    String plugTypeValue = StorageUtils.get("set_plug."+searchType+"."+defaultType+".type");
    pushdata["plugTypeValue"]=convert.jsonDecode(plugTypeValue)["configValue"];
    Response data = await NetworkUtil().postVoidBody(baseUrl+ArtistSongListUrl,body: pushdata);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return true;
    }
    return false;
  }

  /// 获取下载列表
  Future<dynamic> getDownloadInfo() async{
    Response data =  await NetworkUtil().get(baseUrl+downloadInfoUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return value["data"];
    }
  }

  /// 刷新正在下载
  Future<bool> refreshTask() async{
    Response data =  await NetworkUtil().get(baseUrl+refreshTaskUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return true;
    }else{
      return false;
    }
  }
  /// 删除全部下载
  Future<bool> delAllTask() async {
    Response data = await NetworkUtil().get(baseUrl+delAllTaskUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(
        utf8decoder.convert(data.bodyBytes));
    if (data.statusCode == 200 && value["code"] == 200) {
      return true;
    } else {
      return false;
    }
  }
///删除错误下载
  Future<bool> delErrorTask() async{
    Response data =  await NetworkUtil().get(baseUrl+delErrorTaskUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return true;
    }else{
      return false;
    }
  }
  ///删除成功下载
  Future<bool> delSuccessTask() async{
    Response data =  await NetworkUtil().get(baseUrl+delSuccessTaskUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return true;
    }else{
      return false;
    }
  }
  ///重新下载错误数据
  Future<bool> againTask() async{
    Response data =  await NetworkUtil().get(baseUrl+againTaskUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
      return true;
    }else{
      return false;
    }
  }


  Future<dynamic> downloadParser(Map<String,dynamic> postdata) async{
    // var url = baseUrl+downloadParserUrl;
    // Response value = await RequestUtils.dio.post(url,data:postdata,options:Options(
    //   contentType: Headers.jsonContentType,
    // ) );
    // if(value.statusCode==200){
    //   return value.data["data"];
    // }
  }

  Future<dynamic> parserUrlAndDownload(String downloadUrl,{String br = "2000",bool isAudioBook = false, String bookName="系统默认",String artist = "Sqmucic",playListName=""}) async{
    // var url = baseUrl+parserUrlAndDownloadUrl;
    // HashMap<String,String> hashMap = new HashMap();
    // hashMap["url"] = downloadUrl;
    // hashMap["br"] = br;
    // hashMap["isAudioBook"] = isAudioBook.toString();
    // hashMap["bookName"] = bookName;
    // hashMap["artist"] = artist;
    // hashMap["playListName"] = playListName;
    //
    // Response value = await RequestUtils.dio.post(url,data:hashMap,options:Options(
    //   contentType: Headers.jsonContentType,
    // ) );
    // if(value.statusCode==200){
    //   return value.data["data"];
    // }
  }


  Future<dynamic>  getAllSet() async{
    StorageUtils.cleanAll();
    Response data = await NetworkUtil().get(baseUrl+getSetListUrl);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200){
      // print(convert.jsonEncode(value.data["data"]));
      var data = value["data"];
      for (var element in data) {
        // if(element["configKey"]=='music.download.path'){
        //   element["type"] = "input";
        // }else if (element["configKey"]=='music.download.size'){
        //   element["type"] = "number";
        // }else if (element["configKey"]=='system.username'){
        //   element["type"] = "input";
        // }else if (element["configKey"]=='system.password'){
        //   element["type"] = "input";
        // }else if (element["configKey"]=='plug.subsonic.url'){
        //   element["type"] = "input";
        // }else if (element["configKey"]=='plug.subsonic.usernmae'){
        //   element["type"] = "input";
        // }else if (element["configKey"]=='plug.subsonic.password'){
        //   element["type"] = "input";
        // }else if (element["configKey"]=='plug.subsonic.default.playListName'){
        //   element["type"] = "input";
        // }else {
        //   element["type"] = "switch";
        // }
        // for (var key in element.keys){
        //   print("for 循环遍历 : Key : $key , Value : ${element[key]}");
        // }
        StorageUtils.save("set_"+element["configKey"],convert.jsonEncode(element));
      }
      StorageUtils.save("setInfo", convert.jsonEncode(value["data"]));
    }
  }

  Future<dynamic> modifySet(String config_key,String config_value) async{
    // var url = baseUrl+modifySetUrl;
    // HashMap<String,String> hashMap = new HashMap();
    // hashMap["configKey"] = config_key;
    // hashMap["configValue"] = config_value;
    // Response value = await RequestUtils.dio.post(url,data:hashMap,options:Options(
    //   contentType: Headers.jsonContentType,
    // ) );
    // if(value.statusCode==200){
    //   getAllSet();
    //   return value.data["data"];
    // }

  }
  Future<bool> login(String username,String password) async{
    var postdata = {"username":username,"password":password};
    NetworkUtil().setHeaders({});
    Response data =  await NetworkUtil().post(baseUrl+loginUrl,body: postdata);
    var utf8decoder = new convert.Utf8Decoder();
    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));

    if(data.statusCode==200&&value["code"]==200){
       var token = value["data"]["tokenValue"];
       var tokenname = value["data"]["tokenName"];
       var instance = CookieManager.getInstance();
       instance.save("logintokenname",tokenname);
       instance.save("logintoken",token);
       NetworkUtil().setHeaders({tokenname:token});
       return true;
    }
    return false;
  }

  Future<bool>  isLogin () async{
    var instance = CookieManager.getInstance();

    var tokenname = instance.get("logintokenname");
    var token =  instance.get("logintoken");
    if(tokenname==null||token==null){
      return false;
    }
    Response data ;
    try {
      NetworkUtil().setHeaders({tokenname:token});

      data = await NetworkUtil().get(baseUrl+isLoginUrl);

    } catch (e) {
     return false;
    }

    var utf8decoder = new convert.Utf8Decoder();

    Map<String, dynamic> value = convert.jsonDecode(utf8decoder.convert(data.bodyBytes));
    if(data.statusCode==200&&value["code"]==200){
        return true;
    }else{
      instance.clearAllCookies();
      // StorageUtils.remove("logintokenname");
      // StorageUtils.remove("logintoken");
      return false;
    }
  }








}
