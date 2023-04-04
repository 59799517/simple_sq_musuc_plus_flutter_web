import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:simple_sq_music_plus_flutter_web/controller/MainController.dart';

class ControllerInjec extends GetxController {
  injec(){
    Get.put(MainController(),permanent: true);
  }
}