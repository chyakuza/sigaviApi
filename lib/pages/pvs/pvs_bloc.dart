import 'package:sigavi_api/pages/pvs/pvs_cliente_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_services.dart';

class PvsBloc {
  static Future<PvModel> pvs(String token, int numeroPV) async {
    print("Numero da PV :$numeroPV");
    PvModel futureResponse = await  PvServices.getPv(token, numeroPV);

    return futureResponse;
  }

  static Future<List<Clientes>> clientes(String token, int numeroPV) async { 
    PvModel futureResponse = await  PvServices.getPv(token, numeroPV);
    List<Clientes> clientes = futureResponse.pV.clientes.toList();
    print("Lista de clientes : ${clientes.length}");
    return clientes;
  }
}
