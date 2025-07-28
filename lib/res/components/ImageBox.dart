import 'package:flutter/material.dart';

import '../colors/appColors.dart';
class ImageBox extends StatelessWidget {
  double height;
  double width;
  Color color;
  double borderRadius;
  String text;
  FileImage? image;

  ImageBox({super.key, required this.height, required this.width, this.color=AppColors.geryContainer,required this.borderRadius,this.text="No Image",required this.image});
  @override
  Widget build(BuildContext context) {
    return image==null?Container(
      height:height,
      width:width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    ):Container(
      height:height,
      width:width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        image:DecorationImage(image:image!,fit: BoxFit.cover)
      ),

    );
  }
}
