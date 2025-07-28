import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../res/colors/appColors.dart';
import '../view_model/HomeScreenVM.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeScreenVM = Get.put(HomeScreenViewModel());
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
            );
          },
          icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "localImages".tr,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed('/addImageScreen');
                  },
                  icon: Icon(Icons.add_a_photo_outlined),
                ),
              ],
            ),
            15.verticalSpace,
            SizedBox(
              height: 500.h,

              child: Obx(
                () => GridView.builder(
                  itemCount: homeScreenVM.images.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Get.width < 400 ? 2 : Get.width<600?3:Get.width<800?4:5,
                    crossAxisSpacing: 3.r,
                    mainAxisSpacing: 3.r,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(width: .5, color: Colors.grey),
                        image: DecorationImage(
                          image: FileImage(homeScreenVM.images[index]),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                      Positioned(top: 0,right: 0,child: Container(height: 40.r,width: 40.r,decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.2),borderRadius: BorderRadius.circular(50)) ,child: Center(child: IconButton(onPressed: (){homeScreenVM.removeImage(index);}, icon: Icon(Icons.delete)))),),

                    ],);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
