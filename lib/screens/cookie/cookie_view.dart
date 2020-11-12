import 'package:cookie_maker/screens/cookie/cookie_detail.dart';
import 'package:flutter/material.dart';

class CookieView extends StatefulWidget {
  final List<dynamic> cookies;
  final String title;
  CookieView({Key key, @required this.cookies, this.title}) : super(key: key);

  @override
  _CookieViewState createState() => _CookieViewState();
}

class _CookieViewState extends State<CookieView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(widget.title),
          backgroundColor: Colors.brown[500]),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/cookie2.jpg"), fit: BoxFit.cover),
        ),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.cookies.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.brown[200],
                      borderRadius: BorderRadius.circular(18.0)),
                  height: 50,
                  margin: EdgeInsets.all(5),
                  child: Center(
                      child: Text(
                    '${widget.cookies[index].id}',
                    style: TextStyle(fontSize: 18),
                  )),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CookieDetail(
                                cookie: widget.cookies[index],
                              )));
                },
              );
            }),
      ),
    );
  }
}
