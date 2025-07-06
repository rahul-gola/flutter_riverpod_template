import 'package:data/entity/remote/response/province/province_entity.dart';
import 'package:domain/model/province.dart';
import 'package:domain/utils/mapper/base_layer_data_tranformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'province_response_entity.g.dart';

@JsonSerializable()
class ProvinceResponseEntity
    extends BaseLayerDataTransformer<ProvinceResponseEntity, List<Province>> {
  ProvinceResponseEntity({
    this.provinces = const [],
    this.error = false,
    this.message = '',
  });

  factory ProvinceResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ProvinceResponseEntityFromJson(json);
  @JsonKey(name: 'error', defaultValue: false, includeIfNull: false)
  bool error;

  @JsonKey(name: 'message', defaultValue: '', includeIfNull: false)
  String message;

  @JsonKey(name: 'provinsi')
  List<ProvinceEntity> provinces;

  Map<String, dynamic> toJson() => _$ProvinceResponseEntityToJson(this);

  @override
  List<Province> transform() {
    return provinces.map<Province>((e) => e.transform()).toList();
  }

  @override
  ProvinceResponseEntity restore(List<Province> data) {
    return ProvinceResponseEntity(
      provinces: data
          .map(
            (province) => ProvinceEntity(
              id: province.id,
              name: province.name,
            ),
          )
          .toList(),
    );
  }
}
