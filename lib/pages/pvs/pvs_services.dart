import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/utils/constants.dart';
import 'package:sigavi_api/utils/prefs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../utils/api_response.dart';

class PvServices {
    static Future<ApiResponse<PvModel>> getPv(int numeroPv) async{
      try {
        String url = urlPV; 
        Future<String> token = Prefs.getString('Token');

        Map<String,String> headers = {
          "Content-Type": "application/json",
          "Token": "${token}",
        };

        Map<String,String> body = {
          "PnvCod" : "$numeroPv"
        };

        final response = await http.post(url,body: body, headers: headers);
        
        Map<String,dynamic> mapResponse = convert.json.decode(response.body);
        print("MapRetorno : $mapResponse");
        
      } catch (e, excp) {
      }
    }
}