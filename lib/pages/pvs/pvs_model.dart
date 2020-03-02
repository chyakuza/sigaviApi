import 'package:sigavi_api/pages/pvs/pvs_pv_model.dart';
import 'package:sigavi_api/pages/pvs/retorno.dart';

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






