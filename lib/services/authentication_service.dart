import 'package:winwin/config/constant_config.dart';
import 'package:winwin/error/exceptions.dart';
import 'package:winwin/services/network_service_response.dart';
import 'package:winwin/services/restclient.dart';


class AuthenticationService{
  RestClient client = RestClient();
  final ConstantConfig constantConfig = ConstantConfig();


  Future<Object> register(String? username, String? login_mail, String? login_password) async {
    MappedNetworkServiceResponse response;
    if (username == null || login_mail == null || login_password == null) {
      print("not wokring regsiter");
      return "incorrect stuff";
    } else {
      response = await client.post(
        '/api/v1/loginMethods',
        {
          'username': username,
          'login_email': login_mail,
          'login_password': login_password
        }
      );
    }
    if (response.networkServiceResponse.success) {
      return response;
    } else {
      throw RegisterException(response.networkServiceResponse.message);
    }
  }

  Future<bool> login(String? login_mail, String? login_password) async {
    MappedNetworkServiceResponse response;
    if (login_mail == null || login_password == null) {
      return false;
    } else {
      response = await client.get(
        '/api/v1/login_method',
        queryParameters: {
          'login_email': login_mail,
          'login_password': login_password
        },
      );
    }
    if (response.networkServiceResponse.success) {
      for (int i =0; i<response.mappedResult.length; i++){
        print(response.mappedResult[i]['login_email']);
        if (login_mail == response.mappedResult[i]['login_email']){
          return true;
        }
      }
      return false;
    } else {
      throw RegisterException(response.networkServiceResponse.message);
    }
  }
}
