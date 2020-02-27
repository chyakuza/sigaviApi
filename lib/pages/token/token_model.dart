class TokenModel {
  Retorno retorno;
  TokenAuth tokenAuth;

  TokenModel({this.retorno, this.tokenAuth});

  TokenModel.fromJson(Map<String, dynamic> json) {
    retorno =
        json['Retorno'] != null ? new Retorno.fromJson(json['Retorno']) : null;
    tokenAuth = json['TokenAuth'] != null
        ? new TokenAuth.fromJson(json['TokenAuth'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retorno != null) {
      data['Retorno'] = this.retorno.toJson();
    }
    if (this.tokenAuth != null) {
      data['TokenAuth'] = this.tokenAuth.toJson();
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

class TokenAuth {
  String token;

  TokenAuth({this.token});

  TokenAuth.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    return data;
  }
}
