part of 'movies_bloc.dart';

class MoviesState {

  AppStatus? firstFetchStatus;
  AppStatus? fetchMoviesStatus;
  String? error;
  List<MovieEntity>? movies;
  bool? isConnectivityError;
  bool? isMaxReached;
  int currentPage;

  MoviesState.empty({required this.currentPage});

  MoviesState({
      required this.currentPage,
      this.firstFetchStatus,
      this.fetchMoviesStatus,
      this.error,
      this.movies,
      this.isMaxReached,
      this.isConnectivityError});


  MoviesState copyWith({
    AppStatus? firstFetchStatus,
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
      firstFetchStatus: firstFetchStatus ?? this.firstFetchStatus,
      fetchMoviesStatus: fetchingMoviesStatus,
      isConnectivityError: isConnectivityError ,
      movies:movies ?? this.movies
    );
  }
}


