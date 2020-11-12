import 'package:cookie_maker/models/Device.dart';
import 'package:cookie_maker/screens/cookie/cookie_dashboard.dart';
import 'package:cookie_maker/screens/recipe/recipe_dashboard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: Colors.brown[500],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/cookie.jpg"), fit: BoxFit.cover),
          ),
          child: Flex(
            direction: Device.portrait ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CookieDashboard()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.brown[300],
                        borderRadius: BorderRadius.circular(18.0)),
                    width: Device.portrait
                        ? Device.width * 0.85
                        : Device.width * 0.45,
                    height: Device.portrait
                        ? Device.height * 0.3
                        : Device.height * 0.6,
                    child: Center(
                      child: Text('Cookie Dashboard'),
                    ),
                  ),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeDashboard()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(18.0)),
                    width: Device.portrait
                        ? Device.width * 0.85
                        : Device.width * 0.45,
                    height: Device.portrait
                        ? Device.height * 0.3
                        : Device.height * 0.6,
                    child: Center(child: Text('Recipe Dashboard')),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
