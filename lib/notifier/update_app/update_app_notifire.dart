import 'dart:io';
import 'package:check_list_app/model/app_update/app_update_model.dart';
import 'package:check_list_app/notifier/app/app_notifier.dart';
import 'package:check_list_app/utils/firebase/real_time_database/update_app_service/update_service.dart';
import 'package:check_list_app/utils/function/version_comparator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final updateProvider = ChangeNotifierProvider<UpdateNotifier>((ref) {
  final updateService = UpdateAppService();
  final versionComparator = VersionComparator();
  return UpdateNotifier(updateService, versionComparator);
});

class UpdateNotifier extends AppNotifire {
  final UpdateAppService _updateService;
  final IVersionComparator _versionComparator;
  AppUpdateModel? _updateModel;
  String? _currentAppVersion;

  UpdateNotifier(this._updateService, this._versionComparator) {
    _initialize();
  }

  AppUpdateModel? get updateModel => _updateModel;
  String? get currentAppVersion => _currentAppVersion;

  Future<void> _initialize() async {
    await _fetchCurrentAppVersion();
    _startRealtimeUpdateListener();
  }

  Future<void> _fetchCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _currentAppVersion = packageInfo.version;
    notifyListeners();
  }

  void _startRealtimeUpdateListener() {
    _updateModel = _updateService.fromJson as AppUpdateModel;
    notifyListeners();
    _checkAndShowUpdateDialog();
  }

  bool isOptionalUpdateAvailable() {
    if (_updateModel == null || _currentAppVersion == null) return false;
    return _versionComparator.isNewerVersion(
        _currentAppVersion!, _updateModel!.currentVersion);
  }

  void _checkAndShowUpdateDialog() {
    if (_updateModel == null) return;

    if (_updateModel!.forceUpdate) {
      _showUpdateDialog(true);
    } else if (isOptionalUpdateAvailable()) {
      _showUpdateDialog(false);
    }
  }

  void _showUpdateDialog(bool isForceUpdate) {
    final updateUrl = Platform.isAndroid
        ? _updateModel!.updateUrlAndroid
        : _updateModel!.updateUrlIos;
    appShowDialog(
      title: isForceUpdate ? 'Force Update Required' : 'Update Available',
      enableLeftBtn: !isForceUpdate,
      enableRigthBtn: isForceUpdate,
      subtitle: isForceUpdate
          ? 'A new version of the app is available. You must update to continue using the app.'
          : 'A new version of the app is available. Would you like to update?',
      leftBtnTxt: !isForceUpdate ? "Later" : "",
      rightBtnTxt: isForceUpdate ? "Update" : "",
      actionLeftBtn: () {
        Navigator.of(appContext!).pop();
      },
      actionRightBtn: () {
        Navigator.of(appContext!).pop();
        _launchURL(updateUrl);
      },
    );
  }

  void _launchURL(String url) async {
    // if (await launchUrl(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  Future<void> checkForUpdate() async {
    await _updateService.getUpdateInfo();
    notifyListeners();
  }

  void callMepapa() {
    // Your function implementation
    print("callMepapa called!");
  }
}
