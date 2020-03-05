class Parcelas {
  int pnpSeq;
  String pnaCod;
  int tsrCod;
  String tsrDes;
  String pnaDatVen;
  String pnaParVlr;
  String pnaVlrCom;
  String pnaVlrComNF;

  Parcelas({
    this.pnpSeq,
    this.pnaCod,
    this.tsrCod,
    this.tsrDes,
    this.pnaDatVen,
    this.pnaParVlr,
    this.pnaVlrCom,
    this.pnaVlrComNF,
  });

  factory Parcelas.fromJson(Map<String, dynamic> json) {
    return Parcelas(
        pnpSeq: json['PnpSeq'],
        pnaCod: json['PnaCod'],
        tsrCod: json['TsrCod'],
        tsrDes: json['TsrDes'],
        pnaDatVen: json['PnaDatVen'],
        pnaParVlr: json['PnaParVlr'],
        pnaVlrCom: json['PnaVlrCom'],
        pnaVlrComNF: json['PnaVlrComNF']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PnpSeq'] = this.pnpSeq;
    data['PnaCod'] = this.pnaCod;
    data['TsrCod'] = this.tsrCod;
    data['TsrDes'] = this.tsrDes;
    data['PnaDatVen'] = this.pnaDatVen;
    data['PnaParVlr'] = this.pnaParVlr;
    data['PnaVlrCom'] = this.pnaVlrCom;
    data['PnaVlrComNF'] = this.pnaVlrComNF;
    return data;
  }
}
