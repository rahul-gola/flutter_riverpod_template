// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceResponseEntity _$ProvinceResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ProvinceResponseEntity(
      provinces: (json['provinsi'] as List<dynamic>?)
              ?.map((e) => ProvinceEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      error: json['error'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$ProvinceResponseEntityToJson(
        ProvinceResponseEntity instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'provinsi': instance.provinces,
    };
