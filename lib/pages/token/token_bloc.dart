import 'package:sigavi_api/pages/token/token_model.dart';
import 'package:sigavi_api/pages/token/token_services.dart';
import 'package:sigavi_api/utils/api_response.dart';
import 'package:sigavi_api/utils/simple_bloc.dart';

class TokenBloc extends BooleanBloc {
  Future<ApiResponse<TokenModel>> token(String login, String senha) async {
    add(true);
    print("User : ${login} senha ${senha}");
    
    ApiResponse response = await TokenServices.getToken(login, senha);

    add(false);

    return response;
  }
}
