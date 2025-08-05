import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/res/components/buttonComponent.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../res/components/richTextComponent.dart';
import '../utils/Utils.dart';
import '../view_model/homeScreenVM.dart';

class ImageDetailview extends StatefulWidget {
  const ImageDetailview({super.key});

  @override
  State<ImageDetailview> createState() => _ImageDetailviewState();
}

class _ImageDetailviewState extends State<ImageDetailview> {
  @override
  Widget build(BuildContext context) {
    final homeVM = Get.find<HomeScreenViewModel>();

    int _index = homeVM.selectedIndex.value;
    return Scaffold(
      appBar: AppBar(title: Text("image_detail".tr), centerTitle: true),
      body: SizedBox(
        height: 750.h,
        child: Obx(
          () => PhotoViewGallery.builder(
            itemCount: homeVM.images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions.customChild(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          homeVM.detail.value = !homeVM.detail.value;
                        },
                        child: PhotoView(
                          imageProvider: FileImage(homeVM.images[index]),
                          minScale: PhotoViewComputedScale.contained * 1,
                          maxScale: PhotoViewComputedScale.covered * 2,
                          heroAttributes: PhotoViewHeroAttributes(
                            tag: homeVM.images[index].path,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: homeVM.detail.value,
                        child: Container(
                          height: 90.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.3),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(Utils.dateToString(homeVM.localImages[index].date!),style: Theme.of(context).textTheme.titleLarge,), Text(Utils.timeToAmPm(homeVM.localImages[index].date!))],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Positioned(
                        bottom: 0,
                        child: Visibility(
                          visible: homeVM.detail.value,
                          child: Container(
                            height: 90.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.3),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.share),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    homeVM.removeImage(index);
                                  },
                                  icon: Icon(Icons.delete_outline_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,

                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.w ,vertical: 10.h),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:Theme.of(context).cardColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20.r),
                                                  topRight: Radius.circular(20.r),
                                                  bottomLeft: Radius.circular(20.r),
                                                  bottomRight: Radius.circular(20.r),
                                                ),
                                              ),
                                              height: 400.h,
                                              child: Center(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      RichTextComponent("Name", homeVM.localImages[index].title!, context),
                                                      15.verticalSpace,
                                                      RichTextComponent("Description", homeVM.localImages[index].description!, context),
                                                      15.verticalSpace,
                                                      RichTextComponent("Date", Utils.dateToString(homeVM.localImages[index].date!), context),
                                                      15.verticalSpace,
                                                      RichTextComponent("Time", Utils.timeToAmPm(homeVM.localImages[index].date!), context),
                                                      15.verticalSpace,
                                                      RichTextComponent("Size", "${homeVM.images[index].lengthSync() ~/ 1024} Kb", context),
                                                      15.verticalSpace,
                                                      RichTextComponent("Path", homeVM.images[index].toString(), context),

                                                      30.verticalSpace,
                                                      ButtonComponent(text: "Okay", onPressed:(){Get.back();},width: double.infinity,textColor: Theme.of(context).hintColor)

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
                  ],
                ),
              );
            },
            pageController: PageController(
              initialPage: homeVM.selectedIndex.value,
            ),
            scrollPhysics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}
