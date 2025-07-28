import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
        title: Text("Home",style: Theme.of(context).textTheme.displayMedium,),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
        }, icon: Icon(Get.isDarkMode?Icons.light_mode:Icons.dark_mode))
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("localImages".tr,style: Theme.of(context).textTheme.displayMedium,),
              IconButton(onPressed: (){
                Get.toNamed('/addImageScreen');
              }, icon: Icon(Icons.add_a_photo_outlined))
              ],
            ),
            15.verticalSpace,
            SizedBox(
              height: 500.h,

              child: GridView.builder(
                  itemCount: 111,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 3.r,mainAxisSpacing: 3.r), itemBuilder: (context, index) {
              return Container(color: Colors.grey,);
              }),
            )
          ]
        ),
      )
    );
  }
}
