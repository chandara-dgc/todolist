import 'package:json_annotation/json_annotation.dart';

part 'app_update_model.g.dart';

@JsonSerializable()
class AppUpdateModel {
  @JsonKey(name: 'url_android')
  final String urlAndroid;

  @JsonKey(name: 'url_ios')
  final String urlIos;

  @JsonKey(name: 'current_version')
  final String currentVersion;

  @JsonKey(name: 'optional_update_version')
  final List<String> optionalUpdateVersion;

  @JsonKey(name: 'force_update_version')
  final List<String> forceUpdateVersion;

  AppUpdateModel({
    required this.urlAndroid,
    required this.urlIos,
    required this.currentVersion,
    required this.optionalUpdateVersion,
    required this.forceUpdateVersion,
  });

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) => _$AppUpdateModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppUpdateModelToJson(this);
}