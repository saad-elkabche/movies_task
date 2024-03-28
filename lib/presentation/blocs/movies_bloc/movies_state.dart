part of 'movies_bloc.dart';

class MoviesState {

  AppStatus? fetchingMoviesStatus;
  String? error;
  List<MovieEntity>? movies;
  bool? isConnectivityError;
  bool? isMaxReached;
  int currentPage;

  MoviesState.empty({required this.currentPage});

  MoviesState({
      required this.currentPage,
      this.fetchingMoviesStatus,
      this.error,
      this.movies,
      this.isMaxReached,
      this.isConnectivityError});


  MoviesState copyWith({
    AppStatus? fetchingMoviesStatus,
    bool? isConnectivityError,
    bool? isMaxReached,
    String? error,
    int? currentPage,
    List<MovieEntity>? movies,}){
    return MoviesState(
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
      isMaxReached: isMaxReached ?? this.isMaxReached,
      fetchingMoviesStatus: fetchingMoviesStatus ?? this.fetchingMoviesStatus,
      isConnectivityError: isConnectivityError ,
      movies:movies ?? this.movies
    );
  }
}


