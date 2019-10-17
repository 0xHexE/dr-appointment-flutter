import 'package:appointment_app/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitingForConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your application is in pending state. Come back soon.",
              style: Theme.of(context).textTheme.body2,
            ),
            RaisedButton(
              child: Text("Refresh"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Root(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
