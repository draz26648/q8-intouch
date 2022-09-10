import 'package:dio/dio.dart';

import 'mapper.dart';

class NetworkHelper {
  static NetworkHelper? _instance;
  static late Dio _dio;

  NetworkHelper._internal();

  factory NetworkHelper() {
    if (_instance == null) {
      _dio = Dio();
      _dio.options.baseUrl = 'https://dummyjson.com/';
      _instance = NetworkHelper._internal();
    }
    return _instance!;
  }

// Using dynamic get method its better than use method for every endpoint call and it reduces duplication
  Future<dynamic> get(
      {required String url,
      Mapper? model,
      Map<String, dynamic>? query,
      var headers}) async {
    Response _res;
    if (headers != null) {
      _dio.options.headers = headers;
    } else {
      _dio.options.headers = {
        'Content-Type': 'application/json',
      };
    }
    print('End point: => $url');
    try {
      _res = await _dio.get(url, queryParameters: query);
    } on DioError catch (e) {
      print('Exception in $url: => ${e.response.toString()}');

      _res = e.response!;
    }
    print('Response of $url: => ${_res.toString()}');

    if (model == null) {
      return _res;
    } else {
      return Mapper(model, _res.data);
    }
  }
}
