import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PvServices {
  static Future<PvModel> getPv(String token, int numeroPv) async {
    try {
      String url = urlPV;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Token": "$token",
      };

      Map data = {"PnvCod": "$numeroPv"};
      var body = convert.jsonEncode(data);

      final response = await http.post(url, body: body, headers: headers);

      final Map<String, dynamic> mapResponse = convert.json.decode(response.body);
      if (response.statusCode == 200) {
        // print("MapService : $mapResponse");
        final pvRet = PvModel.fromJson(mapResponse);

        // print("Retornando services: ${pvRet.pV.blcNom}");
        return pvRet;
      } else {
        // print("Erro Response : ${response.statusCode.toString()}");
        return null;
      }
    } catch (e, exception) {
      // print("Erro : $e exception $exception");
    }
  }
}
