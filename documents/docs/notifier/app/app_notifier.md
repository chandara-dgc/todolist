import 'package:check_list_app/router/app_router.dart';
import 'package:flutter/material.dart';

abstract class AppNotifire extends ChangeNotifier {
  final BuildContext? _context = navigatorKey.currentContext;
  BuildContext? get appContext => _context;

  void textSnackBar({
    required String title,
  }) {
    if (appContext == null) return;
    ScaffoldMessenger.of(appContext!).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }

  void appShowDialog({
    required String title,
    required bool enableLeftBtn,
    required bool enableRigthBtn,
    String? subtitle,
    String? leftBtnTxt,
    String? rightBtnTxt,
    Function? actionLeftBtn,
    Function? actionRightBtn,
  }) {
    if (appContext == null) {
      return;
    }
    showDialog(
      context: appContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle ?? ""),
          actions: [
            if (enableLeftBtn && leftBtnTxt != null && actionLeftBtn != null)
              TextButton(
                child: Text(leftBtnTxt),
                onPressed: () {
                  actionLeftBtn();
                },
              ),
            if (rightBtnTxt != null && actionRightBtn != null && enableRigthBtn)
              TextButton(
                child: Text(rightBtnTxt),
                onPressed: () {
                  actionRightBtn();
                },
              ),
          ],
        );
      },
    );
  }
  
}
