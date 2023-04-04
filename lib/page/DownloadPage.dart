import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:simple_sq_music_plus_flutter_web/config/ColorAndStyle.dart';
import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/ToastUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/FLListTile.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/MainAppBar.dart';
import 'package:tab_container/tab_container.dart';

class DownloadPage extends StatefulWidget {
  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  void initState() {
    super.initState();
    getDownloadInfo();
  }

  Size? size;
  MainController controller = Get.find<MainController>();
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  var downloadInfo_ready = [].obs;

  var downloadInfo_success = [].obs;

  var downloadInfo_error = [].obs;

  var downloadInfo_run = [].obs;

  var timeout = const Duration(seconds: 30);
  HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorAndStyle.backgroundColor,
      key: _scaffoldkey,
      drawer: MainAppBar.getDrawer(_scaffoldkey),
      appBar: MainAppBar.getAppBar(_scaffoldkey, title: "Download"),
      body: new Container(
        child: TabContainer(
          color: Colors.white10,
          tabs: [
            Text("待下载", style: ColorAndStyle.textStyle),
            Text("下载中", style: ColorAndStyle.textStyle),
            Text("已完成", style: ColorAndStyle.textStyle),
            Text("下载错误", style: ColorAndStyle.textStyle)
          ],
          isStringTabs: false,
          children: [
            Obx(() => downloadInfo_ready.value.length > 0
                ? Container(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          _buildownloadListItemReady(context, index),
                      itemCount: downloadInfo_ready.value.length,
                    ),
                  )
                : Container(
                    child: Text(
                    "",
                    style: ColorAndStyle.textStyle,
                  ))),
            Obx(() => downloadInfo_run.value.length > 0
                ? HawkFabMenu(
                    icon: AnimatedIcons.menu_arrow,
                    fabColor: Colors.transparent,
                    iconColor: Colors.green,
                    hawkFabMenuController: hawkFabMenuController,
                    items: [
                      HawkFabMenuItem(
                        label: '刷新正在下载',
                        ontap: () {
                          controller.refreshTask().then((value) => {
                            if(value){
                              ToastUtils.showToast("刷新成功")
                            }else{
                              ToastUtils.showToast("刷新失败")
                            }
                          });
                        },
                        icon: const Icon(Icons.refresh_sharp),
                        color: Colors.red,
                        labelColor: Colors.red,
                      )
                    ],
                    body: Container(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            _buildownloadListItemRun(context, index),
                        itemCount: downloadInfo_run.value.length,
                      ),
                    ))
                : Container(
                    child: Text(
                    "",
                    style: ColorAndStyle.textStyle,
                  ))),
            Obx(() => downloadInfo_success.value.length > 0
                ? HawkFabMenu(
                    icon: AnimatedIcons.menu_arrow,
                    fabColor: Colors.transparent,
                    iconColor: Colors.green,
                    hawkFabMenuController: hawkFabMenuController,
                    items: [
                      HawkFabMenuItem(
                        label: '清空已完成',
                        ontap: () {
                          controller.delSuccessTask().then((value) => {
                            if(value){
                              ToastUtils.showToast("清空完成")
                            }else{
                              ToastUtils.showToast("清空失败")
                            }
                          });
                        },
                        icon: const Icon(Icons.clear),
                        color: Colors.red,
                        labelColor: Colors.red,
                      ),
                      HawkFabMenuItem(
                        label: '删除全部（待下载，正在下载，已完成，错误）',
                        ontap: () {
                          controller.delAllTask().then((value) => {
                            if(value){
                              ToastUtils.showToast("删除成功")
                            }else{
                              ToastUtils.showToast("删除失败")
                            }
                          });
                        },
                        icon: const Icon(Icons.refresh_sharp),
                        color: Colors.red,
                        labelColor: Colors.red,
                      )
                    ],
                    body: Container(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            _buildownloadListItemSuccess(context, index),
                        itemCount: downloadInfo_success.value.length,
                      ),
                    ))
                : Container(
                    child: Text(
                    "",
                    style: ColorAndStyle.textStyle,
                  ))),
            Obx(() => downloadInfo_error.value.length > 0
                ? HawkFabMenu(
                    icon: AnimatedIcons.menu_arrow,
                    fabColor: Colors.transparent,
                    iconColor: Colors.green,
                    hawkFabMenuController: hawkFabMenuController,
                    items: [
                      HawkFabMenuItem(
                        label: '清空错误下载',
                        ontap: () {
                          controller.delErrorTask().then((value) => {
                            if(value){
                              ToastUtils.showToast("删除成功")
                            }else{
                              ToastUtils.showToast("删除失败")
                            }
                          });
                        },
                        icon: const Icon(Icons.clear),
                        color: Colors.red,
                        labelColor: Colors.red,
                      ),
                      HawkFabMenuItem(
                        label: '重新下载错误数据',
                        ontap: () {
                          controller.againTask().then((value) => {
                            if(value){
                              ToastUtils.showToast("删除成功")
                            }else{
                              ToastUtils.showToast("删除失败")
                            }
                          });
                        },
                        icon: const Icon(Icons.refresh_sharp),
                        color: Colors.red,
                        labelColor: Colors.red,
                      )
                    ],
                    body: Container(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            _buildownloadListItemError(context, index),
                        itemCount: downloadInfo_error.value.length,
                      ),
                    ))
                : Container(
                    child: Text(
                    "",
                    style: ColorAndStyle.textStyle,
                  ))),
          ],
        ),
      ),
    );
  }

  void getDownloadInfo() async {
    controller.getDownloadInfo().then((value) => {
          if (value["ready"].length > 0)
            {
              downloadInfo_ready.value = value["ready"],
            },
          if (value["success"].length > 0)
            {
              downloadInfo_success.value = value["success"],
            },
          if (value["error"].length > 0)
            {
              downloadInfo_error.value = value["error"],
            },
          if (value["run"].length > 0)
            {
              downloadInfo_run.value = value["run"],
            }
        });
    Timer.periodic(timeout, (timer) async {
      getDownloadInfo();
    });
  }

  Widget _buildownloadListItemReady(BuildContext context, int index) {
    return SizedBox(
      child: FLListTile(
        isThreeLine: true,
        backgroundColor: Colors.transparent,
        title: Text(
          downloadInfo_ready.value[index]["musicname"],
          style: TextStyle(
              color: ColorAndStyle.textColor, fontSize: size!.height * 0.028),
        ),
        subtitle: Align(
            child: Text(
              downloadInfo_ready.value[index]["artistname"],
              style: ColorAndStyle.textStyle,
            ),
            alignment: FractionalOffset.topLeft),
        trailing: GFLoader(
          loaderColorOne: Colors.yellow,
        ),
      ),
    );
  }

  Widget _buildownloadListItemSuccess(BuildContext context, int index) {
    return SizedBox(
      child: FLListTile(
        isThreeLine: true,
        backgroundColor: Colors.transparent,
        title: Text(
          downloadInfo_success.value[index]["musicname"],
          style: TextStyle(
              color: ColorAndStyle.textColor, fontSize: size!.height * 0.028),
        ),
        subtitle: Align(
            child: Text(
              downloadInfo_success.value[index]["artistname"],
              style: ColorAndStyle.textStyle,
            ),
            alignment: FractionalOffset.topLeft),
        trailing: Icon(Icons.check, color: Colors.green),
      ),
    );
  }

  Widget _buildownloadListItemError(BuildContext context, int index) {
    return SizedBox(
      child: FLListTile(
        isThreeLine: true,
        backgroundColor: Colors.transparent,
        title: Text(
          downloadInfo_error.value[index]["musicname"],
          style: TextStyle(
              color: ColorAndStyle.textColor, fontSize: size!.height * 0.028),
        ),
        subtitle: Align(
          child: Text(
            downloadInfo_error.value[index]["artistname"],
            style: ColorAndStyle.textStyle,
          ),
          alignment: FractionalOffset.topLeft,
        ),
        trailing: Icon(Icons.error_outline, color: Colors.red),
      ),
    );
  }

  Widget _buildownloadListItemRun(BuildContext context, int index) {
    return SizedBox(
      child: FLListTile(
        isThreeLine: true,
        backgroundColor: Colors.transparent,
        title: Text(
          downloadInfo_run.value[index]["musicname"],
          style: TextStyle(
              color: ColorAndStyle.textColor, fontSize: size!.height * 0.028),
        ),
        subtitle: Align(
            child: Text(
              downloadInfo_run.value[index]["artistname"],
              style: ColorAndStyle.textStyle,
            ),
            alignment: FractionalOffset.topLeft),
        trailing: GFLoader(
          loaderColorOne: Colors.green,
        ),
      ),
    );
  }
}
