import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/notification_service.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationList = [ { 'title': 'title 1' }, { 'title': 'title 2' }, { 'title': 'title 3' } ];

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
      body: Center(
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
                  FutureBuilder(
                    future: getNotifications(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('error');
                        }
                        return Text(snapshot.data.toString());
                      }else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            );
          }
        )
      ),
    );
  }
}
