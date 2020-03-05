import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sigavi_api/pages/pvs/pvs_bloc.dart';
import 'package:sigavi_api/pages/pvs/pvs_cliente_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_parcelas_lista.dart';
import 'package:sigavi_api/pages/pvs/pvs_parcelas_model.dart';
import 'package:sigavi_api/utils/prefs.dart';
import 'package:sigavi_api/widgets/tituloPainel.dart';
import '../../widgets/appText.dart';

class PVPage extends StatefulWidget {
  @override
  _PVPageState createState() => _PVPageState();
}

class _PVPageState extends State<PVPage> {
  // Iniciando Stream
  final _resultPv = StreamController<PvModel>();
  final _resultClientes = StreamController<List<Clientes>>();
  final _resultParcelas = StreamController<List<Parcelas>>();

  PvModel pvModel = PvModel();
  PvModel pvModelResponse;
  List<Clientes> clientes = [];
  List<Parcelas> listaParcelas = [];

  Future<PvModel> pvs;

  final _tNumeroPV = TextEditingController();
  final _tToken = TextEditingController();
  bool _result = false;

  @override
  void initState() {
    _getToken();
    _loadDados();
    _loadClientes();
    _loadParcelas();
    _tNumeroPV.text = '270785';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      _loadDados();
                      _loadClientes();
                      _loadParcelas();
                    },
                    icon: Icon(Icons.account_balance),
                    label: Text("Dados Pv"),
                    color: Colors.green[300],
                    textColor: Colors.white,
                  ),
                  separador(),
                  // FlatButton.icon(
                  //   onPressed: () {
                      
                  //   },
                  //   icon: Icon(Icons.account_balance),
                  //   label: Text("Dados Clientes"),
                  //   color: Colors.green[300],
                  //   textColor: Colors.white,
                  // )
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width / 0.9,
                  child: Column(
                    children: <Widget>[
                      pvResultado(),
                      pvClientes(),
                      pvParcelas()
                    ],
                  ),
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

  _loadParcelas() async {
    // List<Parcelas> listaMensal = [];
    // List<double> totalAgragado = [];
    try {
      listaParcelas =
          await PvsBloc.parcelas(_tToken.text, int.parse(_tNumeroPV.text));
      // Adicionando conteudo na Stream
      _resultParcelas.add(listaParcelas);
      print("Total de parcelas carregadas : ${listaParcelas.length}");

      // for (Parcelas p in listaParcelas) {
      //   if (p.tsrCod == 1) {
      //     listaMensal.add(p);
      //     totalAgragado.add(double.parse(p.pnaParVlr));
      //   }
      // }
      // double totalValorParcela = totalAgragado.reduce((anterior, atual) {
      //   return anterior + atual;
      // });
      // print("Total Parcela Mensal : ${totalValorParcela.toStringAsFixed(2)}");

    } catch (e) {}
  }

  _loadClientes() async {
    try {
      clientes =
          await PvsBloc.clientes(_tToken.text, int.parse(_tNumeroPV.text));
      // print("Retorno Cliente Lista : ${clientes.map((c) => c.proCliNom)}");
      if (clientes.length >= 1) {
        _resultClientes.add(clientes);
      }
    } catch (e) {}
  }

  _loadDados() async {
    try {
      if (!_tNumeroPV.text.isEmpty && !_tToken.text.isEmpty) {
        pvModelResponse =
            await PvsBloc.pvs(_tToken.text, int.parse(_tNumeroPV.text));
        if (pvModelResponse.pV.pnvCod != null) {
          _resultPv.sink.add(pvModelResponse);
        } else {
          _resultPv.close();
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // WIDGETS
  Widget pvParcelas() {
    return StreamBuilder(
      stream: _resultParcelas.stream,
      builder: (context, snapshot) {        
        return (snapshot.hasData)
            ? Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.green[100],
                      offset: Offset(0.1, 1.0),
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            tituloPanel("Parcelas")

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container(
                child: Text("Dados não carregados..."),
              );
      },
    );
  }

  Widget pvClientes() {
    return StreamBuilder<List<Clientes>>(
      stream: _resultClientes.stream,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? Container(
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
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            tituloPanel("Clientes"),
                            Column(
                              children: <Widget>[
                                // Titulo Principal
                                subTituloWidget(
                                    "Cliente Principal", Colors.blue),
                                // Dados Cliente Principal
                                clientePrincipal(snapshot),
                                SizedBox(
                                  height: 20,
                                ),
                                clienteAuxiliar(snapshot),
                                // Dados Pessoais
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))
            : Container(
                child: Center(
                  child: Text("Dados não encontrado"),
                ),
              );
      },
    );
  }

  Widget pvResultado() {
    return StreamBuilder<PvModel>(
        stream: _resultPv.stream,
        builder: (context, snapshot) {
          return (snapshot.hasData)
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

  Widget subTituloWidget(String titulo, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          titulo,
          style: TextStyle(
              color: color, //Colors.blueAccent[200],
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget clienteAuxiliar(AsyncSnapshot<List<Clientes>> snapshot) {
    List<Widget> listRow = new List<Widget>();
    List<Clientes> clientes = snapshot.data;
    for (Clientes item in clientes) {
      if (item.proCliPri == "NAO") {
        Clientes prin = Clientes.fromJson(item.toJson());
        listRow.add(Flexible(
            child: Container(
          child: Column(
            children: <Widget>[
              subTituloWidget("Clientes Auxiliares", Colors.red),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.people,
                    color: Colors.green[300],
                  ),
                  separador(),
                  Text(
                    "Nome : ${prin.proCliNom}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.green[300],
                  ),
                  separador(),
                  Text("Email : ${prin.proCliMail}",
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              subTituloWidget("Dados Pessoais", Colors.blue),
              Column(
                children: <Widget>[
                  // Icon(Icons.content_paste, color: Colors.green[300],),
                  Text(prin.proCliTip == "F"
                      ? "CPF : ${prin.proCliCod} RG : ${prin.proCliRG}"
                      : "CNPJ : ${prin.proCliCod}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.phone_android,
                        color: Colors.green[300],
                      ),
                      Text("${prin.proCliTel}"),
                    ],
                  ),
                  Text("Ocupação : ${prin.proCliPro}"),
                  subTituloWidget("Endereço", Colors.blue),
                  Text("${prin.proCliEndRes}")
                ],
              )
            ],
          ),
        )));
      }
    }
    return new Row(
      children: listRow,
    );
  }

  Widget clientePrincipal(AsyncSnapshot<List<Clientes>> snapshot) {
    List<Widget> listRow = new List<Widget>();
    List<Clientes> clientes = snapshot.data;

    for (Clientes item in clientes) {
      if (item.proCliPri == "SIM") {
        Clientes prin = Clientes.fromJson(item.toJson());
        listRow.add(
          Flexible(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.people,
                        color: Colors.green[300],
                      ),
                      separador(),
                      Text(
                        "Nome : ${prin.proCliNom}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Colors.green[300],
                      ),
                      separador(),
                      Text("Email : ${prin.proCliMail}",
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  subTituloWidget("Dados Pessoais", Colors.blue),
                  Column(
                    children: <Widget>[
                      // Icon(Icons.content_paste, color: Colors.green[300],),
                      Text(prin.proCliTip == "F"
                          ? "CPF : ${prin.proCliCod} RG : ${prin.proCliRG}"
                          : "CNPJ : ${prin.proCliCod}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.phone_android,
                            color: Colors.green[300],
                          ),
                          Text("${prin.proCliTel}"),
                        ],
                      ),
                      Text("Ocupação : ${prin.proCliPro}"),
                      subTituloWidget("Endereço", Colors.blue),
                      Text("${prin.proCliEndRes}")
                    ],
                  )
                ],
              ),
            ),
          ),
        );
        // listRow.add(Container(child: Text("Nome :${prin.proCliNom} CPF : ${prin.proCliCod}",style: TextStyle(fontSize: 12),))) ;
      }
    }
    return new Row(
      children: listRow,
    );
  }
}

// Widget pvParcelas() {
//     return Container(
//         width: MediaQuery.of(context).size.width / 1.1,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                 blurRadius: 10.0,
//                 color: Colors.green[100],
//                 offset: Offset(0.1, 1.0),
//               ),
//             ]),
//         child: Card(
//           child: Container(
//             padding: EdgeInsets.all(5),
//             child: Column(
//               children: <Widget>[
//                 tituloPanel("Dados Parcelas"),
//                 Column(
//                   children: <Widget>[
//                     ListView(
//                       scrollDirection: Axis.vertical,
//                       children: <Widget>[
//                         ListTile(
//                           leading: Icon(Icons.access_alarm),
//                           subtitle: Text("Subtitulo"),
//                           title: Text("titulo"),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
