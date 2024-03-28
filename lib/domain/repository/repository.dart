




import 'package:movie_app/domain/entities/movie_entity.dart';

abstract class Repository{

  Future<List<MovieEntity>> getMovies(int page);


}

