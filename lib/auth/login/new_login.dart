import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './form_card.dart';

class NewLoginPage extends StatefulWidget {
  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: ScreenUtil.getInstance().setHeight(800),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.deepPurple, Colors.cyanAccent]),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Container(
                    height: ScreenUtil.getInstance().setHeight(200),
                    width: ScreenUtil.getInstance().setHeight(200),
                    alignment: Alignment(0, -0.4),
                    child: CircleAvatar(
                      child: Icon(Icons.date_range,
                          size: ScreenUtil.getInstance().setSp(90)),
                      backgroundColor: Colors.white,
                      radius: ScreenUtil.getInstance().setSp(90),
                    ),
                  )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(120),
              ),
              FormCard(),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(40),
              ),
              InkWell(
                onTap: () {
                  print('taped on login button');
                },
                child: Container(
                  width: ScreenUtil.getInstance().setWidth(300),
                  height: ScreenUtil.getInstance().setHeight(140),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.deepPurple, Colors.cyanAccent]),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  alignment: Alignment.center,
                  child: Text('Log In',
                      style: TextStyle(
                          fontFamily: "Popins-Bold",
                          fontWeight: FontWeight.w900,
                          fontSize: ScreenUtil.getInstance().setSp(50),
                          color: Colors.white)),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(40),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: ScreenUtil.getInstance().setSp(150),
                left: ScreenUtil.getInstance().setSp(150)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Sign Up ",
                    style: TextStyle(
                        fontFamily: "Popins-Bold",
                        fontSize: ScreenUtil.getInstance().setSp(45),
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: ScreenUtil.getInstance().setSp(150),
                right: ScreenUtil.getInstance().setSp(150)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Text(
                    "   Forgot Password ? ",
                    style: TextStyle(
                        fontFamily: "Popins-Bold",
                        fontSize: ScreenUtil.getInstance().setSp(45),
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
