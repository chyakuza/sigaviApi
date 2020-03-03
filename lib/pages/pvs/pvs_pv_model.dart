import 'package:sigavi_api/pages/pvs/pvs_cliente_model.dart';
import 'package:sigavi_api/pages/pvs/pvs_parcelas_model.dart';



class PV {
  String obrCod;
  String obrNomCom;
  String blcCod;
  String blcNom;
  int uniCod;
  String uniTip;
  String pnvCod;
  String pnvDatCon;
  String pnvDat;
  String pnvDatCtr;
  int imoCod;
  String imoCnpj;
  String imoNom;
  String pnvCorNom;
  String pnvCooNom;
  String pnvGerNom;
  String pnvCpfCor;
  String pnvCpfCoo;
  String pnvCpfGer;
  String pnvVlrPro;
  String pnvVlrTotCal;
  String pnvVlrComNF;
  List<Parcelas> parcelas;
  List<Clientes> clientes;

  PV(
      {this.obrCod,
      this.obrNomCom,
      this.blcCod,
      this.blcNom,
      this.uniCod,
      this.uniTip,
      this.pnvCod,
      this.pnvDatCon,
      this.pnvDat,
      this.pnvDatCtr,
      this.imoCod,
      this.imoCnpj,
      this.imoNom,
      this.pnvCorNom,
      this.pnvCooNom,
      this.pnvGerNom,
      this.pnvCpfCor,
      this.pnvCpfCoo,
      this.pnvCpfGer,
      this.pnvVlrPro,
      this.pnvVlrTotCal,
      this.pnvVlrComNF,
      this.parcelas,
      this.clientes});

  PV.fromJson(Map<String, dynamic> json) {
    obrCod = json['ObrCod'];
    obrNomCom = json['ObrNomCom'];
    blcCod = json['BlcCod'];
    blcNom = json['BlcNom'];
    uniCod = json['UniCod'];
    uniTip = json['UniTip'];
    pnvCod = json['PnvCod'];
    pnvDatCon = json['PnvDatCon'];
    pnvDat = json['PnvDat'];
    pnvDatCtr = json['PnvDatCtr'];
    imoCod = json['ImoCod'];
    imoNom = json['ImoNom'];
    imoCnpj = json['ImoCnpj'];
    pnvCorNom = json['PnvCorNom'];
    pnvCooNom = json['PnvCooNom'];
    pnvGerNom = json['PnvGerNom'];
    pnvCpfCor = json['PnvCpfCor'];
    pnvCpfCoo = json['PnvCpfCoo'];
    pnvCpfGer = json['PnvCpfGer'];
    pnvVlrPro = json['PnvVlrPro'];
    pnvVlrTotCal = json['PnvVlrTotCal'];
    pnvVlrComNF = json['PnvVlrComNF'];
    if (json['Parcelas'] != null) {
      parcelas = new List<Parcelas>();
      json['Parcelas'].forEach((v) {
        parcelas.add(new Parcelas.fromJson(v));
      });
    }
    if (json['Clientes'] != null) {
      clientes = new List<Clientes>();
      json['Clientes'].forEach((v) {
        clientes.add(new Clientes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ObrCod'] = this.obrCod;
    data['ObrNomCom'] = this.obrNomCom;
    data['BlcCod'] = this.blcCod;
    data['BlcNom'] = this.blcNom;
    data['UniCod'] = this.uniCod;
    data['UniTip'] = this.uniTip;
    data['PnvCod'] = this.pnvCod;
    data['PnvDatCon'] = this.pnvDatCon;
    data['PnvDat'] = this.pnvDat;
    data['PnvDatCtr'] = this.pnvDatCtr;
    data['ImoCod'] = this.imoCod;
    data['ImoCnpj'] = this.imoCnpj;
    data['ImoNom'] = this.imoNom;
    data['PnvCorNom'] = this.pnvCorNom;
    data['PnvCooNom'] = this.pnvCooNom;
    data['PnvGerNom'] = this.pnvGerNom;
    data['PnvCpfCor'] = this.pnvCpfCor;
    data['PnvCpfCoo'] = this.pnvCpfCoo;
    data['PnvCpfGer'] = this.pnvCpfGer;
    data['PnvVlrPro'] = this.pnvVlrPro;
    data['PnvVlrTotCal'] = this.pnvVlrTotCal;
    data['PnvVlrComNF'] = this.pnvVlrComNF;
    if (this.parcelas != null) {
      data['Parcelas'] = this.parcelas.map((v) => v.toJson()).toList();
    }
    if (this.clientes != null) {
      data['Clientes'] = this.clientes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}