import 'package:flutter/material.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';





class SignleMovieScreen extends StatelessWidget {
  MovieEntity movieEntity;

  SignleMovieScreen({required this.movieEntity}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${movieEntity.title}"),
      ),
    );
  }
}

