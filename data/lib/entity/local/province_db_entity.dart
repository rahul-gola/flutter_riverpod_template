import 'package:domain/model/province.dart';
import 'package:domain/utils/mapper/base_layer_data_tranformer.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "province")
class ProvinceDBEntity
    extends BaseLayerDataTransformer<ProvinceDBEntity, Province> {
  @primaryKey
  int? id;
  String name;

  ProvinceDBEntity({this.id, this.name = ""});

  @override
  Province transform() {
    return Province(id: id ?? -1, name: name);
  }

  @override
  ProvinceDBEntity restore(Province data) {
    id = data.id;
    name = data.name;
    return this;
  }
}
