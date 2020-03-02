import 'package:flutter/material.dart';
import 'package:sigavi_api/pages/pvs/pvs_bloc.dart';
import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_pv_model.dart';
import 'package:sigavi_api/pages/pvs/retorno.dart';
import 'package:sigavi_api/utils/prefs.dart';
import '../../utils/api_response.dart';
import '../../widgets/appText.dart';

class PVPage extends StatefulWidget {
  @override
  _PVPageState createState() => _PVPageState();
}

class _PVPageState extends State<PVPage> {
  //Iniciando o block
  // void initState() {
  //   widget._tNumeroPV.text = "269589";
  //   // Future<ApiResponse<PvModel>> future = PvsBloc().pvs(int.parse(widget._tNumeroPV.text));
  //   // future.then((pvModel){
  //   //   setState(() {
  //   //   });
  //   }
  //   super.initState();
  // }
  @override
  void initState() {
    _getToken();

    super.initState();
  }

  PvModel pvModel;
  Future<PvModel> pvs;

  final _tNumeroPV = TextEditingController();
  final _tRetorno = TextEditingController();
  final _tToken = TextEditingController();
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
              "Token",
              "token na memoria",
              controller: _tToken,
            ),
            AppText("Numero PV", "Infome o numero da PV",
                controller: _tNumeroPV, keyboardType: TextInputType.number),
            SizedBox(
              height: 10,
            ),
            FlatButton.icon(
              onPressed: () {
                _onClickPV();
              },
              icon: Icon(Icons.account_balance),
              label: Text("Get Pv"),
              color: Colors.green[300],
              textColor: Colors.white,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text("Dados Da PV retorno"),
                  FutureBuilder(
                      future: _getDadosPv(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text("Aguardando dados....."));
                        }
                        return Center(
                          child: Text(snapshot.data),
                        );
                      })
                ],
              ),
            ),
            TextField(
              controller: _tRetorno,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Dados Retornado'),
            )
          ],
        ),
      ),
    );
  }

  _onClickPV() {
    
    if (_tToken.text.isEmpty) {
      return _tRetorno.text = "Informe o TOKEN";
    }
    if (_tNumeroPV.text.isEmpty) {
      return _tRetorno.text = 'Informe o numero da PV';
    }
    Future<PvModel> pvRet = _getDadosPv();
    setState(() {});
    try {} catch (e) {}
  }

  void _getToken() async {
    _tToken.text = await Prefs.getString('Token');
  }

  Future<PvModel> _getDadosPv() async {
    Future<ApiResponse<PvModel>> future =
        PvsBloc().pvs(_tToken.text, int.parse(_tNumeroPV.text));
    future.then((ApiResponse<PvModel> pvRet) {
      if (pvRet.ok == true) {
        PvModel pvModel =
            new PvModel(pV: pvRet.result.pV, retorno: pvRet.result.retorno);
        print(pvModel);
        return pvModel;
      } else {
        print("Retornou nada ");
        return null;
      }
    });
  }
}
