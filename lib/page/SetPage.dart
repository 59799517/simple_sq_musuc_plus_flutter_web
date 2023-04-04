import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'package:simple_sq_music_plus_flutter_web/config/ColorAndStyle.dart';
import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/StorageUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/ToastUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/FLListTile.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/MainAppBar.dart';

class SetPage extends StatefulWidget {
  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  void initState() {
    super.initState();
    var sp =  convert.jsonDecode(StorageUtils.get("setInfo"));
    list.value =sp;

  }
  final numberReg = RegExp(r'^-?[0-9]+');
  var list = [].obs;
  Size? size;
  MainController controller = Get.find<MainController>();
  TextEditingController _textEditingController = new TextEditingController(text: '初始化内容');
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  var isChecked  = false.obs;
  var inputvalue  = "".obs;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: ColorAndStyle.backgroundColor,
      key: _scaffoldkey,
      drawer: MainAppBar.getDrawer(_scaffoldkey),
      appBar: MainAppBar.getAppBar(_scaffoldkey,title: "Set"),
      body: new Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              // child: Center(),
              child: Obx(()=>ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    _buildListItem(context, index),
                itemCount: list.value.length,
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {

    return SizedBox(
      child: FLListTile(
        isThreeLine: true,
        backgroundColor: Colors.transparent,
        title: Text(
          list.value[index]["configName"],
          style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
        ),
        subtitle: Align(
            child:  Text(
              list[index]["type"]!='switch'?
              list[index]["configValue"]: list[index]["configValue"]=='true'?'是':'否',
              style: ColorAndStyle.textStyle,
            ),
            alignment: FractionalOffset.topLeft
        ),
        trailing: IconButton(icon: Icon(Icons.chevron_right,color: ColorAndStyle.textColor,),onPressed: () {
          _textEditingController = new TextEditingController(text: list[index]["configValue"]);
         if(list[index]["type"]=='switch'){
           isChecked.value =  list[index]["configValue"]=='true'?true:false;
         }
          Get.defaultDialog (title: list.value[index]["configName"],
              titleStyle:ColorAndStyle.textStyle,
              backgroundColor:ColorAndStyle.backgroundColor,
              content: list[index]["type"]!='switch'?
              TextField(
                controller: _textEditingController,
                style: ColorAndStyle.textStyle,
                cursorColor: ColorAndStyle.textColor,
                keyboardType: list[index]["type"]=='number'?TextInputType.number:null,
                decoration: InputDecoration(
                  hintText: list[index]["type"]=='number'?"请输入数字":"请输入信息",
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
                onChanged: (value){
                  inputvalue.value = value;
                },
              ):
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GFToggle(
                    onChanged: (val){
                      isChecked.value = !isChecked.value;
                    },
                    value: isChecked.value,
                  ),
                  Obx(() => Text(isChecked.value?"是":"否",style: ColorAndStyle.textStyle,))
                ],
              ),
              textConfirm:"确定",
              textCancel :"取消",
              buttonColor: Colors.green,
              onConfirm: (){
               if(list[index]["type"]=='switch'){
                 modifySet(list[index]["configKey"],isChecked.value.toString());
               }else if(list[index]["type"]!='number'){
                  if(numberReg.hasMatch(inputvalue.value)){
                    modifySet(list[index]["configKey"],inputvalue.value);
                  }else{
                    ToastUtils.showToast("只能填写纯数字");
                  }
               }else{
                 modifySet(list[index]["configKey"],inputvalue.value);
               }
              },
              cancelTextColor:ColorAndStyle.textColor,
              confirmTextColor: ColorAndStyle.textColor,
          );
        },),
      ),
    );
  }

  void modifySet(String config_key,String config_value){
    if(config_value!=null||config_value.length>0){
      controller.modifySet(config_key,config_value).then((value) => {
        controller.getAllSet().then((value) => {
      setState((){
      var sp =  convert.jsonDecode(StorageUtils.get("setInfo"));
      list.value =sp;
      }),
      Get.back(),
          ToastUtils.showToast("修改成功")
        })
      });
    }else{
      ToastUtils.showToast("修改值不能为空");
    }

  }

}
