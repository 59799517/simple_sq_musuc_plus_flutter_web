import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:simple_sq_music_plus_flutter_web/config/ColorAndStyle.dart';
import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/StorageUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/utils/ToastUtils.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/FLListTile.dart';
import 'package:simple_sq_music_plus_flutter_web/widget/MainAppBar.dart';

class IndexPage extends StatefulWidget {
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    var read = StorageUtils.get("type");
    types= convert.jsonDecode(read);
    for (var o in types) {
      var keys = o.keys.toList();
      typesname.add(keys[0]);
    }
    selectedtypeValue = typesname[0];
    selectedtypeValue_child="单曲";
    var opensubsonicstr = StorageUtils.get("set_plug.subsonic.start");
    var opensubsonic = convert.jsonDecode(opensubsonicstr);
    if(opensubsonic["configValue"]=='true'){
      if(convert.jsonDecode(StorageUtils.get("set_plug.subsonic.sync.dir"))['configValue']=="true"){
        var playListNameStr = StorageUtils.get("set_plug.subsonic.default.playListName");
        playListName = convert.jsonDecode(playListNameStr)['configValue'];
      }
    }


  }
 List<dynamic>  types =[] ;
  //当前选择的搜索类型列表
  var typesname =[] ;
  //
  // var typesname_child =  [
  //   {"text": '单曲', "value": 0},
  //   {"text": '全部专辑', "value": 1},
  //   {"text": '单专辑', "value": 2},
  //   {"text": '所有歌曲（包括专辑）', "value": 3},
  // ];
  var typesname_child_name =["单曲","根据歌手搜索专辑","单专辑（专辑名称）","所有歌曲（包括专辑）"] ;
  int typesname_child_valie=0;
  var selectedtypeValue_child ;
  //listview的控制器
  ScrollController _scrollController = ScrollController();
  //请求控制器
  MainController controller = Get.find<MainController>();
  var _searchValue = "".obs;
  //搜搜索完成信息
  var musicList = [].obs ;
  // 当前选择的搜索类型（平台）
  var selectedtypeValue ;
  //默认的加入歌单名称
  String playListName ="" ;
  Size? size;
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {


    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorAndStyle.backgroundColor,
      key: _scaffoldkey,
      drawer: MainAppBar.getDrawer(_scaffoldkey),
      appBar: MainAppBar.getAppBar(_scaffoldkey,title: playListName ==""? "Search":"Search -- 已自动添加到 ${playListName} 歌单中"),
      body:Container(
          alignment: Alignment.topLeft,
          // width: size!.width,
          // height: size!.height,
          // color: Colors.amber,
          child: Column(
            children: [
              Expanded(
                flex: 2,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
              // width:50,
                    child: Expanded(
                      flex: 4,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              // Icon(
                              //   Icons.list,
                              //   size: 16,
                              //   color: Colors.yellow,
                              // ),
                              // SizedBox(
                              //   width: 4,
                              // ),
                              Expanded(
                                child: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: typesname
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                // fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: selectedtypeValue,
                          onChanged: (value) {
                            setState(() {
                              selectedtypeValue = value as String;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            // height: 50,
                            // width: 160,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              // border: Border.all(
                              //   color: Colors.black26,
                              // ),
                              color: ColorAndStyle.backgroundColor,
                            ),
                            elevation: 2,
                              overlayColor: MaterialStateProperty.all(Colors.black26)
                          ),
                          // iconStyleData: const IconStyleData(
                          //   icon: Icon(
                          //     Icons.arrow_forward_ios_outlined,
                          //   ),
                          //   iconSize: 14,
                          //   iconEnabledColor: Colors.yellow,
                          //   iconDisabledColor: Colors.grey,
                          // ),
                          dropdownStyleData: DropdownStyleData(
                              // maxHeight: 200,
                              // width: 200,
                              padding: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.transparent,
                              ),
                              elevation: 8,
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility: MaterialStateProperty.all(true),
                              )),
                          menuItemStyleData: const MenuItemStyleData(
                            // height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        )

                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              // Icon(
                              //   Icons.list,
                              //   size: 16,
                              //   color: Colors.yellow,
                              // ),
                              // SizedBox(
                              //   width: 4,
                              // ),
                              Expanded(
                                child: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: typesname_child_name
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                // fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: selectedtypeValue_child,
                          onChanged: (value) {
                            setState(() {
                              selectedtypeValue_child = value as String;
                              if(selectedtypeValue_child=="单曲"){
                                typesname_child_valie=0;
                              }else if(selectedtypeValue_child=="根据歌手搜索专辑"){
                                typesname_child_valie=1;
                              }else if(selectedtypeValue_child=="单专辑（专辑名称）"){
                                typesname_child_valie=2;
                              }else if(selectedtypeValue_child=="所有歌曲（包括专辑）"){
                                typesname_child_valie=3;
                              }
                              musicList.value=[];

                            });
                          },
                          buttonStyleData: ButtonStyleData(
                              // height: 50,
                              // width: 160,
                              padding: const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                // border: Border.all(
                                //   color: Colors.black26,
                                // ),
                                color: ColorAndStyle.backgroundColor,
                              ),
                              elevation: 2,
                              overlayColor: MaterialStateProperty.all(Colors.black26)
                          ),
                          // iconStyleData: const IconStyleData(
                          //   icon: Icon(
                          //     Icons.arrow_forward_ios_outlined,
                          //   ),
                          //   iconSize: 14,
                          //   iconEnabledColor: Colors.yellow,
                          //   iconDisabledColor: Colors.grey,
                          // ),
                          dropdownStyleData: DropdownStyleData(
                              // maxHeight: 200,
                              // width: 200,
                              padding: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.transparent,
                              ),
                              elevation: 8,
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility: MaterialStateProperty.all(true),
                              )),
                          menuItemStyleData: const MenuItemStyleData(
                            // height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        )

                    ),
                  ),
                  // Expanded(
                  //   flex: 3,
                  //   child: GFButton(
                  //     onPressed: () {
                  //       getSongList( _searchValue.value);
                  //     },
                  //     text: "搜索",
                  //     shape: GFButtonShape.square,
                  //     type: GFButtonType.outline,
                  //   ),
                  // )
                ],
              ),),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(),
                    // ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "  搜索:",
                        style: TextStyle(
                            color: ColorAndStyle.textColor, fontSize: 16,fontWeight: FontWeight.bold,),
                      ),
                    ),

                    Expanded(
                      flex: 9,
                      child: Container(
                        child: TextField(
                          cursorColor: Colors.white,
                          style: ColorAndStyle.textStyle,
                          decoration: InputDecoration(
                            hintStyle: ColorAndStyle.textStyle,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorAndStyle.textColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorAndStyle.secondaryColor),
                            ),
                          ),
                          onChanged: (value){
                            _searchValue.value =value;
                          },
                          onSubmitted: (value) {
                            _searchValue.value =value;
                            if(0==typesname_child_valie){
                              getSongList(value);
                            }else if(1==typesname_child_valie){
                              getSearchArtist(value);
                            }
                            else if(2==typesname_child_valie){
                              getSearchAlbum(value);
                            }
                            else if(3==typesname_child_valie){
                              getSearchArtist(value);
                            }else{
                              ToastUtils.showToast("请选择类型",textColor: Colors.amberAccent);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GFButton(
                        onPressed: () {
                          if(0==typesname_child_valie){
                            getSongList(_searchValue.value);
                          }else if(1==typesname_child_valie){
                            getSearchArtist(_searchValue.value);
                          }
                          else if(2==typesname_child_valie){
                            getSearchAlbum(_searchValue.value);
                          }
                          else if(3==typesname_child_valie){
                            getSearchArtist(_searchValue.value);
                          }else{
                            ToastUtils.showToast("请选择类型",textColor: Colors.amberAccent);
                          }


                          // getSongList( _searchValue.value);
                        },
                        text: "搜索",
                        shape: GFButtonShape.square,
                        type: GFButtonType.outline,
                        // blockButton: true,
                        // fullWidthButton: true,
                        highlightElevation: 0.0,
                        focusElevation :10.0,
                        hoverElevation : 6.0,
                        padding:EdgeInsets.symmetric(horizontal: 30),
                        size: GFSize.SMALL,
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(),
                    // ),
                  ],
                ),
              ),

              Expanded(flex: 13,child: Container(
                // height: size!.height*0.3,
                // width: size!.width,
                color: Colors.transparent,
                child:  Obx(() => ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildListItem(context, index),
                  itemCount: musicList.value.length,
                )),
              ),)

            ],
          ))
      );
  }


  /**
   * 单曲 部分
   */
  void getSongList(String searchValue){
  String searchType ="";
    for (var o in types) {
      var keys = o.keys.toList();
      if(keys[0]==selectedtypeValue){
        searchType =o[selectedtypeValue];
        break;
      }
    }
    controller.search(searchValue,searchType).then((value) => {

      musicList.value=value['records']
    });
  }



  void songDownloadToServer(String id,String searchType){
    controller.songDownloadToServer(id,playListName,searchType).then((value) => {
      if(value){
        ToastUtils.showToast("添加成功")
      }else{
        ToastUtils.showToast("添加失败",textColor: Colors.amberAccent)
      }
    });
  }
  /**
   * 构建LIst 单曲--结束
   */
  Widget _buildListItem(BuildContext context, int index) {

    if(0==typesname_child_valie){
      try {
        return Container(
                child: GFListTile(
                  // isThreeLine: true,
                  color: Colors.transparent,
                  avatar: musicList.value[index]["pic"]!=null&&musicList.value[index]["pic"]!=""?GFImageOverlay(
                    height: 100,
                    width: 100,
                    shape: BoxShape.circle,
                    image:NetworkImage(musicList.value[index]["pic"]),
                    boxFit: BoxFit.cover,
                  ):Container(),
                  title: Text(
                    musicList.value[index]["name"]!=null? musicList.value[index]["name"]:"无",
                    style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
                  ),
                  subTitle: Align(
                      child:  Text(
                        musicList.value[index]["artistName"]!=null? musicList.value[index]["artistName"]:"无",
                        style: ColorAndStyle.textStyle,
                      ),
                      alignment: FractionalOffset.topLeft
                  ),
                  icon: IconButton(icon: Icon(Icons.add,color: ColorAndStyle.textColor,),onPressed: () async{
                    songDownloadToServer(musicList.value[index]["id"],musicList.value[index]["searchType"]);
                  },),
                ),
              );
      } catch (e) {
    print("错误:"+e.toString());
        print(musicList.value[index]);
        return Container();
      }

    // return FLListTile(
    //   isThreeLine: true,
    //   backgroundColor: Colors.transparent,
    //   leading: CircleAvatar(
    //     backgroundImage: NetworkImage("https://mcontent.migu.cn/newlv2/new/artist/20230130/1106611139/s_Ixa9PTgXaz7dbmBq.jpg"),
    //   ),
    //   title: Text(
    //     "恋曲1990伴奏",
    //     style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
    //   ),
    //   subtitle: Align(
    //       child:  Text(
    //         "穿越太平洋",
    //         style: ColorAndStyle.textStyle,
    //       ),
    //       alignment: FractionalOffset.topLeft
    //   ),
    //   trailing: IconButton(icon: Icon(Icons.add,color: ColorAndStyle.textColor,),onPressed: () async{
    //     songDownloadToServer("6903170A4W9","mg");
    //   },),
    // );


    }else if(1==typesname_child_valie){
      return Container(
        child: FLListTile(
          isThreeLine: true,
          backgroundColor: Colors.transparent,
          leading: musicList.value[index]["pic"]!=null&&musicList.value[index]["pic"]!=""?GFImageOverlay(
            height: 100,
            width: 100,
            shape: BoxShape.circle,
            image:NetworkImage(musicList.value[index]["pic"]),
            boxFit: BoxFit.cover,
          ):Container(),
          title: Text(
            musicList.value[index]["artistName"],
            style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
          ),
          subtitle: Align(
              child:  Text(
                "共计：${musicList.value[index]["total"]}张专辑",
                style: ColorAndStyle.textStyle,
              ),
              alignment: FractionalOffset.topLeft
          ),
          trailing: IconButton(icon: Icon(Icons.add,color: ColorAndStyle.textColor,),onPressed: () async{
            artistDownloadToServer(musicList.value[index]["artistid"],musicList.value[index]["searchType"]);
          },),
        ),
      );

    }else if(2==typesname_child_valie){
      return Container(
        child: FLListTile(
          isThreeLine: true,
          backgroundColor: Colors.transparent,
          leading: musicList.value[index]["pic"]!=null&&musicList.value[index]["pic"]!=""?GFImageOverlay(
            height: 100,
            width: 100,
            shape: BoxShape.circle,
            image:NetworkImage(musicList.value[index]["pic"]),
            boxFit: BoxFit.cover,
          ):Container(),
          title: Text(
            musicList.value[index]["albumName"],
            style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
          ),
          subtitle: Align(
              child:  Text(
                musicList.value[index]["artistName"],
                style: ColorAndStyle.textStyle,
              ),
              alignment: FractionalOffset.topLeft
          ),
          trailing: IconButton(icon: Icon(Icons.add,color: ColorAndStyle.textColor,),onPressed: () async{
            AlbumDownloadToServer(musicList.value[index]["artistid"],musicList.value[index]["searchType"]);
          },),
        ),
      );

    }else if(3==typesname_child_valie){
      return Container(
        child: FLListTile(
          isThreeLine: true,
          backgroundColor: Colors.transparent,
          leading: musicList.value[index]["pic"]!=null&&musicList.value[index]["pic"]!=""?GFImageOverlay(
            height: 100,
            width: 100,
            shape: BoxShape.circle,
            image:NetworkImage(musicList.value[index]["pic"]),
            boxFit: BoxFit.cover,
          ):Container(),
          title: Text(
            musicList.value[index]["artistName"]
           ,
            style: TextStyle(color: ColorAndStyle.textColor,fontSize: size!.height*0.028),
          ),
          subtitle: Align(
              child:  Text(
                "共计：${musicList.value[index]["total"]}首歌曲",
                style: ColorAndStyle.textStyle,
              ),
              alignment: FractionalOffset.topLeft
          ),
          trailing: IconButton(icon: Icon(Icons.add,color: ColorAndStyle.textColor,),onPressed: () async{
            ArtistALLDownloadToServer(musicList.value[index]["artistid"],musicList.value[index]["searchType"]);
          },),
        ),
      );

    }

    else{
      return Container();
    }



  }


  void getSearchArtist(String searchValue){
    String searchType ="";
    for (var o in types) {
      var keys = o.keys.toList();
      if(keys[0]==selectedtypeValue){
        searchType =o[selectedtypeValue];
        break;
      }
    }
    controller.searchArtist(searchValue,searchType).then((value) => {
      musicList.value=value['records']
    });
  }

  void getSearchAlbum(String searchValue){
    String searchType ="";
    for (var o in types) {
      var keys = o.keys.toList();
      if(keys[0]==selectedtypeValue){
        searchType =o[selectedtypeValue];
        break;
      }
    }
    controller.searchAlbum(searchValue,searchType).then((value) => {
      musicList.value=value['records']
    });
  }
  void artistDownloadToServer(String id,String searchType){
    controller.ArtistDownloadToServer(id,playListName,searchType).then((value) => {
      if(value){
        ToastUtils.showToast("添加成功")
      }else{
        ToastUtils.showToast("添加失败",textColor: Colors.amberAccent)
      }
    });
  }
  void AlbumDownloadToServer(String id,String searchType){
    controller.AlbumDownloadToServer(id,playListName,searchType).then((value) => {
      if(value){
        ToastUtils.showToast("添加成功")
      }else{
        ToastUtils.showToast("添加失败",textColor: Colors.amberAccent)
      }
    });
  }
void ArtistALLDownloadToServer(String id,String searchType){
    controller.ArtistALLDownloadToServer(id,playListName,searchType).then((value) => {
      if(value){
        ToastUtils.showToast("添加成功")
      }else{
        ToastUtils.showToast("添加失败",textColor: Colors.amberAccent)
      }
    });
}

}
