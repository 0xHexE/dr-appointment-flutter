import 'package:flutter/material.dart';

class ClientInfo extends StatefulWidget {
  final String clientId;

  ClientInfo({this.clientId});

  @override
  _ClientInfoState createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  final String clientId;

  _ClientInfoState({this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
