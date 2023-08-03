import 'api_config.dart';

class RoutePathApi {
  ///login
  static const String login = '${ApiConfig.baseUrl}/v1/users/login';
  static const String signup = '${ApiConfig.baseUrl}/v1/users/signup';
  static const String checkPhone = '${ApiConfig.baseUrl}/v1/phone';

  static const String getAllDriver =
      '${ApiConfig.baseUrl}/v1/location/localdriver';
  static const String bookDriver = '${ApiConfig.baseUrl}/v1/booking/users';
}
