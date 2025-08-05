import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/res/colors/appColors.dart';
import 'package:gallery_app/view_model/searchVM.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../res/components/buttonComponent.dart';

class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final searchVM = Get.put(SearchViewModel());
    searchVM.showOptions=true.obs;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: PhotoViewGallery.builder(
        itemCount: searchVM.pictureClass!.photos!.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions.customChild(
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      searchVM.showOptions.value = !searchVM.showOptions.value;
                    },
                    child: PhotoView(
                      imageProvider: NetworkImage(
                        searchVM.pictureClass!.photos![index].src!.medium!,
                      ),
                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      heroAttributes: PhotoViewHeroAttributes(
                        tag: searchVM.pictureClass!.photos![index].url!,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Positioned(
                    top: 0,
                    child: Visibility(
                      visible: searchVM.showOptions.value,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: 100.h,
                        width: Get.width,
                        color: AppColors.darkBgColor,
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  "Picture id: ${searchVM.pictureClass!.photos![index].id}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                10.horizontalSpace,
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,

                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 10.h,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(
                                                  context,
                                                ).cardColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                    20.r,
                                                  ),
                                                  topRight: Radius.circular(
                                                    20.r,
                                                  ),
                                                  bottomLeft: Radius.circular(
                                                    20.r,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    20.r,
                                                  ),
                                                ),
                                              ),
                                              height: 300.h,
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              "photographer".tr,
                                                          style: Theme.of(
                                                            context,
                                                          ).textTheme.bodyLarge,
                                                          children: [
                                                            TextSpan(
                                                              text: searchVM
                                                                  .pictureClass!
                                                                  .photos![searchVM
                                                                      .selectedIndex
                                                                      .value]
                                                                  .photographer!,
                                                              style:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      10.verticalSpace,
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              "photographer_id".tr,
                                                          style: Theme.of(
                                                            context,
                                                          ).textTheme.bodyLarge,
                                                          children: [
                                                            TextSpan(
                                                              text: searchVM
                                                                  .pictureClass!
                                                                  .photos![searchVM
                                                                  .selectedIndex
                                                                  .value]
                                                                  .photographerId!.toString(),
                                                              style:
                                                              Theme.of(
                                                                context,
                                                              )
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      10.verticalSpace,
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                          "description".tr,
                                                          style: Theme.of(
                                                            context,
                                                          ).textTheme.bodyLarge,
                                                          children: [
                                                            TextSpan(
                                                              text: searchVM
                                                                  .pictureClass!
                                                                  .photos![searchVM
                                                                  .selectedIndex
                                                                  .value]
                                                                  .alt!,
                                                              style:
                                                              Theme.of(
                                                                context,
                                                              )
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      30.verticalSpace,

                                                      ButtonComponent(
                                                        text: "Okay",
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        width: double.infinity,
                                                        textColor: Theme.of(
                                                          context,
                                                        ).hintColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.info_outline_rounded),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        pageController: PageController(
          initialPage: searchVM.selectedIndex.value,
        ),
        scrollPhysics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// width: double.infinity,
// height: 400.h,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(
// searchVM
//     .pictureClass!
//     .photos![searchVM.selectedIndex.value]
//     .src!
//     .medium!,
// ),
// fit: BoxFit.fill,
// ),
// ),
// ),
// Container(
// width: double.infinity,
// height: 1.h,
// color: AppColors.borderGrey,
// ),
// 20.verticalSpace,
// Padding(
// padding: EdgeInsets.symmetric(horizontal: 10.r),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// RichText(
// text: TextSpan(
// text: "photographer".tr,
// style: Theme.of(context).textTheme.bodyLarge,
// children: [
// TextSpan(
// text: searchVM
//     .pictureClass!
//     .photos![searchVM.selectedIndex.value]
//     .photographer!,
// style: Theme.of(context).textTheme.bodyMedium,
// ),
// ],
// ),
// ),
// RichText(
// text: TextSpan(
// text: "photographer_id".tr,
// style: Theme.of(context).textTheme.bodyLarge,
// children: [
// TextSpan(
// text: searchVM
//     .pictureClass!
//     .photos![searchVM.selectedIndex.value]
//     .photographerId!
//     .toString(),
// style: Theme.of(context).textTheme.bodyMedium,
// ),
// ],
// ),
// ),
// 5.verticalSpace,
// RichText(
// text: TextSpan(
// text: "description".tr,
// style: Theme.of(context).textTheme.bodyLarge,
// children: [
// TextSpan(
// text: searchVM
//     .pictureClass!
//     .photos![searchVM.selectedIndex.value]
//     .alt!,
// style: Theme.of(context).textTheme.bodyMedium,
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// ],
// ),
