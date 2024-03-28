import 'package:flutter/material.dart';
import 'package:movie_app/core/dependencies/dependencies.dart';
import 'package:movie_app/data/data_providers/api_provider/api_client.dart';
import 'package:movie_app/data/repository/repository.dart';
import 'package:movie_app/domain/repository/repository.dart';
import 'package:movie_app/routes.dart';



void main(){
  prepareDependencies();
  runApp(MovieApp());
}

void prepareDependencies() {
  Repository repository=RepositoryIml(apiClient: ApiClientIml(
      baseUrl: "https://api.themoviedb.org/3",
      apiKey: "891d68753713e26547c8202fff753cfe")
  );
  Dependencies.put(repository);
}


class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
    );
  }
}
