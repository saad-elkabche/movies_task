import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/constants/app_colors/app_colors.dart';





class MessageWidget extends StatelessWidget {
  String message;
  String image;
  MessageWidget({required this.image,required this.message});

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.sizeOf(context).width;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(image,fit: BoxFit.cover,width: width*0.7,),
          SizedBox(height: 15,),
          Text(message,
            style: GoogleFonts.acme(
              color: AppColors.textColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

