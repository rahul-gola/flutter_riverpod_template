import 'package:data/entity/remote/response/province_response_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

//flutter pub run build_runner build
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @GET("/daerahindonesia/provinsi")
  Future<HttpResponse<ProvinceResponseEntity>> getProvince();
}
