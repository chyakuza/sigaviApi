import 'package:flutter/material.dart';
import 'package:sigavi_api/pages/pvs/pvs_page.dart';
import 'package:sigavi_api/pages/token/token_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text("Home API"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 10),
        // color: Colors.blue[300],

        child: Row(
          children: <Widget>[
            FlatButton.icon(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TokenPage())),
              icon: Icon(Icons.vpn_key  ),    
              label: Text("Get Token"),
              color: Colors.blue,
              textColor: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            FlatButton.icon(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PVPage())),
              icon: Icon(Icons.compare_arrows),
              label: Text("Get dados PV"),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
