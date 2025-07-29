import 'package:gallery_app/data/network/networkApiServices.dart';
import 'package:gallery_app/model/photosModel.dart';

import '../res/urls/urls.dart';

class SearchRepository{

final _apiServices = NetworkApiServices();

Future<PictureClass> getPhotos(String query)async{
  final response=await _apiServices.getApi("${AppUrls.searchPhotosApi}$query&per_page=20",{"Authorization":"M50Sce8MWKtj0lFbXcsqdQkE7cD0AZMW5uhjhLf6neCiy1pqsoFrm2B0"});
  return PictureClass.fromJson(response);
}
}