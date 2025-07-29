import 'dart:io';
import 'package:flutter/material.dart';
import '../colors/appColors.dart';
class ImageBox extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double borderRadius;
  final String text;
  final File? image;
  final bool update;
  const ImageBox({super.key, required this.height, required this.width, this.color=AppColors.geryContainer,required this.borderRadius,this.text="no image",required this.image,required this.update});
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
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        image:DecorationImage(image:FileImage(image!),fit: BoxFit.fill)
      ),

    );
  }
}
