import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/model/notification_model.dart';
import 'package:appointment_app/services/notification_service.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
            if (snapshot.data == null && !snapshot.hasError) {
              return AlertDialog(
                title: Text("No New Appointments"),
                content: Text("Come back later"),
              );
            }

            if (snapshot.hasError) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Check Internet Connection" + " " + snapshot.error.toString()),
              );
            }
            return new Center (
              child: ListView.builder(
                itemCount: snapshot.data.notification.length,
                itemBuilder: (context, i) {
                  return new Card(
                    key: Key(snapshot.data.notification[i].name),
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          leading: CircleAvatar(
                            child: Text(snapshot.data.notification[i].name.toString()[0].toUpperCase()),
                          ),
                          title: Text(snapshot.data.notification[i].name),
                          subtitle: Text(snapshot.data.notification[i].description),
                        ),
                        new ButtonBar(
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}

/*
  Tested using this :
  {
      "key": [ "key1", "key2", "key3" ],
      "name": [ "test1", "test2", "test3"],
      "description": [ "testDesc1", "testDesc2", "testDesc3"],
      "date": [ 14131231, 14131231, 14131231],
      "time": [ 12523123, 12523123, 12523123]
  }
*/