import 'package:domain/model/province.dart';
import 'package:domain/utils/mapper/base_layer_data_tranformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'province_entity.g.dart';

@JsonSerializable()
class ProvinceEntity with BaseLayerDataTransformer<ProvinceEntity, Province> {
  final int id;

  @JsonKey(name: "nama")
  final String name;

  ProvinceEntity({this.id = -1, this.name = ""});

  factory ProvinceEntity.fromJson(Map<String, dynamic> json) =>
      _$ProvinceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceEntityToJson(this);

  @override
  Province transform() {
    return Province(id: id, name: name);
  }

  @override
  ProvinceEntity restore(Province data) {
    return ProvinceEntity(id: data.id, name: data.name);
  }
}
