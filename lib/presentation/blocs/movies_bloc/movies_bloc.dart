import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/constants/enums/app_status.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/exceptions/network_exception.dart';
import 'package:movie_app/domain/repository/repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  Repository repository;
  Duration waitingDuration =const  Duration(seconds: 2);

  MoviesBloc({required this.repository}) : super(MoviesState.empty(currentPage: 0)) {
    on<FetchMovies>(
        _fetchMovies,
        transformer: waiting(waitingDuration)
    );
  }









  FutureOr<void> _fetchMovies(FetchMovies event, Emitter<MoviesState> emit) async{
    try{
      if(state.isMaxReached ?? false){
        return;
      }
      if(state.currentPage==0){
       emit(state.copyWith(firstFetchStatus: AppStatus.loading));
      }

      int newCurrentPage=state.currentPage+1;
      List<MovieEntity> movies=state.movies ?? [];
      List<MovieEntity> nextMovies=await repository.getMovies(newCurrentPage);



      if(nextMovies.isEmpty){
        emit(state.copyWith(isMaxReached: true));
        return;
      }
      movies.addAll(nextMovies);

      emit(
        state.copyWith(
          movies: movies,
          currentPage: newCurrentPage,
          firstFetchStatus: AppStatus.success,
        )
      );

    }catch(ex){

      if(state.movies?.isEmpty ?? true){

        emit(state.copyWith(
            firstFetchStatus: AppStatus.error,
            isConnectivityError: ex is NetworkException,
            error: ex.toString())
        );
      }else{

        emit(state.copyWith(
            fetchingMoviesStatus: AppStatus.error,
            isConnectivityError: ex is NetworkException,
            error: ex.toString())
        );
      }
    }
  }
  EventTransformer<E> waiting<E>(Duration waitingDurating) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(waitingDurating), mapper);
    };
  }
}
