import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
      throw OtherExceptions('Something went wrong $e');
    }
    return ResponseJson;

  }




  @override
  Future postApi(var data, String url) async{

    print("network api");
    try{
      final responce =await http.post(Uri.parse(url),body: data).timeout(Duration(seconds: 10));
      ResponseJson = ReturnResponse(responce);
    }
    on SocketException {
      throw InternetExceptions('No Internet');
    }
    catch(e){
      throw OtherExceptions('Something went wrong $e');
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
        throw BadRequestException("bad request${response.body}");

      default:
        throw OtherExceptions("Something went wrong ${response.statusCode}");
    }
  }
}