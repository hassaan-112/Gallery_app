abstract class BaseApiServices{

  Future<dynamic> getApi(String url,Map<String,String> header);
  Future<dynamic> postApi(dynamic data, String url);
}