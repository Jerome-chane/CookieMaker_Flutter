import 'package:cookie_maker/screens/home.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
//

void main() {
  runApp(MyApp());
}
// DevicePreview(
//   enabled: !kReleaseMode,
//   builder: (context) => MyApp(),
// ),

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: DevicePreview.of(context).locale, // <--- /!\ Add the locale
      // builder: DevicePreview.appBuilder, // <--- /!\ Add the builder
      title: 'Cookie Maker',
      home: Home(
        title: 'Cookie Maker',
      ),
    );
  }
}
