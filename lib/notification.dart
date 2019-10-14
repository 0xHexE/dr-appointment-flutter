import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/notification_model.dart';
import 'package:flutter_app/services/notification_service.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationList = [
    {
      "name": [
        {"test1"}, {"test2"}, {"test3"},
      ]
    },
    {
      "description": [
        {"testDesc1"}, {"testDesc2"}, {"testDesc3"}
      ]
    },
    {
      "date": [
        {12456}, {125234}, {3467756}
      ]
    },
    {
      "time": [
        {145435}, {425435234}, {14123178}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('error' + ' ' + snapshot.data.toString());
            }else {
              return Text(snapshot.data.toString());
            }
            return new Center (
              child: ListView.builder(
                itemCount: snapshot.data.name.length,
                itemBuilder: (context, i) {
                  return Card(
                    key: snapshot.data.key[i],
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: snapshot.data.name[i],
                          ),
                          title: Text(snapshot.data.name),
                          subtitle: Text(snapshot.data.description),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Accept'),
                              onPressed: () {},
                            ),
                            FlatButton(
                              child: Text('Reject'),
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }else {
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
}


/*
Center(
        child: ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, i) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('TT'),
                    ),
                    title: Text(notificationList.elementAt(i).toString()),
                    subtitle: Text(notificationList.elementAt(i).toString()),
                  ),
                  ButtonBar (
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Accept'),
                        onPressed: () { },
                      ),
                      FlatButton (
                        child: Text('Reject'),
                        onPressed: () { },
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        )
      ),
* */