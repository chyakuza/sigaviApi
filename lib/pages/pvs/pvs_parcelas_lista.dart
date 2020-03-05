import 'package:sigavi_api/pages/pvs/pvs_parcelas_model.dart';

class ListaParcelas{
  List<Parcelas> parcelas;

  ListaParcelas({this.parcelas});

  factory ListaParcelas.fromJson(List<dynamic> json){
    return ListaParcelas(
      // percore o json e a cada chave de parcela cria-se um elemento Parcela e adiciona no objeto lista de parcelas e retorna para o chamador
      // uma lista de parcelas codificada
      parcelas : json.map((e) => Parcelas.fromJson(e)).toList()
    );
  }

}