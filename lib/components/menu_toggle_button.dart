import 'package:flutter/material.dart';

class MenuToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        final ScaffoldState scaffold = Scaffold.of(context);
        scaffold.openDrawer();
      },
    );
  }
}
