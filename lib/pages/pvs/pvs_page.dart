import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sigavi_api/pages/pvs/pvs_bloc.dart';
import 'package:sigavi_api/pages/pvs/pvs_cliente_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_services.dart';
import 'package:sigavi_api/utils/prefs.dart';
import 'package:sigavi_api/widgets/pvParcelas.dart';
import 'package:sigavi_api/widgets/tituloPainel.dart';
import '../../widgets/appText.dart';

class PVPage extends StatefulWidget {
  @override
  _PVPageState createState() => _PVPageState();
}

class _PVPageState extends State<PVPage> {
  // Iniciando Stream
  final _resultPv = StreamController<PvModel>();

  PvModel pvModel = PvModel();
  PvModel pvModelResponse;

  Future<PvModel> pvs;

  final _tNumeroPV = TextEditingController();
  final _tToken = TextEditingController();

  @override
  void initState() {
    _getToken();
    _loadDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text("Dados PV"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  _loadDados();
                },
                icon: Icon(Icons.account_balance),
                label: Text("Get Dados Pv"),
                color: Colors.green[300],
                textColor: Colors.white,
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width / 0.9,
                  child: Column(
                    children: <Widget>[
                      pvResultado(),
                      // pvParcelas()
                    ],
                  ),
                  // child: ListView(
                  //   scrollDirection: Axis.horizontal,

                  //   children: <Widget>[
                  //     Container(
                  //       width: MediaQuery.of(context).size.width / 1.1,
                  //       child: pvResultado(),
                  //     ),
                  //     // Dados dos clientes
                  //     // pvClientes(),

                  //     // Dados das Parcelas
                  //     // pvParcelas(context)
                  //   ],
                  // ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // METODOS
  void _getToken() async {
    _tToken.text = await Prefs.getString('Token');
  }

  _loadDados() async {
    try {
      if (!_tNumeroPV.text.isEmpty && !_tToken.text.isEmpty) {
        pvModelResponse =
            await PvServices.getPv(_tToken.text, int.parse(_tNumeroPV.text));
        _resultPv.sink.add(pvModelResponse);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // WIDGETS
  Widget pvParcelas() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.green[100],
                offset: Offset(0.1, 1.0),
              ),
            ]),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                tituloPanel("Dados Parcelas"),
                Column(
                  children: <Widget>[
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.access_alarm),
                          subtitle: Text("Subtitulo"),
                          title: Text("titulo"),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget pvClientes() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.green[100],
                offset: Offset(0.1, 1.0),
              ),
            ]),
        child: Card(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[tituloPanel("Dados dos Clientes")],
                ),
              ],
            ),
          ),
        ));
  }

  Widget pvResultado() {
    return StreamBuilder<PvModel>(
        stream: _resultPv.stream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  //margin: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 10.0,
                          color: Colors.green[100],
                          offset: Offset(0.1, 1.0),
                        ),
                      ]),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Cabecalho Empreendimento
                              tituloPanel("Empreendimento"),
                              // Dados da Pv
                              // Linha 1
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.business,
                                    color: Colors.green[500],
                                  ),
                                  separador(),
                                  Text(snapshot.data.pV.obrCod),
                                  separador(),
                                  Flexible(
                                      child: Container(
                                          child: Text(
                                    snapshot.data.pV.obrNomCom,
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Linha 2
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.home,
                                    color: Colors.green[500],
                                  ),
                                  separador(),
                                  Text(snapshot.data.pV.blcCod),
                                  separador(),
                                  Text(snapshot.data.pV.blcNom),
                                  separador(),
                                  Text((snapshot.data.pV.uniTip == "A")
                                      ? "APARTAMENTO"
                                      : "OUTRO"),
                                ],
                              ),
                              // linha 3
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.account_box,
                                    color: Colors.green[500],
                                  ),
                                  separador(),
                                  Text(
                                      "Numero PV : ${snapshot.data.pV.pnvCod}"),
                                  separador(),
                                  Text("Data:${snapshot.data.pV.pnvDat}"),
                                ],
                              ),
                              // Cabecalho Proposta
                              tituloPanel("Proposta "),

                              // linha 4
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.flag,
                                    color: Colors.green[500],
                                  ),
                                  separador(),
                                  Text("Valor :${snapshot.data.pV.pnvVlrPro}"),
                                  separador(),
                                  Text(
                                      "Total Calc. :${snapshot.data.pV.pnvVlrTotCal}"),
                                ],
                              ),
                              tituloPanel("Dados Venda"),
                              // Linha 5 - Dados da Venda
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.featured_play_list,
                                    color: Colors.green[300],
                                  ),
                                  separador(),
                                  Text(
                                      "Imobiliaria : ${snapshot.data.pV.imoCod} - ${snapshot.data.pV.imoNom}"),
                                ],
                              ),

                              Row(
                                children: <Widget>[
                                  separador(),
                                  separador(),
                                  separador(),
                                  Text(
                                      "CNPJ : ${snapshot.data.pV.imoCnpj == null ? 'Não informador' : snapshot.data.pV.imoCnpj}")
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      // CLIENTES
                      Card(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 400,
                              child: Column(
                                children: <Widget>[
                                  tituloPanel("Clientes"),
                                  
                                  listaClientes(snapshot),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  color: Colors.grey[100],
                  height: 80,
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  )),
                );
        });
  }

  Widget separador() {
    return SizedBox(width: 10);
  }

  Widget listaClientes(AsyncSnapshot<PvModel> snapshot) {
    List<Clientes> clientes = snapshot.data.pV.clientes;
    clientes.forEach((c) => () {
          return ListTile(
            title: Text("Nome : ${clientes[0].proCliNom}"),
            subtitle: Text("${clientes[0].proCliMail}"),
            onLongPress: () {},
          );
        });
  }
}
