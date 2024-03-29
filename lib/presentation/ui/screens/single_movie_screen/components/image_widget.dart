import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_colors/app_colors.dart';
import 'package:movie_app/presentation/ui/components/shimming_widget.dart';







class ImageWidget extends StatefulWidget {
  String url;
  void Function()? onBackClicked;
  double width;
  double height;

  ImageWidget({required this.url,required this.height,required this.width,this.onBackClicked});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this,
        duration: const Duration(seconds: 10),
        reverseDuration:const Duration(seconds: 10));

    _animation=Tween<double>(begin: -1.0,end: 1.0).animate(_controller)

    ..addStatusListener(_animationStatusChanged);

    _controller.forward();

  }


  @override
  void dispose() {
    _animation.removeStatusListener(_animationStatusChanged);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          AnimatedBuilder(
            animation:_animation ,
            builder: (context,child) {
              return CachedNetworkImage(
                imageUrl: widget.url,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover,
                alignment: Alignment(_animation.value,0),
                placeholder:(context,str)=> ShimmingWidget(
                  width: widget.width,
                  height: widget.height,
                  baseColor: AppColors.scaffoldColor,
                  shimmingColor: AppColors.primaryColor,
                ),
                errorWidget: (context,str,obj)=>const Icon(Icons.image),
              );
            }
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent
                    ]
                )
            ),
          ),
          Positioned(
            top: 30,
            child: IconButton(
                onPressed:()=>widget.onBackClicked?.call(),
                icon: const Icon(Icons.arrow_back,color: Colors.white,)),
          )
        ],
      ),
    );
  }



  void _animationStatusChanged(AnimationStatus status) {
    if(status==AnimationStatus.completed){
      _controller.reverse();
    }else if(status==AnimationStatus.dismissed){
      _controller.forward();
    }
  }
}


