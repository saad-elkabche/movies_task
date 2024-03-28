




import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/ui/screens/movies_screen/movies_screen.dart';
import 'package:movie_app/presentation/ui/screens/single_movie_screen/single_movie_screen.dart';

class Routes{


  static const String movies='/';
  static const String single_movie='/singleMovie';
  

  static GoRouter router=GoRouter(
    initialLocation: movies,
    routes: [
      GoRoute(
          path: movies,
        pageBuilder: (context,state)=>NoTransitionPage(child: MoviesScreen.page())
      ),
      GoRoute(
          path: single_movie,
          redirect: (context,state){
            if(state.extra is! MovieEntity){
              return movies;
            }
          },
          pageBuilder: (context,state){
             MovieEntity movieEntity=state.extra as MovieEntity;
             return NoTransitionPage(child: SignleMovieScreen(movieEntity: movieEntity,));
          }
      )
    ]
  );
}