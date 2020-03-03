import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_services.dart';
import 'package:sigavi_api/utils/api_response.dart';
import 'package:sigavi_api/utils/simple_bloc.dart';

class PvsBloc extends BooleanBloc {
  String token;

  Future<PvModel> pvs(String token, int numeroPV) async {
    //add(true);
    print("Numero da PV :$numeroPV");
    Future<PvModel> futureResponse = PvServices.getPv(token, numeroPV);
    futureResponse.then((PvModel ret) {
      if (!ret.pV.blcCod.isEmpty) {
        return ret;
      }
      return null;
    });
    // return futureResponse;
  }
}
