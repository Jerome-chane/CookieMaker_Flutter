import 'package:flutter/widgets.dart';
import 'dart:io' show Platform;

class Device {
  static double width;
  static double height;
  static bool portrait;
  static bool isIOS;

  void init(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    portrait = orientation == Orientation.portrait;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    isIOS = Platform.isIOS;
  }
}
