import 'dart:io';
import 'package:check_list_app/model/app_update/app_update_model.dart';
import 'package:check_list_app/notifier/app/app_notifier.dart';
import 'package:check_list_app/utils/app_print/app_print.dart';
import 'package:check_list_app/utils/firebase/real_time_database/update_app_service/update_service.dart';
import 'package:check_list_app/utils/function/version_comparator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final updateProvider = ChangeNotifierProvider((ref) {
  final updateService = UpdateAppService();
  final versionComparator = VersionComparator();
  return UpdateNotifier(updateService, versionComparator);
});

class UpdateNotifier extends AppNotifire {
  final UpdateAppService _updateService;
  final IVersionComparator _versionComparator;
  AppUpdateModel? _updateModel;
  String? _currentAppVersion;
  UpdateBehavior _updateBehavior = UpdateBehavior.none;

  UpdateNotifier(this._updateService, this._versionComparator) {
    _initialize();
  }

  AppUpdateModel? get updateModel => _updateModel;
  String? get currentAppVersion => _currentAppVersion;
  UpdateBehavior get updateBehavior => _updateBehavior;

  Future<void> _initialize() async {
    await _fetchCurrentAppVersion();
    _startRealtimeUpdateListener();
  }

  /// [_fetchCurrentAppVersion]
  /// Check version of the app that user using
  ///
  Future<void> _fetchCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _currentAppVersion = packageInfo.version;
    notifyListeners();
  }
  
  ///[_startRealtimeUpdateListener]
  /// This function aim to listen on real time database firebase
  ///
  void _startRealtimeUpdateListener() async {
    _updateService.addUpdateListener((updateModel) {
      _updateModel = updateModel;
      notifyListeners();
      _checkAndShowUpdateDialog();
    });
  }

  bool isNewerVersion() {
    if (_updateModel == null || _currentAppVersion == null) return false;
    return _versionComparator.isNewerVersion(
        _currentAppVersion!, _updateModel!.currentVersion);
  }

  UpdateBehavior isForceUpdate(AppUpdateModel data) {
    if (data.optionalUpdateVersion.contains(_currentAppVersion)) {
      _showUpdateDialog(false);
      _updateBehavior = UpdateBehavior.optionalUpdate;
      notifyListeners();
      return UpdateBehavior.optionalUpdate;
    } else if (data.forceUpdateVersion.contains(_currentAppVersion)) {
      _showUpdateDialog(true);
      _updateBehavior = UpdateBehavior.fourceUpdate;
      notifyListeners();
      return UpdateBehavior.fourceUpdate;
    } else {
      _updateBehavior = UpdateBehavior.none;
      notifyListeners();
      return UpdateBehavior.none;
    }
  }

  void _checkAndShowUpdateDialog() {
    if (_updateModel == null) return;
    if (isNewerVersion() == true) {
      isForceUpdate(_updateModel!);
    } else {
      return;
    }
  }

  void _showUpdateDialog(bool isForceUpdate) {
    final updateUrl =
        Platform.isAndroid ? _updateModel!.urlAndroid : _updateModel!.urlIos;
    appShowDialog1(
      title: isForceUpdate ? 'Force Update Required' : 'Update Available',
      barrierDismissible: isForceUpdate ? false : true,
      enableLeftBtn: isForceUpdate ? false : true,
      enableRigthBtn: isForceUpdate ? true : true,
      subtitle: isForceUpdate
          ? 'A new version of the app is available. You must update to continue using the app.'
          : 'A new version of the app is available. Would you like to update?',
      leftBtnTxt: !isForceUpdate ? "Later" : "Update",
      rightBtnTxt: isForceUpdate ? "Update" : "Update",
      actionLeftBtn: () {
        Navigator.of(appContext!).pop();
      },
      actionRightBtn: () {
        _launchURL(updateUrl);
      },
    );
  }

  void _launchURL(String url) async {
    final openUri = Uri.parse(url);
    if (!await launchUrl(openUri)) {
      throw Exception('Could not launch $openUri');
    }
  }

  Future<void> checkForUpdate() async {
    await _updateService.fetch();
    notifyListeners();
  }

  Future<void> setContent() async {
    final appUpdateModel = AppUpdateModel(
      urlAndroid: "example.com",
      urlIos: "urlIos.com",
      currentVersion: "1.0.0",
      optionalUpdateVersion: ["1.0.0"],
      forceUpdateVersion: ["0.0.0"],
    );
    await _updateService.set(appUpdateModel);
  }
}

enum UpdateBehavior { fourceUpdate, optionalUpdate, none }
