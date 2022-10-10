import 'package:dio/dio.dart';

class ApiConst {
  static const String BASE_URL = 'http://192.168.1.42:8080';
  static const String UNEN_URL = '/api/v1/';
  static Dio dio = initializeDio();
}

initializeDio() {
  var dio = Dio();
  dio.options.baseUrl = ApiConst.BASE_URL + ApiConst.UNEN_URL;
  dio.interceptors.add(AppInterceptor());
  return dio;
}

class AppInterceptor extends Interceptor {
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    options.headers.addAll({
      'Accept': 'application/json',
      'Content-type': 'application/json',
    });

    return handler.next(options);
  }

}

class AuthInterceptor extends Interceptor {
  static String token = '';

  AuthInterceptor({ required String token}) {
    AuthInterceptor.token = token;
  }
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    if(AuthInterceptor.token.isNotEmpty) {
      token = 'Bearer ${AuthInterceptor.token}';
    }
    options.headers.addAll({
      'Authorization': token
    });

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // if (err.response?.statusCode == 401) {
    //   NavigationService().navigateTo(LoginScreen.routeName);
    // }
    return handler.next(err);
  }
}
