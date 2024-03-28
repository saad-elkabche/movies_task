



import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_app/data/data_providers/api_provider/models/movie_model.dart';
import 'package:movie_app/domain/exceptions/network_exception.dart';

abstract class ApiClient{

  Future<List<MovieModel>> getMovies(int page);
}


class ApiClientIml extends ApiClient{

  late Dio _dio;


  ApiClientIml({required String baseUrl,required String apiKey}){
    _dio=Dio()
    ..options=BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 4),
      contentType: 'application/json',
      queryParameters: {
        'api_key':apiKey
      }
    )..interceptors.add(
          LogInterceptor(
            error: true,
            request: true,
            requestBody: true,
            requestHeader: true,
            responseBody: true,
            responseHeader: true,
          )
    );
  }

  @override
  Future<List<MovieModel>> getMovies(int page) async{
    try{
      var response=await _dio.get(
        '/movie/top_rated',
        queryParameters: {
          'page':'${page}',
          'language':'en'
        }
      );
      List<dynamic> data=response.data['results'];
      List<MovieModel> movies=data.map((movieData)=>MovieModel.fromJson(movieData)).toList();
      return movies;
    }on DioException catch(ex){
      if(ex.error is SocketException){
        throw NetworkException();
      }
      rethrow;
    }
  }

}