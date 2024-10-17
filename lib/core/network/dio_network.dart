import 'package:dio/dio.dart';

class DioFile {
  static final DioFile _instance = DioFile._internal();
  DioFile._internal();

  static DioFile getInstance() {
    return _instance;
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://online-shop-c61f7-default-rtdb.firebaseio.com",
    ),
  );

  Dio get dio => _dio;

}