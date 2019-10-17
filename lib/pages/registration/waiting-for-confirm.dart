import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitingForConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Your application is in pending state. Come back soon.",
          style: Theme.of(context).textTheme.body2,
        ),
      ),
    );
  }
}
