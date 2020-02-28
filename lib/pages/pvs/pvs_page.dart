import 'package:flutter/material.dart';
import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_services.dart';

import '../../utils/api_response.dart';
import '../../widgets/appText.dart';

class PVPage extends StatelessWidget {
  final _tNumeroPV = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text("Dados PV"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            AppText(
              "Numero PV",
              "Infome o numero da PV",
              controller: _tNumeroPV,
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton.icon(
              onPressed: _onClickPV(),
              icon: Icon(Icons.account_balance),
              label: Text("Get Pv"),
              color: Colors.green[300],
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  _onClickPV() async{
    int pv =  int.parse(_tNumeroPV.text);

    ApiResponse<PvModel> retorno = await PvServices.getPv(pv);

    
  }
}
