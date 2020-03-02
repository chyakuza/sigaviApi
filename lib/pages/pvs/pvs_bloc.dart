
import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_services.dart';
import 'package:sigavi_api/utils/api_response.dart';
import 'package:sigavi_api/utils/prefs.dart';
import 'package:sigavi_api/utils/simple_bloc.dart';

class PvsBloc extends BooleanBloc {
  String token;
  ApiResponse<PvModel> futureResponse;
  Future<ApiResponse<PvModel>> pvs(String token , int numeroPV) async {
    add(true);

    print("Numero da PV :$numeroPV");
  
        // Future<String> future = Prefs.getString('Token');
        // future.then((String tk) {
        //   token = tk;
        //   // print('Token na memoria - Block: ${token}');
        //   Future<ApiResponse<PvModel>> futureResponse =
        //       PvServices.getPv(token, numeroPV);
        //   futureResponse.then((v) {
        //     PvModel pvRet = v.result;
        //     print("V2 : ${pvRet.toJson()}");
        //     add(false);
        
        //   });
        // });
        Future<ApiResponse<PvModel>> futureResponse = PvServices.getPv(token, numeroPV);
        futureResponse.then((ApiResponse<PvModel> ret){
          if(ret.ok == true){
            return ret;
          }
          return null;
        });
        // return futureResponse;
      }
}


//  Future<String> retToken() async{
//       Future<String> future = Prefs.getString('Token');
//       future.then((String tk) {
//         return tk;
//       }
//   }