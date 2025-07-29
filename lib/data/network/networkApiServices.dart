import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../appExceptions.dart';
import 'baseApiServices.dart';



class NetworkApiServices extends BaseApiServices{
  var ResponseJson;
  @override
  Future getApi(String url,Map<String,String> header) async {
    try{
      final responce =await http.get(Uri.parse(url),headers:header).timeout(Duration(seconds: 10));
      ResponseJson = ReturnResponse(responce);
    }
    on SocketException {
      throw InternetExceptions("");
    }
    on TimeoutException{
      throw TimeOutExceptions("");
    }
    catch(e){
      throw OtherExceptions("${"something_wrong".tr}$e");
    }
    return ResponseJson;

  }




  @override
  Future postApi(var data, String url) async{

    try{
      final responce =await http.post(Uri.parse(url),body: data).timeout(Duration(seconds: 10));
      ResponseJson = ReturnResponse(responce);
    }
    on SocketException {
      throw InternetExceptions("no_internet".tr);
    }
    catch(e){
      throw OtherExceptions("${"something_wrong".tr}$e");
    }
    return ResponseJson;
  }


  dynamic ReturnResponse(http.Response response) {
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        // dynamic responseJson = jsonDecode(response.body);
        // return responseJson;
        throw BadRequestException("${"bad_request".tr}${response.body}");

      default:
        throw OtherExceptions("${"something_wrong".tr}${response.statusCode}");
    }
  }
}