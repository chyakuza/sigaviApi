import 'package:flutter/material.dart';

class PVPage extends StatelessWidget {
  const PVPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[500],
          title: Text("Dados PV"),
        ),
        body: Container(
          color: Colors.white,
        ),
      );
  }
}
