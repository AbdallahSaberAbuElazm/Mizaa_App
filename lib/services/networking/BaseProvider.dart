import 'package:get/get_connect.dart';
import 'package:mizaa/services/networking/ApiConstants.dart';
import 'package:mizaa/services/networking/interceptors/RequestInterceptor.dart';
import 'package:mizaa/services/networking/interceptors/ResponseInterceptor.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }
}
