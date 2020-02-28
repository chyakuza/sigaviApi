import 'package:flutter/material.dart';
import 'package:sigavi_api/pages/token/token_bloc.dart';
import 'package:sigavi_api/pages/token/token_model.dart';
import 'package:sigavi_api/utils/api_response.dart';
import 'package:sigavi_api/utils/prefs.dart';

import 'package:sigavi_api/widgets/appText.dart';

class TokenPage extends StatelessWidget {
//   @override
//   _TokenPageState createState() => _TokenPageState();
// }

// class _TokenPageState extends State<TokenPage> {
  // final _formKey = GlobalKey<FormState>();
  // final _bloc = '';
  final _tLogin = TextEditingController(); 
  final _tSenha = TextEditingController();
  final _tToken = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Verifica Token"),
        backgroundColor: Colors.green[500],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AppText(
                "Login",
                "Informe o usuario",
                controller: _tLogin,
              ),
              AppText(
                "Senha",
                "Informe a senha",
                controller: _tSenha,
                password: true,
              ),
              AppText(
                "Token",
                "",
                controller: _tToken,
                password: false,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onCLickToken(); //TokenServices.getToken();
        },
        tooltip: 'Consultar CEP',
        child: Icon(Icons.add_location),
        backgroundColor: Colors.green[300],
      ),
    );
  }

  void _onCLickToken() async {
    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse<TokenModel> retorno =
        await TokenBloc().token(login.trim(), senha);
    if (retorno.ok == true) {
      print("Retorno Ret: ${retorno.result.tokenAuth.token}");
      if (retorno.result.tokenAuth.token.isEmpty) {
        _tToken.text = 'Sem retorno da API';
      } else {
        _tToken.text = retorno.result.tokenAuth.token;
         Prefs.setString('Token', retorno.result.tokenAuth.token);

        Future<String> future = Prefs.getString('Token');
        future.then((String tk) {
          String token = tk;
          print('Toke na memoria : ${token}');
        });

        
      }
    } else {
      _tToken.text = retorno.msg;
    }
  }
}
