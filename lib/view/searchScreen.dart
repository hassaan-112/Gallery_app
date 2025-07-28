import 'package:flutter/material.dart';
import 'package:gallery_app/res/components/TextFormFieldComponent.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../view_model/SearchVM.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchVM=Get.put(SearchViewModel());
    return Scaffold(
      appBar: AppBar(
        title: Text("search".tr),
        centerTitle: true,
      ), 
      body: Column(children: [
        TextFormFieldComponent(hintText: "search".tr, controller: searchVM.controller.value, keyboardType: TextInputType.text, focusNode: searchVM.focusNode.value, validator: (value){}, onSubmited: (value){}, onTapedOutside: (){ searchVM.focusNode.value.unfocus(); })
      ],)
    );
  }
}
