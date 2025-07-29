import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/res/colors/appColors.dart';
import 'package:gallery_app/view_model/searchVM.dart';
import 'package:get/get.dart';

class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final searchVM = Get.put(SearchViewModel());
    return Scaffold(
      appBar: AppBar(title: Text("image_detail".tr), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 400.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  searchVM
                      .pictureClass!
                      .photos![searchVM.selectedIndex.value]
                      .src!
                      .medium!,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.h,
            color: AppColors.borderGrey,
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "photographer".tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: searchVM
                            .pictureClass!
                            .photos![searchVM.selectedIndex.value]
                            .photographer!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "photographer_id".tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: searchVM
                            .pictureClass!
                            .photos![searchVM.selectedIndex.value]
                            .photographerId!
                            .toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                5.verticalSpace,
                RichText(
                  text: TextSpan(
                    text: "description".tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: searchVM
                            .pictureClass!
                            .photos![searchVM.selectedIndex.value]
                            .alt!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
