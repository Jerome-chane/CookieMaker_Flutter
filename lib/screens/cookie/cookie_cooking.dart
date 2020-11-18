import 'dart:async';
import 'package:cookie_maker/models/Confettis.dart';
import 'package:cookie_maker/models/Device.dart';
import 'package:cookie_maker/models/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class CookieCooking extends StatefulWidget {
  final Stream receivedStream;
  CookieCooking({this.receivedStream});

  @override
  _CookieCookingState createState() => _CookieCookingState();
}

class _CookieCookingState extends State<CookieCooking> {
  ConfettiController _controllerCenterRight;
  bool done = false;
  dynamic data;
  StreamSubscription<dynamic> stream;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 1));

    stream = widget.receivedStream.listen(
      (value) {
        setState(() {
          data = value;
          progress = (value[3] / 100).toDouble();
        });
        print(
            "COOKIE #${value[1].toString()} Status: ${value[2].toString()}  PROGRESS ${value[3].toString()}");
        if (value[2].toString() == "Cooking finished !") {
          setState(() {
            done = true;
          });
          // _controllerCenterRight.play();
        }
      },
    );
  }

  void dispose() {
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    _onBackPressed() {
      Navigator.of(context).pop();
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Cooking the Cookie"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.brown[500],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: ListView(
              padding: EdgeInsets.only(
                  top: Device.portrait ? Device.height * 0.1 : 0),
              children: [
                Container(
                  width: Device.portrait
                      ? Device.width * 0.85
                      : Device.width * 0.45,
                  height: Device.portrait
                      ? Device.height * 0.35
                      : Device.height * 0.5,
                  child: Center(
                    child: done
                        ? Image.asset("assets/eat.gif")
                        : Image.asset("assets/cooking.gif"),
                  ),
                ),
                Confettis(controllerCenterRight: _controllerCenterRight),
                SizedBox(
                  height: Device.portrait
                      ? Device.height * 0.1
                      : Device.height * 0.05,
                ),
                ProgressBar(progress: progress, data: data),
                SizedBox(height: Device.height * 0.04),
                Center(
                  child: StreamBuilder(
                    stream: widget.receivedStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Loading...",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[500]));
                      }
                      return Text(
                        done
                            ? "Cooking finished!"
                            : "COOKIE #${snapshot.data[1].toString()}: ${snapshot.data[2].toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[500]),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Device.height * 0.02,
                ),
                Center(
                    child: !done
                        ? Container()
                        : RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"),
                          )),
              ],
            ),
          ),
        ));
  }
}
