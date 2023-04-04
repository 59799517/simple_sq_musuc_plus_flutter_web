import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_sq_music_plus_flutter_web/config/ColorAndStyle.dart';
import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/CookieManager.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MainController controller = Get.find<MainController>();

  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String userName ="";
  String password="";
  bool isShowPassWord = false;

  void login(){
    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if(loginForm!.validate()){
      loginForm.save();

      if(userName.length==0&&password.length==0){
        ToastUtils.showToast("请填完整登录信息");
      }else{
        controller.login(userName!, password!).then((value) => {
          // controller.isLogin().then((value) => {
          //   print(value)
          // }),
          if(value){
            controller.getAllSet().then((value) => {
              controller.getSearchType().then((value) => {
                controller.getSearchTypeBrType().then((value) => {
                  Get.offAllNamed("/")
                })
              })
            }),

          }else{
            ToastUtils.showToast("请输入正确的账号密码")
          }
        });
      }

    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }


  @override
  void initState() {
    super.initState();
    controller.isLogin().then((value) => {
      if(value){

        Get.offAllNamed("/")
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAndStyle.backgroundColor,
      body: new Column(
        children: <Widget>[
          new Container(
              padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
              child: new Text(
                'SqMusic',
                style: TextStyle(
                    color: ColorAndStyle.textColor,
                    fontSize: 50.0
                ),
              )
          ),
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
              key: loginKey,
              child: new Column(
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0
                            )
                        )
                    ),
                    child: new TextFormField(
                      style: TextStyle(color: ColorAndStyle.textColor),
                      decoration: new InputDecoration(
                        labelText: '账号',
                        labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                        // suffixIcon: new IconButton(
                        //   icon: new Icon(
                        //     Icons.close,
                        //     color: Color.fromARGB(255, 126, 126, 126),
                        //   ),
                        //   onPressed: () {

                        //   },
                        // ),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        userName = value.toString();
                      },
                      validator: (phone) {
                        // if(phone.length == 0){
                        //   return '请输入手机号';
                        // }
                      },
                      onFieldSubmitted: (value) {

                      },
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0
                            )
                        )
                    ),
                    child: new TextFormField(
                      style: TextStyle(color: ColorAndStyle.textColor),
                      decoration:  new InputDecoration(
                          labelText: '密码',
                          labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          suffixIcon: new IconButton(
                            icon: new Icon(
                              isShowPassWord ? Icons.visibility : Icons.visibility_off,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                            onPressed: showPassWord,
                          )
                      ),
                      obscureText: !isShowPassWord,
                      onSaved: (value) {
                        password = value.toString();
                      },
                    ),
                  ),
                  new Container(
                    height: 45.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: new SizedBox.expand(
                      child: new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(45.0)),
                          padding: const EdgeInsets.all(12.0),
                          primary: Colors.green,
                        ),
                        onPressed: login,
                        child: new Text(
                          '登录',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 255, 255, 255)
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // void login (){
  //   controller.login("admin", "admin").then((value) => {
  //     if(value){
  //       Get.offAllNamed("/")
  //     }else{
  //       ToastUtils.showToast("请输入正确的账号密码")
  //     }
  //   });
  // }
}
