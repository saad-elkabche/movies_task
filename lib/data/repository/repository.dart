



import 'package:movie_app/data/data_providers/api_provider/api_client.dart';
import 'package:movie_app/data/data_providers/api_provider/models/movie_model.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repository/repository.dart';

class RepositoryIml extends Repository{

  ApiClient apiClient;

  RepositoryIml({required this.apiClient});






  @override
  Future<List<MovieEntity>> getMovies(int page) async{
    List<MovieModel> moviesModel=await apiClient.getMovies(page);
    List<MovieEntity> movies=moviesModel.map((movieModel) => movieModel.toMovieEntity()).toList();
    return movies;
  }

}