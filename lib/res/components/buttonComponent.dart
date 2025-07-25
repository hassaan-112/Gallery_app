import 'package:flutter/material.dart';
import '../colors/appColors.dart';


class ButtonComponent extends StatefulWidget {
  const ButtonComponent({
    super.key,
    required this.text,
    this.color = AppColors.primary,
    this.textColor = AppColors.textLightBlack,
    this.height = 50,
    this.width = 150,
    this.borderRadius = 10,
    this.isLoading = false,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double height, width;
  final double borderRadius;
  final bool isLoading;

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: widget.isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
          child: Text(widget.text, style: TextStyle(color: widget.textColor)),
        ),
      ),
    );
  }
}