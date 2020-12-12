import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testelogin/usuario.dart';

import 'api_response.dart';

class LoginApi {
  static Future<ApiResponse<Usuario>> login(
      String user, String password) async {
    try {
      var url = 'https://jsonplaceholder.typicode.com/users';

      Map params = {'username': user, 'senha': password};

      //encode Map para JSON(string)
      var body = json.encode(params);
      print("$params");

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);

      print("${response.statusCode}");

      print("${response.statusCode}");

      Map mapResponse = json.decode(response.body);

      print("$response.body");

      if (response.statusCode == 201) {
        final usuario = Usuario.fromJson(mapResponse);
        return ApiResponse.ok(usuario);
      }

      return ApiResponse.error("Erro ao fazer o login");
    } catch (error, exception) {
      print("Erro : $error > $exception ");

      return ApiResponse.error("Sem comunicação ... tente mais tarde... ");
    }
  }
}
