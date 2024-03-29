import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/constants/app_colors/app_colors.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/ui/components/shimming_widget.dart';
import 'package:movie_app/presentation/ui/screens/single_movie_screen/components/image_widget.dart';





class SignleMovieScreen extends StatelessWidget {
  MovieEntity movieEntity;

  SignleMovieScreen({required this.movieEntity}) ;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body:SingleChildScrollView(
        child: Column(
          children: [
            ImageWidget(url: movieEntity.fullBackDropPath,
                height: height*0.45,
                width: width,
              onBackClicked: ()=>onBackClick(context),
            ),
            _title(),
            _desciption(),
          ],
        ),
      )
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${movieEntity.title}\n(${movieEntity.formatedReleasDate})',
              style: GoogleFonts.acme(
                fontSize: 20,
                  color:AppColors.textColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star,color: Colors.amber,),
                  Text(movieEntity.voteAverage!.toStringAsFixed(1),
                    style: GoogleFonts.acme(
                        fontSize: 18,
                        color:AppColors.textColor,
                        fontWeight: FontWeight.bold),),
                ],
              ),
              Text(
                '(${movieEntity.voteCount})',
                style: GoogleFonts.acme(
                    fontSize: 12,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.normal),),
            ],
          )
        ],
      ),
    );
  }

  Widget _desciption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text('${movieEntity.overview}',

        style: GoogleFonts.acme(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color:AppColors.textColor),
      ),
    );
  }

  onBackClick(BuildContext context) {
    GoRouter.of(context).pop();
  }


}

