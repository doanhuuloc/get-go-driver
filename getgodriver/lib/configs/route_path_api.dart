import 'api_config.dart';

class RoutePathApi {
  ///login
  static const String login = '${ApiConfig.baseUrl}/v1/users/login';
  // static const String signup = '${ApiConfig.baseUrl}/v1/users/signup';
  static const String checkPhone = '${ApiConfig.baseUrl}/v1/phone';

  static const String getDriverInfo = '${ApiConfig.baseUrl}/v1/driver/';
  static const String getScheduledTripsByDate = '${ApiConfig.baseUrl}/v1/appointment_trips';
  static const String acceptScheduledTrip = '${ApiConfig.baseUrl}/v1/trips/accept/';
  static const String getAcceptScheduledTrips = '${ApiConfig.baseUrl}/v1/appointment_trips/';

}
