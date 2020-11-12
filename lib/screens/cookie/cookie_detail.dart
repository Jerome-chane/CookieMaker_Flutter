import 'package:cookie_maker/models/Data.dart';
import 'package:cookie_maker/models/Device.dart';
import 'package:flutter/material.dart';

class CookieDetail extends StatelessWidget {
  final Cookie cookie;
  CookieDetail({Key key, @required this.cookie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Cookie Detail"),
          backgroundColor: Colors.brown[500],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Device.height * 0.09,
                    child: Text("Id: "),
                  ),
                  Container(
                    height: Device.height * 0.09,
                    child: Text(cookie.id),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Device.height * 0.09,
                    child: Text("recipeId:"),
                  ),
                  Container(
                    height: Device.height * 0.09,
                    child: Text(cookie.recipeId),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Device.height * 0.09,
                    child: Text("startTime:"),
                  ),
                  Container(
                    height: Device.height * 0.09,
                    child: Text(cookie.startTime),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Device.height * 0.09,
                    child: Text("endTime:"),
                  ),
                  Container(
                    height: Device.height * 0.09,
                    child: Text(cookie.endTime),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Device.height * 0.09,
                    child: Text("cookingDuration:"),
                  ),
                  Container(
                    height: Device.height * 0.09,
                    child: Text(cookie.cookingDuration),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Device.height * 0.09,
                    child: Text("shipped:"),
                  ),
                  Container(
                    height: Device.height * 0.09,
                    child: Text(cookie.shipped.toString()),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
