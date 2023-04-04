// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getwidget/components/button/gf_button.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:simple_sq_music_plus_flutter_web/config/ColorAndStyle.dart';
// import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';
// import 'package:simple_sq_music_plus_flutter_web/utils/ToastUtils.dart';
// import 'package:simple_sq_music_plus_flutter_web/widget/FLListTile.dart';
// import 'package:tab_container/tab_container.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Size? size;
//
//   MainController controller = Get.find<MainController>();
//   //listview的控制器
//   ScrollController _scrollController = ScrollController();
//   var _searchValue = "".obs;
//
//   //信息
//   var musicList = [].obs ;
//   var downloadInfo_ready = [].obs ;
//   var downloadInfo_success = [].obs ;
//   var downloadInfo_error = [].obs ;
//   var downloadInfo_run = [].obs ;
//   //定时刷新下载任务时间
//   var timeout = const Duration(seconds: 30);
//
//
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () {
//       getDownloadInfo();
//     });
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Color(0XFF242424),
//       body:  Container(
//         height: size!.height,
//         alignment: Alignment.topLeft,
//         child: TabContainer(
//           color: Colors.white10,
//           children: [
//             Container(
//                 alignment: Alignment.topLeft,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 1,child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Text(
//                             "搜索:",
//                             style: TextStyle(
//                                 color: ColorAndStyle.textColor, fontSize: 20),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 9,
//                           child: Container(
//                             child: TextField(
//                               cursorColor: Colors.white,
//                               style: ColorAndStyle.textStyle,
//                               decoration: InputDecoration(
//                                 hintStyle: ColorAndStyle.textStyle,
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: ColorAndStyle.textColor),
//                                 ),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: ColorAndStyle.secondaryColor),
//                                 ),
//                               ),
//                               onChanged: (value){
//                                 _searchValue.value =value;
//                               },
//                               onSubmitted: (value) {
//                                 _searchValue.value =value;
//                                 getSongList(value);
//                               },
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Container(),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: GFButton(
//                             onPressed: () {
//                               getSongList( _searchValue.value);
//                             },
//                             text: "搜索",
//                             shape: GFButtonShape.square,
//                             type: GFButtonType.outline,
//                           ),
//                         )
//                       ],
//                     ),),
//                     Expanded(flex: 10,child: Container(
//                       color: Colors.transparent,
//                       child:  Obx(() => ListView.builder(
//                         controller: _scrollController,
//                         itemBuilder: (BuildContext context, int index) =>
//                             _buildListItem(context, index),
//                         itemCount: musicList.value.length,
//                       )),
//                     ),)
//
//                   ],
//                 )),
//             Container(
//               height: size!.height*0.98,
//               width: size!.width*0.98,
//               child:CupertinoScrollbar(
//                 child: Column(
//                   children: [
//                     Obx(() => downloadInfo_success.value.length>0?Container(
//
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: ListView.builder(
//                           itemBuilder: (BuildContext context, int index) =>
//                               _buildownloadListItemSuccess(context,index),
//                           itemCount: downloadInfo_success.value.length,
//                         ),
//                       ),
//                     ):Container(child: Text("暂无",style: ColorAndStyle.textStyle,))),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               child: Text('Child 3'),
//             ),
//             Container(
//               child: Text('Child 4'),
//             ),
//           ],
//           isStringTabs: false,
//           tabs: [
//             Text(
//               '搜索',
//               style: ColorAndStyle.textStyle,
//             ),
//             Text(
//               '下载管理',
//               style: ColorAndStyle.textStyle,
//             ),
//             Text(
//               '歌单下载',
//               style: ColorAndStyle.textStyle,
//             ),
//             Text(
//               '全局设置',
//               style: ColorAndStyle.textStyle,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//   void getSongList(String searchValue){
//     controller.search(searchValue).then((value) => {
//         musicList.value=value["abslist"]
//     });
//   }
//   void songDownloadToServer(String id,{String addplayListName="SqMusic"}){
//     id = id.replaceAll("MUSIC_","");
//     controller.songDownloadToServer(id,br: "2000",subsonicPlayListName:addplayListName).then((value) => {
//       if(value){
//         ToastUtils.showToast("添加成功")
//       }else{
//         ToastUtils.showToast("添加失败",textColor: Colors.amberAccent)
//       }
//     });
//   }
//
//   void getDownloadInfo() async{
//     controller.getDownloadInfo().then((value) =>
//     {
//       if(value["ready"].length>0){
//         downloadInfo_ready.value = value["ready"],
//       },
//       if(value["success"].length>0){
//         downloadInfo_success.value = value["success"],
//       },
//       if(value["error"].length>0){
//         downloadInfo_error.value = value["error"],
//       },
//       if(value["run"].length>0){
//         downloadInfo_run.value = value["run"],
//       }
//
//     });
//     Timer.periodic(timeout, (timer) async{
//       getDownloadInfo();
//     });
//   }
//
//   /**
//    * 构建LIst
//    */
//   Widget _buildListItem(BuildContext context, int index) {
//     return SizedBox(
//       child: FLListTile(
//         isThreeLine: true,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           musicList.value[index]["SONGNAME"],
//           style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
//         ),
//         subtitle: Align(
//             child:  Text(
//               musicList.value[index]["ARTIST"],
//               style: ColorAndStyle.textStyle,
//             ),
//             alignment: FractionalOffset.topLeft
//         ),
//         trailing: IconButton(icon: Icon(Icons.add,color: ColorAndStyle.textColor,),onPressed: () async{
//           songDownloadToServer(musicList.value[index]["MUSICRID"]);
//         },),
//       ),
//     );
//   }
//   Widget _buildownloadListItemReady(BuildContext context, int index) {
//     return SizedBox(
//       child: FLListTile(
//         isThreeLine: true,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           downloadInfo_ready.value[index]["musicname"],
//           style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
//         ),
//         subtitle: Align(
//             child:  Text(
//               downloadInfo_ready.value[index]["artistname"],
//               style: ColorAndStyle.textStyle,
//             ),
//             alignment: FractionalOffset.topLeft
//         ),
//       ),
//     );
//   }
//   Widget _buildownloadListItemSuccess(BuildContext context, int index) {
//     return SizedBox(
//       height: size!.height*0.06,
//       width: size!.width*0.98,
//       child: FLListTile(
//         isThreeLine: true,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           downloadInfo_success.value[index]["musicname"],
//           style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
//         ),
//         subtitle: Align(
//             child:  Text(
//               downloadInfo_success.value[index]["artistname"],
//               style: ColorAndStyle.textStyle,
//             ),
//             alignment: FractionalOffset.topLeft
//         ),
//       ),
//     );
//   }
//   Widget _buildownloadListItemError(BuildContext context, int index) {
//     return SizedBox(
//       child: FLListTile(
//         isThreeLine: true,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           downloadInfo_error.value[index]["musicname"],
//           style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
//         ),
//         subtitle: Align(
//             child:  Text(
//               downloadInfo_error.value[index]["artistname"],
//               style: ColorAndStyle.textStyle,
//             ),
//             alignment: FractionalOffset.topLeft
//         ),
//       ),
//     );
//   }
//   Widget _buildownloadListItemRun(BuildContext context, int index) {
//     return SizedBox(
//       child: FLListTile(
//         isThreeLine: true,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           downloadInfo_run.value[index]["musicname"],
//           style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
//         ),
//         subtitle: Align(
//             child:  Text(
//               downloadInfo_run.value[index]["artistname"],
//               style: ColorAndStyle.textStyle,
//             ),
//             alignment: FractionalOffset.topLeft
//         ),
//       ),
//     );
//   }
//
//
// }
