import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:sigavi_api/pages/token/token.dart';
import 'package:sigavi_api/pages/token/token_model.dart';
import 'package:sigavi_api/utils/api_response.dart';

class TokenServices {
  static Future<ApiResponse<TokenModel>> getToken(
      String login, String senha) async {
    try {
      String url = "https://gcqas.even.com.br/rest/getTokenSG";

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Login": "${login}",
        "Senha": "${senha}"
      };
      // print("Header :$headers");
      // '{ "Login":"sigavi", "Senha" : "sigavi"}'
      final response = await http.post(url, headers: headers);
      //inal json = response.body;
      // print("Retorno Json : ${response.body}");
      // print("Status Code: ${response.statusCode}");
      Map<String, dynamic> mapResponse = convert.json.decode(response.body);
      // print("MapRetorno : $mapResponse");
      // TokenModel tokenMap = TokenModel.fromJson(mapResponse);
      // print('TokenMap ${tokenMap.tokenAuth.token}');
      // Map token = mapResponse['TokenAuth'];
      // print('Token : ${token}');
      // Token tokenVal = Token.fromJson(mapResponse);
      // print("TokeVal : ${tokenVal.toJson()}");

      if (response.statusCode == 200) {
        //print("Caiu 200");
        final tokenRet = TokenModel.fromJson(mapResponse);
        print("Print Ret: ${tokenRet.tokenAuth.token}");

        return ApiResponse.ok(result: tokenRet);
      } else {
        return ApiResponse.error(msg: "Não foi possivel encontrar os dados");
      }
    } catch (e, excp) {
      //print("Erro ${e} excp ${excp} ");
      ApiResponse.error(result: "Não foi possivel encontrar os dados :${excp}");
    }
  }
}
