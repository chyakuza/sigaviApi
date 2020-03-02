import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/utils/constants.dart';
import 'package:sigavi_api/utils/prefs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../utils/api_response.dart';

class PvServices {
  static Future<ApiResponse<PvModel>> getPv(String token,int numeroPv) async {
    try {
      String url = urlPV;
      //var response;
      // print("Url: ${url}");
      // Future<String> token = Prefs.getString('Token');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Token": "${token}",
      };
      print("Header pvs: ${headers}");
      Map data = {"PnvCod": "$numeroPv"};
      var body = convert.jsonEncode(data);

      print("Body : ${body}");

      final response = await http.post(url, body: body, headers: headers);
      if(response.statusCode == 200){
        Map<String, dynamic> mapResponse = convert.json.decode(response.body);
        print("MapService : $mapResponse");
        final pvRet = PvModel.fromJson(mapResponse);
        
        // print("Retornando services: ${pvRet.pV.blcNom}");
        return ApiResponse.ok(result: pvRet);        
      }else{
        return ApiResponse.ok(msg: "Erro Response : ${response.statusCode}");
        print("Erro Response : ${response.statusCode.toString()}");
      }

      
    } catch (e, excp) {}
  }
}
