import 'package:get/get.dart';

class NavBarViewModel extends GetxController{
  RxInt _index =0.obs;

  get index => _index.value;
  void setIndex(int index){
    _index.value = index;
  }
}