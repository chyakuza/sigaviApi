  import 'package:flutter/material.dart';

Widget tituloPanel(String titulo) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Text(
            "$titulo",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }