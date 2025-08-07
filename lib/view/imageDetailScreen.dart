import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/res/colors/appColors.dart';
import 'package:gallery_app/res/components/richTextComponent.dart';
import 'package:gallery_app/view_model/searchVM.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../res/components/buttonComponent.dart';
import '../utils/Utils.dart';

class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchVM = Get.put(SearchViewModel());
    searchVM.showOptions = true.obs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: PhotoViewGallery.builder(
        itemCount: searchVM.pictureClass!.photos!.length,
        pageController: PageController(
          initialPage: searchVM.selectedIndex.value,
        ),
        scrollPhysics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        builder: (context, index) {
          final photo = searchVM.pictureClass!.photos![index];

          return PhotoViewGalleryPageOptions.customChild(
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      searchVM.showOptions.value = !searchVM.showOptions.value;
                    },
                    child: PhotoView(
                      imageProvider: NetworkImage(photo.src!.medium!),
                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      heroAttributes: PhotoViewHeroAttributes(tag: photo.url!),
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
                        height: 90.h,
                        width: Get.width,
                        color: AppColors.darkBgColor,
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${"pic_id".tr}: ${photo.id}",
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.white),
                                ),
                                40.horizontalSpace,
                                IconButton(
                                  onPressed: () {
                                    searchVM.downloadingStatus.value == false
                                        ? searchVM.saveToGallery(photo.src!.original!)
                                        : Utils.toast("wait".tr, AppColors.negativeRed);
                                  },
                                  icon: const Icon(Icons.download_outlined,color: AppColors.white,),
                                ),
                                10.horizontalSpace,
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 10.h,
                                            ),
                                            child: Container(
                                              height: 300.h,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).cardColor,
                                                borderRadius: BorderRadius.circular(20.r),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      RichTextComponent("photographer".tr, photo.photographer!, context),
                                                      10.verticalSpace,
                                                      RichTextComponent("photographer_url".tr, photo.photographerUrl!, context),
                                                      10.verticalSpace,
                                                      RichTextComponent("photographer_id".tr, photo.photographerId!.toString(), context),
                                                      10.verticalSpace,
                                                      RichTextComponent("description".tr, photo.alt!, context),
                                                      30.verticalSpace,
                                                      ButtonComponent(
                                                        text: "okay".tr,
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        width: double.infinity,
                                                        textColor: Theme.of(context).hintColor,
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
                                  icon: const Icon(Icons.info_outline_rounded,color: AppColors.white,),
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
      ),
    );
  }
}
