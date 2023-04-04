import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';
import 'package:simple_sq_music_plus_flutter_web/page/DownloadPage.dart';
import 'package:simple_sq_music_plus_flutter_web/page/HomePage.dart';
import 'package:simple_sq_music_plus_flutter_web/page/IndexPage.dart';
import 'package:simple_sq_music_plus_flutter_web/page/LoginPage.dart';
import 'package:simple_sq_music_plus_flutter_web/page/ParserPlaylistPage.dart';
import 'package:simple_sq_music_plus_flutter_web/page/ParserTextPage.dart';
import 'package:simple_sq_music_plus_flutter_web/page/SetPage.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/CookieManager.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/StorageUtils.dart';

class MainRoute {
  List<GetPage> routes = [
    new GetPage(name: '/', page: () => IndexPage()),
    new GetPage(name: '/login', page: () => LoginPage()),
    new GetPage(name: '/index', page: () => IndexPage()),
    new GetPage(name: '/download', page: () => DownloadPage()),
    new GetPage(name: '/parsertext', page: () => ParserTextPage()),
    new GetPage(name: '/parserPlaylist', page: () => ParserPlaylistPage()),
    new GetPage(name: '/set', page: () => SetPage()),
  ];
  GetMaterialApp getMaterialApp(){


      return GetMaterialApp(
          debugShowCheckedModeBanner:false,
          // unknownRoute: routes[6],
          initialRoute: '/login',
          getPages:routes
      );

  }
}
