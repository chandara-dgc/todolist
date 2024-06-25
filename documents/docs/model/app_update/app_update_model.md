import 'package:json_annotation/json_annotation.dart';

part 'app_update_model.g.dart';

@JsonSerializable()
class AppUpdateModel {
  final bool forceUpdate;
  final String updateUrlAndroid;
  final String updateUrlIos;
  final String currentVersion;

  AppUpdateModel({
    required this.forceUpdate,
    required this.updateUrlAndroid,
    required this.updateUrlIos,
    required this.currentVersion,
  });

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) => _$AppUpdateModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppUpdateModelToJson(this);
}