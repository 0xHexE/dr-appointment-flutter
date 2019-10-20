
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {

  @override
  Widget build(BuildContext context) {
    return (
        Container(
            width: double.infinity,
            height: ScreenUtil.getInstance().setHeight(800),
            padding: EdgeInsets.all(24),
            margin: EdgeInsets.all(24),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 15.0),
                      blurRadius: 15.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -10.0),
                      blurRadius: 10.0),
                ]
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Text("Login",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(54),
                          fontFamily: "Popins-Bold",
                          letterSpacing: 0.6
                      ),),
                  ),
                  Padding(
                      child: Text("Username",
                          style: TextStyle(
                              fontFamily: "Popins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(45)
                          )),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0)
                  ),
                  Padding(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
                  ),
                  Padding(
                      child: Text("Password",
                          style: TextStyle(
                              fontFamily: "Popins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(45)
                          )),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0)
                  ),
                  Padding(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0)
                  )
                ],
              ),
            )
        )
    );
  }
}