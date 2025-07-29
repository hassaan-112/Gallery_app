import 'package:flutter/material.dart';
import 'package:gallery_app/res/components/textFormFieldComponent.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/response/status.dart';
import '../res/colors/appColors.dart';
import '../utils/Utils.dart';
import '../view_model/searchVM.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchVM = Get.put(SearchViewModel());
    return Scaffold(
      appBar: AppBar(title: Text("search".tr), centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            TextFormFieldComponent(
              hintText: "search".tr,
              controller: searchVM.controller.value,
              keyboardType: TextInputType.text,
              focusNode: searchVM.focusNode.value,
              validator: (value) {return null;},
              onSubmited: (value) {
                if (value == "") {
                  searchVM.status.value = Status.IDLE;
                } else if (searchVM.status == Status.LOADING) {
                } else {
                  searchVM.search();
                  searchVM.focusNode.value.unfocus();
                }
              },
              onTapedOutside: (val) {
                searchVM.focusNode.value.unfocus();
              },
              suffixIcon: Icons.search,
              suffixIconbuttonfunction: () {
                if (searchVM.controller.value.text == "") {
                  searchVM.status.value = Status.IDLE;
                  Utils.toast("enter_text".tr, AppColors.negativeRed);
                }
                else if (searchVM.status != Status.LOADING) {
                  searchVM.search();
                  searchVM.focusNode.value.unfocus();
                }
              },
            ),
            30.verticalSpace,
            Obx(() {
              switch (searchVM.status.value) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.COMPLETED:
                  return Expanded(

                    child:

                  GridView.builder(
                    itemCount: searchVM.pictureClass!.photos!.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Get.width < 400 ? 2 : Get.width<600?3:Get.width<800?4:5,
                      crossAxisSpacing: 3.r,
                      mainAxisSpacing: 3.r,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          searchVM.setSelectedIndex(index);
                          Get.toNamed('/imageDetailScreen');
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(width: .5, color: Colors.grey),
                            image: DecorationImage(
                              image: NetworkImage(searchVM.pictureClass!.photos![index].src!.medium!),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      );
                    },
                  ),



                    );
                case Status.ERROR:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${searchVM.error.value} "),
                        ElevatedButton(
                          onPressed: () {
                            searchVM.status.value = Status.LOADING;
                            searchVM.search();
                          },
                          child: Text("try_again".tr),
                        ),
                      ],
                    ),
                  );
                  case Status.IDLE:
                    return Center(child:Text("search_something".tr));
              }
            }),
          ],
        ),
      ),
    );
  }
}
