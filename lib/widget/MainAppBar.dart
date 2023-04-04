import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:simple_sq_music_plus_flutter_web/config/ColorAndStyle.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/FLListTile.dart';

class MainAppBar  {


   static GFAppBar getAppBar(GlobalKey<ScaffoldState> scaffoldkey,{String title = "SqMusic"}){
    return GFAppBar(
      backgroundColor:ColorAndStyle.backgroundColor,
      leading:  GFIconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          scaffoldkey.currentState?.openDrawer();
        },
        type: GFButtonType.transparent,
      ),
      title: Text(title,style: TextStyle(fontSize: 15),),
      actions: <Widget>[
        GFIconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Get.offAndToNamed("/set");
          },
          type: GFButtonType.transparent,
        ),
      ],
    );
  }


   static GFDrawer getDrawer(GlobalKey<ScaffoldState> scaffoldkey,){
     return GFDrawer(
       color: ColorAndStyle.backgroundColor,
       child: ListView(
         padding: EdgeInsets.zero,
         children: <Widget>[
           FLListTile(
             backgroundColor: Colors.transparent,
             title: Text('系统菜单：',style: TextStyle(fontSize: 18,color: ColorAndStyle.textColor),),
             onTap: null,

           ),
           DecoratedBox(
             decoration:BoxDecoration(
                 border:Border.all(color: Colors.white12,width: 1.0)
             ),
           ),
           FLListTile(
             backgroundColor: Colors.transparent,
             title: Text('搜索',style: ColorAndStyle.textStyle,),
             onTap: (){
               Get.offAndToNamed("/");
               scaffoldkey.currentState?.closeDrawer();
             },
           ),
           FLListTile(
             backgroundColor: Colors.transparent,
             title: Text('下载管理',style: ColorAndStyle.textStyle),
             onTap: (){
               Get.offAndToNamed("/download");
               scaffoldkey.currentState?.closeDrawer();
             },
           ),
           FLListTile(
             backgroundColor: Colors.transparent,
             title: Text('解析歌单',style: ColorAndStyle.textStyle,),
             onTap: (){
               Get.offAndToNamed("/parsertext");
               scaffoldkey.currentState?.closeDrawer();
             },
           ),
           FLListTile(
             backgroundColor: Colors.transparent,
             title: Text('歌单（有声书）下载',style: ColorAndStyle.textStyle,),
             onTap: (){
               Get.offAndToNamed("/parserPlaylist");
               scaffoldkey.currentState?.closeDrawer();
             },
           ),
           FLListTile(
             backgroundColor: Colors.transparent,
             title: Text('设置',style: ColorAndStyle.textStyle,),
             onTap: (){
               Get.offAndToNamed("/set");
               scaffoldkey.currentState?.closeDrawer();
             },
           ),
         ],
       ),
     );
   }
}