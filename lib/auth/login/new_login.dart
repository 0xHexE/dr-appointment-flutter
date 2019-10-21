
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                        width: ScreenUtil.getInstance().setWidth(200),
                        height: ScreenUtil.getInstance().setHeight(230),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.cyan,
                                Colors.deepPurple
                              ],
                            )
                        ),
                        child: Icon(Icons.date_range,
                          size: ScreenUtil.getInstance().setSp(120),
                          color: Colors.white,
                        )
                    ),
                    Container(
                      width: ScreenUtil.getInstance().setWidth(double.infinity),
                      height: ScreenUtil.getInstance().setHeight(900),

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setSp(24))),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 24,
                                color: Colors.black12
                            )
                          ]
                      ),

                      margin: EdgeInsets.all(ScreenUtil.getInstance().setSp(70)),
                      padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(60)),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: ScreenUtil.getInstance().setSp(40)),
                            child: Text('Login',
                                style: TextStyle(
                                    fontFamily: "Popins-Bold",
                                    fontSize: ScreenUtil.getInstance().setSp(60),
                                    fontWeight: FontWeight.w900
                                )
                            ),
                          ),
                          Text('Email',
                            style: TextStyle(
                                fontFamily: "Popins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(44)
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Email / Username",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                            ),
                          ),
                          Text('Password',
                            style: TextStyle(
                                fontFamily: "Popins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(40)
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(350),
                        height: ScreenUtil.getInstance().setHeight(150),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setSp(20)),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.cyan,
                                Colors.deepPurple
                              ],
                            )
                        ),
                        margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setSp(50)),

                        child: InkWell(
                          onTap: () {
                            print("Tapped on Login");;
                          },
                          child: Center(
                            child: Text("Login",
                              style: TextStyle(
                                  fontFamily: "Popins-Medium",
                                  fontSize: ScreenUtil.getInstance().setSp(50),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(double.infinity),
                        height: ScreenUtil.getInstance().setHeight(100),

                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil.getInstance().setSp(40), 0,
                            ScreenUtil.getInstance().setSp(40), 0),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(20)),
                              child: Text('First time here ?',
                                style: TextStyle(
                                    fontFamily: "Popins-Medium",
                                    fontSize: ScreenUtil.getInstance().setSp(43),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print("Tapped on Sign Up");
                              },
                              child: Padding(
                                padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(20)),
                                child: Text('Sign Up',
                                  style: TextStyle(
                                      fontFamily: "Popins-Medium",
                                      fontSize: ScreenUtil.getInstance().setSp(43),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.lightBlue
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}