//
//
// import 'package:gallery_app/data/response/status.dart';
//
// class ApiResponse<T>{
//
//   Status status;
//   T? data;
//   String? message;
//
//   ApiResponse(this.data, this.message, this.status);
//
//   ApiResponse.loading() : status=Status.LOADING;
//   ApiResponse.completed(): status = Status.COMPLETED;
//   ApiResponse.error(): status=Status.ERROR;
//
//
//   @override
//   String toString(){
//     return "status $status message $message data $data";
//   }
//
// }