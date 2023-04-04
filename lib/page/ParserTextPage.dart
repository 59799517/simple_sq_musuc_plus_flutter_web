import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:simple_sq_music_plus_flutter_web/config/ColorAndStyle.dart';
import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/ToastUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/MainAppBar.dart';

class ParserTextPage extends StatefulWidget {
  @override
  State<ParserTextPage> createState() => _ParserTextPageState();
}

class _ParserTextPageState extends State<ParserTextPage> {
  @override
  void initState() {
    super.initState();
  }

  Size? size;
  MainController controller = Get.find<MainController>();
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  var parser_value = "".obs;
  String playListName ="";

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorAndStyle.backgroundColor,
      key: _scaffoldkey,
      drawer: MainAppBar.getDrawer(_scaffoldkey),
      appBar: MainAppBar.getAppBar(_scaffoldkey, title: "ParserText"),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SelectableText(
                "请输入歌单信息：",
                style: TextStyle(
                    color: ColorAndStyle.textColor,
                    fontSize: size!.height * 0.03),
              ),
              Container(
                height: size!.height * 0.7,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
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
                    ],
                  ),
                ),
              ),
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
              ),


              GFButton(
                onPressed: () {
                  pushToParserServer();
                },
                text: "解析",
                shape: GFButtonShape.square,
                type: GFButtonType.outline,
              ),
              const SelectableText(
                "注释:转换请参考：https://yyrcd.com/n2s/",
                style: TextStyle(color: Colors.white10, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pushToParserServer(){
    Map<String,String> map = new Map();
    map["text"] = parser_value.value;
    map["br"] = "2000";
    map["playListName"] = playListName;

    controller.downloadParser(map).then((value) => {
      ToastUtils.showToast("推送完成")
    });
  }

}
