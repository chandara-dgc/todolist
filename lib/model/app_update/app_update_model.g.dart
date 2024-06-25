// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateModel _$AppUpdateModelFromJson(Map<String, dynamic> json) =>
    AppUpdateModel(
      forceUpdate: json['forceUpdate'] as bool,
      updateUrlAndroid: json['updateUrlAndroid'] as String,
      updateUrlIos: json['updateUrlIos'] as String,
      currentVersion: json['currentVersion'] as String,
    );

Map<String, dynamic> _$AppUpdateModelToJson(AppUpdateModel instance) =>
    <String, dynamic>{
      'forceUpdate': instance.forceUpdate,
      'updateUrlAndroid': instance.updateUrlAndroid,
      'updateUrlIos': instance.updateUrlIos,
      'currentVersion': instance.currentVersion,
    };
