class Clientes {
  String proCliCod;
  String proCliNom;
  String proCliTip;
  String proCliPri;
  String proCliRG;
  String proCliOrgExp;
  String proCliNac;
  String proCliDatNas;
  String proCliEstCiv;
  String proCliRegCas;
  String proCliTel;
  String proCliMail;
  String proCliPro;
  String proCliEndRes;
  String proCliEndCom;
  String proCliNomPai;
  String proCliNomMae;
  String proCliCon;
  String proCliConNom;
  String proCliConCPF;
  String proCliTemRep;

  Clientes(
      {this.proCliCod,
      this.proCliNom,
      this.proCliTip,
      this.proCliPri,
      this.proCliRG,
      this.proCliOrgExp,
      this.proCliNac,
      this.proCliDatNas,
      this.proCliEstCiv,
      this.proCliRegCas,
      this.proCliTel,
      this.proCliMail,
      this.proCliPro,
      this.proCliEndRes,
      this.proCliEndCom,
      this.proCliNomPai,
      this.proCliNomMae,
      this.proCliCon,
      this.proCliConNom,
      this.proCliConCPF,
      this.proCliTemRep});

  Clientes.fromJson(Map<String, dynamic> json) {
    proCliCod = json['ProCliCod'];
    proCliNom = json['ProCliNom'];
    proCliTip = json['ProCliTip'];
    proCliPri = json['ProCliPri'];
    proCliRG = json['ProCliRG'];
    proCliOrgExp = json['ProCliOrgExp'];
    proCliNac = json['ProCliNac'];
    proCliDatNas = json['ProCliDatNas'];
    proCliEstCiv = json['ProCliEstCiv'];
    proCliRegCas = json['ProCliRegCas'];
    proCliTel = json['ProCliTel'];
    proCliMail = json['ProCliMail'];
    proCliPro = json['ProCliPro'];
    proCliEndRes = json['ProCliEndRes'];
    proCliEndCom = json['ProCliEndCom'];
    proCliNomPai = json['ProCliNomPai'];
    proCliNomMae = json['ProCliNomMae'];
    proCliCon = json['proCliCon'];
    proCliConNom = json['ProCliConNom'];
    proCliConCPF = json['ProCliConCPF'];
    proCliTemRep = json['ProCliTemRep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProCliCod'] = this.proCliCod;
    data['ProCliNom'] = this.proCliNom;
    data['ProCliTip'] = this.proCliTip;
    data['ProCliPri'] = this.proCliPri;
    data['ProCliRG'] = this.proCliRG;
    data['ProCliOrgExp'] = this.proCliOrgExp;
    data['ProCliNac'] = this.proCliNac;
    data['ProCliDatNas'] = this.proCliDatNas;
    data['ProCliEstCiv'] = this.proCliEstCiv;
    data['ProCliRegCas'] = this.proCliRegCas;
    data['ProCliTel'] = this.proCliTel;
    data['ProCliMail'] = this.proCliMail;
    data['ProCliPro'] = this.proCliPro;
    data['ProCliEndRes'] = this.proCliEndRes;
    data['ProCliEndCom'] = this.proCliEndCom;
    data['ProCliNomPai'] = this.proCliNomPai;
    data['ProCliNomMae'] = this.proCliNomMae;
    data['proCliCon'] = this.proCliCon;
    data['ProCliConNom'] = this.proCliConNom;
    data['ProCliConCPF'] = this.proCliConCPF;
    data['ProCliTemRep'] = this.proCliTemRep;
    return data;
  }
}