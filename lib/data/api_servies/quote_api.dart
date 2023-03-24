import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ApiService {
  Dio dio;
  ApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://animechan.vercel.app/api/',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

  //ApiService({required this.dio});
  Future<List<dynamic>> getTenQuote() async {
    try {
      final response = await dio.get('quotes');
      debugPrint(response.data.toString());
      return response.data;
    } on DioError catch (error) {
      throw _handleError(error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getRandomTenQuoteByCharacter({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await dio.get('quotes/character', queryParameters: queryParameters);
      return response.data;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioError error) {
    String errorMessage = '';
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        errorMessage = 'Timeout';
        break;
      case DioErrorType.badResponse:
        errorMessage =
            'Bad Response ${error.response?.statusCode}: ${error.response?.statusMessage}';
        break;
      default:
        errorMessage = 'Network Error';
    }
    return Exception(errorMessage);
  }
}
