import 'package:json_annotation/json_annotation.dart';

import 'error.dart';

part 'error_response_entity.g.dart';

@JsonSerializable()
class ErrorResponseEntity {
  @JsonKey(name: "error")
  Error error;

  ErrorResponseEntity(this.error);

  factory ErrorResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseEntityToJson(this);
}
