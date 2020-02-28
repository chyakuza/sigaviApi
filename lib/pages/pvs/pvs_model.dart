import 'package:sigavi_api/pages/pvs/pvs_pv_model.dart';

class PvModel {
  Retorno retorno;
  PV pV;

  PvModel({this.retorno, this.pV});

  PvModel.fromJson(Map<String, dynamic> json) {
    retorno =
        json['Retorno'] != null ? new Retorno.fromJson(json['Retorno']) : null;
    pV = json['PV'] != null ? new PV.fromJson(json['PV']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retorno != null) {
      data['Retorno'] = this.retorno.toJson();
    }
    if (this.pV != null) {
      data['PV'] = this.pV.toJson();
    }
    return data;
  }
}

class Retorno {
  int result;
  String message;

  Retorno({this.result, this.message});

  Retorno.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    return data;
  }
}




