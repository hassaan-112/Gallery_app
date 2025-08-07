import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/res/components/buttonComponent.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../res/colors/appColors.dart';
import '../res/components/richTextComponent.dart';
import '../utils/Utils.dart';
import '../view_model/localImage.dart';

class ImageDetailview extends StatefulWidget {
  const ImageDetailview({super.key});

  @override
  State<ImageDetailview> createState() => _ImageDetailviewState();
}

class _ImageDetailviewState extends State<ImageDetailview> {
  @override
  Widget build(BuildContext context) {
    final homeVM = Get.find<LocalImagesViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("image_detail".tr),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 750.h,
        child: Obx(
              () => PhotoViewGallery.builder(
            itemCount: homeVM.images.length,
            pageController: PageController(
              initialPage: homeVM.selectedIndex.value,
            ),
            scrollPhysics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            builder: (context, index) {
              final image = homeVM.images[index];
              final meta = homeVM.localImages[index];

              return PhotoViewGalleryPageOptions.customChild(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          homeVM.detail.value = !homeVM.detail.value;
                        },
                        child: PhotoView(
                          imageProvider: FileImage(image),
                          minScale: PhotoViewComputedScale.contained * 1,
                          maxScale: PhotoViewComputedScale.covered * 2,
                          heroAttributes: PhotoViewHeroAttributes(
                            tag: image.path,
                          ),
                        ),
                      ),
                    ),

                    // Top Info Bar
                    Obx(
                          () => Visibility(
                        visible: homeVM.detail.value,
                        child: Container(
                          height: 90.h,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withAlpha(80),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Utils.dateToString(meta.date!),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColors.white),
                              ),
                              Text(
                                Utils.timeToAmPm(meta.date!),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Bottom Actions Bar
                    Obx(
                          () => Positioned(
                        bottom: 0,
                        child: Visibility(
                          visible: homeVM.detail.value,
                          child: Container(
                            height: 90.h,
                            width: Get.width,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withAlpha(80),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Download Button
                                IconButton(
                                  onPressed: () {
                                    homeVM.downloadingStatus.value == false
                                        ? homeVM.saveToGallery(image.path)
                                        : Utils.toast(
                                      "wait".tr,
                                      AppColors.negativeRed,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.download_outlined,
                                    color: AppColors.white,
                                  ),
                                ),

                                // Delete Button
                                IconButton(
                                  onPressed: () {
                                    homeVM.removeImage(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline_outlined,
                                    color: AppColors.white,
                                  ),
                                ),

                                // Info Button
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
                                              height: 400.h,
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
                                                      RichTextComponent("name".tr, meta.title!, context),
                                                      15.verticalSpace,
                                                      RichTextComponent("description".tr, meta.description!, context),
                                                      15.verticalSpace,
                                                      RichTextComponent("date".tr, Utils.dateToString(meta.date!), context),
                                                      15.verticalSpace,
                                                      RichTextComponent("time".tr, Utils.timeToAmPm(meta.date!), context),
                                                      15.verticalSpace,
                                                      RichTextComponent("size".tr, "${image.lengthSync() ~/ 1024} Kb", context),
                                                      15.verticalSpace,
                                                      RichTextComponent("path".tr, image.toString(), context),
                                                      30.verticalSpace,
                                                      ButtonComponent(
                                                        text: "okay".tr,
                                                        onPressed: () => Get.back(),
                                                        width: double.infinity,
                                                        textColor: AppColors.white,
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
                                  icon: const Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
