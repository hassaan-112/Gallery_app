import 'package:flutter/material.dart';

import '../colors/appColors.dart';

class TextFormFieldComponent extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FormFieldValidator validator;
  final FormFieldSetter onSubmited;
  final bool enabled, autoFocus;
  final Function onTapedOutside;
  final suffixIcon;
  final suffixIconbuttonfunction;


  const TextFormFieldComponent({super.key,
    required this.hintText,
    this.obscureText=false,
    required this.controller,
    required this.keyboardType,
    required this.focusNode,
    required this.validator,
    required this.onSubmited,
    this.enabled=true,
    this.autoFocus=false,
    required this.onTapedOutside,
    this.suffixIcon=null,
    this.suffixIconbuttonfunction=null,
  });

  @override
  State<TextFormFieldComponent> createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmited,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      autofocus: widget.autoFocus,

      onTapOutside: (event){
        widget.onTapedOutside(event);
      },
      decoration: InputDecoration(
        suffixIcon:IconButton(onPressed: widget.suffixIconbuttonfunction, icon: Icon(widget.suffixIcon)),
        hintText: widget.hintText,
        border: OutlineInputBorder(),
        focusedBorder: border(AppColors.borderGrey),
        enabledBorder: border(AppColors.borderGrey),
        errorBorder: border(AppColors.negativeRed),
        focusedErrorBorder: border(AppColors.negativeRed),


      ),
    );
  }
}
OutlineInputBorder border(Color color)=> OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(color: color),

);