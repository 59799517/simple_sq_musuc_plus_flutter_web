import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:simple_sq_music_plus_flutter_web/config/ColorAndStyle.dart';
import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/ToastUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/MainAppBar.dart';

class ParserPlaylistPage extends StatefulWidget {
  @override
  State<ParserPlaylistPage> createState() => _ParserPlaylistPageState();
}

class _ParserPlaylistPageState extends State<ParserPlaylistPage> {
  @override
  void initState() {
    super.initState();
    isChecked=false;
  }

  Size? size;
  MainController controller = Get.find<MainController>();
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  var parser_value = "".obs;
  bool isChecked  = false;
  String bookName ="";
  String playListName ="";
  String artist ="";

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorAndStyle.backgroundColor,
      key: _scaffoldkey,
      drawer: MainAppBar.getDrawer(_scaffoldkey),
      appBar: MainAppBar.getAppBar(_scaffoldkey, title: "ParserPlaylist"),
      body: Container(
        child: Center(
          child: Column(
            children: [

              Expanded(
                flex: 2,
                child: SelectableText(
                  "分享地址：",
                  style: TextStyle(
                      color: ColorAndStyle.textColor,
                      fontSize: size!.height * 0.03),
                ),
              ),
              Expanded(
                flex: 6,
                child: TextField(
                  onChanged: (value) {
                    parser_value.value = value;
                  },
                  onSubmitted: (value) {
                    parser_value.value = value;
                  },
                  obscureText: false,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: ColorAndStyle.textStyle,
                  decoration: const InputDecoration(
                    hintText: "请输入歌单信息",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              !isChecked?Expanded(child: Container(
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(flex: 5,child:Container()),
                        Expanded(child: Text("歌单名称：",style: ColorAndStyle.textStyle),flex: 2),
                        Expanded(child: TextField(
                          onChanged: (value){
                            playListName = value;
                          },
                          style: ColorAndStyle.textStyle,
                          cursorColor: ColorAndStyle.textColor,
                          decoration: InputDecoration(
                            hintText: "不想添加则不填写",
                            hintStyle: TextStyle(color: Colors.white30),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),

                          ),
                        ),flex: 5,),
                        Expanded(flex: 5,child:Container()),
                      ],
                    )
                  ],
                ),

              ),flex: 3,):Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(flex: 5,child:Container()),
                          Expanded(child: Text("书名：",style: ColorAndStyle.textStyle),flex: 2),
                          Expanded(child: TextField(
                            onChanged: (value){
                              bookName = value;
                            },
                            style: ColorAndStyle.textStyle,
                            cursorColor: ColorAndStyle.textColor,
                            decoration: InputDecoration(
                                hintText: "请输入",
                                hintStyle: TextStyle(color: Colors.white30),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white
                                    )
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white
                                    )
                                ),

                            ),
                          ),flex: 2,),
                          Expanded(flex: 5,child:Container()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(flex: 5,child:Container()),
                          Expanded(child: Text("作者：",style: ColorAndStyle.textStyle),flex: 2),
                          Expanded(child: TextField(
                            onChanged: (value){
                              artist = value;
                            },
                            style: ColorAndStyle.textStyle,
                            cursorColor: ColorAndStyle.textColor,
                            decoration: InputDecoration(
                              hintText: "请输入",
                              hintStyle: TextStyle(color: Colors.white30),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white
                                )
                              ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white
                                    )
                                )
                            ),
                          ),flex: 2,),
                          Expanded(flex: 5,child:Container()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Checkbox(
                        activeColor: GFColors.PRIMARY,
                        // 选中后对号的颜色
                        checkColor: ColorAndStyle.textColor,
                        onChanged: (value) {

                          setState((){
                            isChecked = !isChecked;
                          });
                        },
                        value: !isChecked,
                      ),
                      Text("歌单：",style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height * 0.03),),
                      Checkbox(
                        // 选中后的颜色
                        activeColor: GFColors.PRIMARY,
                        // 选中后对号的颜色
                        checkColor: ColorAndStyle.textColor,
                        onChanged: (value) {

                          setState((){
                            isChecked = !isChecked;
                          });
                        },
                        value: isChecked,
                      ),
                      Text("有声书：",style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height * 0.03),),
                    ],
                  ),
                ),
              ),

              GFButton(
                onPressed: () {
                  parserUrlAndDownload();
                },
                text: "提交",
                shape: GFButtonShape.square,
                type: GFButtonType.outline,
              ),
              Expanded(
                flex: 1,
                child: const SelectableText(
                  "注释:支持酷我--歌单与专辑的分享链接--其余请自行尝试",
                  style: TextStyle(color: Colors.white10, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void parserUrlAndDownload(){
    controller.parserUrlAndDownload(parser_value.value,isAudioBook:isChecked,bookName: bookName,artist:artist,playListName: playListName).then((value) => {
      ToastUtils.showToast("推送完成")
    });
  }
}