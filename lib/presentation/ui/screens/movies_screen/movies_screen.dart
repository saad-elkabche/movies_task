import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/constants/app_colors/app_colors.dart';
import 'package:movie_app/core/dependencies/dependencies.dart';
import 'package:movie_app/core/extensions/extension_on_app_status_enum.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repository/repository.dart';
import 'package:movie_app/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:movie_app/presentation/ui/screens/movies_screen/components/movie_item.dart';
import 'package:movie_app/routes.dart';









class MoviesScreen extends StatefulWidget {
  MoviesScreen({Key? key}) : super(key: key);

  static Widget page(){
    Repository repository=Dependencies.get<Repository>();
    return BlocProvider<MoviesBloc>(
        create: (cntx)=>MoviesBloc(repository: repository),
      child: MoviesScreen(),
    );
  }

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();

    _scrollController=ScrollController()
    ..addListener(_onScroll);

    _fetchData();
    
  }


  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        centerTitle: true,
        title: Text('Movies',
          style: GoogleFonts.acme(
            color: AppColors.primaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,),
        ),
      ),
      body: BlocBuilder<MoviesBloc,MoviesState>(
        builder: (context,state){
          if(state.fetchingMoviesStatus.isSuccess){
            return ListView.builder(
              itemCount: (state.isMaxReached ?? false)
                  ?state.movies!.length
                  :state.movies!.length+1,
                controller: _scrollController,
                itemBuilder: (context,index)=>index>=state.movies!.length
                    ?MovieWidget(isLoading: true,)
                    :MovieWidget(
                  movie: state.movies!.elementAt(index),
                  onMovieClick: _onMovieClick,
                )

            );
          }else if(state.fetchingMoviesStatus.isLoading){
            return ListView(
              children:List.generate(3, (index) => MovieWidget(isLoading: true,)),
            );
          }else if(state.fetchingMoviesStatus.isError){
            return const Center(child: Text('error'),);
          }
          return const SizedBox();
        },
      )
    );
  }

  void _fetchData() {
    BlocProvider.of<MoviesBloc>(context).add(FetchMovies());
  }

  void _onMovieClick(MovieEntity movie) {
    GoRouter.of(context).go(Routes.single_movie,extra: movie);
  }

  void _onScroll() {
    if(_isBottom){
      BlocProvider.of<MoviesBloc>(context).add(FetchMovies());
    }
  }

  bool get _isBottom{
    if(!_scrollController.hasClients){
      return false;
    }
    double maxPosition=_scrollController.position.maxScrollExtent;
    double currentPosition=_scrollController.offset;
    return currentPosition>=(maxPosition*0.9);
  }

}
