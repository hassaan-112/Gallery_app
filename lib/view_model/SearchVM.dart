import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends GetxController{
  final controller=TextEditingController().obs;
  final focusNode=FocusNode().obs;
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  RxBool isSearch=false.obs;
  RxBool isLoading=false.obs;



}