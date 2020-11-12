import 'package:cookie_maker/models/Alert.dart';
import 'package:cookie_maker/models/Device.dart';
import 'package:cookie_maker/models/Loading.dart';
import 'package:cookie_maker/screens/cookie/cookie_view.dart';
import 'package:cookie_maker/screens/cookie/create_cookie.dart';
import 'package:flutter/material.dart';
import 'package:cookie_maker/services/cookie_service.dart';

class CookieDashboard extends StatefulWidget {
  @override
  _CookieDashboardState createState() => _CookieDashboardState();
}

class _CookieDashboardState extends State<CookieDashboard> {
  final CookieService _cookieService = CookieService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Cookie Dashboard"),
        backgroundColor: Colors.brown[500],
      ),
      body: loading
          ? Loading()
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/cookie2.jpg"), fit: BoxFit.cover),
              ),
              child: Center(
                child: ListView(
                  padding: const EdgeInsets.all(30),
                  children: <Widget>[
                    ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: 200.0,
                      height: Device.height * 0.15,
                      buttonColor: Colors.green[300],
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateCookie()));
                        },
                        child: Text("Create new Cookie"),
                      ),
                    ),
                    SizedBox(
                        height: Device.portrait
                            ? Device.height * 0.05
                            : Device.height * 0.1),
                    ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: 200.0,
                      height: Device.height * 0.15,
                      buttonColor: Colors.blue[300],
                      child: RaisedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await _cookieService.getCookies().then((value) {
                            setState(() {
                              loading = false;
                            });

                            if (value != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CookieView(
                                            cookies: value,
                                            title: "All Cookies",
                                          )));
                            } else {
                              showAlertDialog(
                                  context, "Oops", "No cookies were found");
                            }
                          });
                        },
                        child: Text("See all the Cookies"),
                      ),
                    ),
                    SizedBox(
                        height: Device.portrait
                            ? Device.height * 0.05
                            : Device.height * 0.1),
                    ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: 200.0,
                      height: Device.height * 0.15,
                      buttonColor: Colors.orange[300],
                      child: RaisedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          await _cookieService
                              .getShippedCookies()
                              .then((value) {
                            setState(() {
                              loading = false;
                            });

                            if (value != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CookieView(
                                          cookies: value,
                                          title: "Shipped Cookies")));
                            } else {
                              showAlertDialog(
                                  context, "Oops", "No cookies were found");
                            }
                          });
                        },
                        child: Text("See shipped Cookies"),
                      ),
                    ),
                    SizedBox(
                        height: Device.portrait
                            ? Device.height * 0.05
                            : Device.height * 0.1),
                    ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: 200.0,
                      height: Device.height * 0.15,
                      buttonColor: Colors.yellow[300],
                      child: RaisedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          await _cookieService
                              .getNonShippedCookies()
                              .then((value) {
                            setState(() {
                              loading = false;
                            });

                            if (value != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CookieView(
                                          cookies: value,
                                          title: "Non shipped cookies")));
                            } else {
                              showAlertDialog(
                                  context, "Oops", "No cookies were found");
                            }
                          });
                        },
                        child: Text("See non shipped cookies"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
