// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateModel _$AppUpdateModelFromJson(Map<String, dynamic> json) =>
    AppUpdateModel(
      urlAndroid: json['url_android'] as String,
      urlIos: json['url_ios'] as String,
      currentVersion: json['current_version'] as String,
      optionalUpdateVersion: (json['optional_update_version'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      forceUpdateVersion: (json['force_update_version'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AppUpdateModelToJson(AppUpdateModel instance) =>
    <String, dynamic>{
      'url_android': instance.urlAndroid,
      'url_ios': instance.urlIos,
      'current_version': instance.currentVersion,
      'optional_update_version': instance.optionalUpdateVersion,
      'force_update_version': instance.forceUpdateVersion,
    };
