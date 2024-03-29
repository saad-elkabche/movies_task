import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/constants/app_colors/app_colors.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/ui/components/shimming_widget.dart';







class MovieWidget extends StatelessWidget {
  bool? isLoading;
  MovieEntity? movie;
  void Function(MovieEntity)? onMovieClick;
  late double width;
  late double height;

  MovieWidget({this.isLoading,this.movie,this.onMovieClick}){
    assert(movie!=null || (isLoading ?? false));
  }

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    width=MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: (){
        if(movie!=null){
          onMovieClick?.call(movie!);
        }
      },
      child: Container(
        width: width*0.9,
        clipBehavior: Clip.hardEdge,

        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor,width: 1),
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(20)
        ),
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(),
            const SizedBox(height: 10,),
            title(),
            const SizedBox(height: 10,),
            description()
          ],
        ),
      ),
    );
  }

  Widget _image() {
    if(isLoading?? false){
      return ShimmingWidget(
          width: width*0.9,
          height: 200,
          baseColor: AppColors.scaffoldColor,
          shimmingColor: AppColors.primaryColor,
      );
    }else{

      return SizedBox(
        width: width*0.9,
        height: 200,
        child: Stack(
          alignment: Alignment.bottomRight,
          //fit: StackFit.expand,
          children: [
            CachedNetworkImage(
                imageUrl: movie!.fullBackDropPath,
              width: width*0.9,
              fit: BoxFit.fill,
              placeholder:(context,str)=> ShimmingWidget(
                width: width*0.9,
                height: 200,
                baseColor: AppColors.scaffoldColor,
                shimmingColor: AppColors.primaryColor,
              ),
              errorWidget: (context,str,obj)=>const Icon(Icons.image),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ]
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star,color: Colors.amber,),
                      Text(
                        '${movie!.voteAverage!.toStringAsFixed(1)}',
                        style: GoogleFonts.acme(
                            fontSize: 18,
                            color:AppColors.textColor,
                            fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Text(
                    '(${movie!.voteCount})',
                    style: GoogleFonts.acme(
                        fontSize: 12,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.normal),),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  Widget title() {
    if(isLoading ?? false){
      return Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: ShimmingWidget(
            width: 200,
            height: 15,
            baseColor: AppColors.scaffoldColor,
            shimmingColor: AppColors.primaryColor,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${movie!.title}',
        style: GoogleFonts.acme(
          fontSize: 25,
            color:AppColors.textColor,
            fontWeight: FontWeight.bold),),
    );
  }

  Widget description() {
    if(isLoading ?? false){
      return Padding(
        padding: const EdgeInsets.only(left: 10.0,bottom: 10),
        child: ShimmingWidget(
            width: 250,
            height: 20,
            baseColor: AppColors.scaffoldColor,
            shimmingColor: AppColors.primaryColor,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0,left: 10,right: 10),
      child: Text('${movie!.overview}',

        style: GoogleFonts.acme(
            fontWeight: FontWeight.normal,
            color:AppColors.textColor),),
    );
  }

}

