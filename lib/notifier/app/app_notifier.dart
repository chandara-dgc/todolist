import 'package:check_list_app/router/app_router.dart';
import 'package:check_list_app/utils/app_print/app_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppNotifire extends ChangeNotifier {
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
    required bool barrierDismissible,
    String? subtitle,
    String? leftBtnTxt,
    String? rightBtnTxt,
    Function? actionLeftBtn,
    Function? actionRightBtn,
  }) {
    if (appContext == null) {
      return;
    }

    AppPrint.debug(
        "MaterialLocalizations.of(appContext!).modalBarrierDismissLabel =>${MaterialLocalizations.of(appContext!).modalBarrierDismissLabel}");
    AppPrint.debug("barrierDismissible =>$barrierDismissible");
    showGeneralDialog(
      context: appContext!,
      barrierColor: Colors.black54, // Customize the barrier color
      transitionDuration: const Duration(milliseconds: 270),
      barrierLabel:
          MaterialLocalizations.of(appContext!).modalBarrierDismissLabel,
      barrierDismissible: barrierDismissible,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: AlertDialog(
              title: Text(title),
              content: Text(subtitle ?? ""),
              actions: [
                if (enableLeftBtn)
                  TextButton(
                    child: Text(leftBtnTxt!),
                    onPressed: () {
                      actionLeftBtn!();
                    },
                  ),
                if (enableRigthBtn)
                  TextButton(
                    child: Text(rightBtnTxt!),
                    onPressed: () {
                      actionRightBtn!();
                    },
                  ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  void appShowDialog1({
    required String title,
    required bool enableLeftBtn,
    required bool enableRigthBtn,
    required bool barrierDismissible,
    String? subtitle,
    String? leftBtnTxt,
    String? rightBtnTxt,
    Function? actionLeftBtn,
    Function? actionRightBtn,
  }) {
    if (appContext == null) {
      return;
    }
    AppPrint.debug("barrierDismissible => $barrierDismissible");
    showGeneralDialog(
      context: appContext!,
      barrierColor: Colors.black54, // Customize the barrier color
      barrierLabel:
          MaterialLocalizations.of(appContext!).modalBarrierDismissLabel,
      barrierDismissible: barrierDismissible,
      transitionDuration: const Duration(milliseconds: 270),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: PopScope(
              canPop: barrierDismissible,
              child: AlertDialog(
                title: Text(title),
                content: Text(subtitle ?? ""),
                actions: [
                  if (enableLeftBtn)
                    TextButton(
                      child: Text(leftBtnTxt!),
                      onPressed: () {
                        actionLeftBtn!();
                      },
                    ),
                  if (enableRigthBtn)
                    TextButton(
                      child: Text(rightBtnTxt!),
                      onPressed: () {
                        actionRightBtn!();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  void setLoading(bool isLoading) {}
}

final appNotifire = ChangeNotifierProvider<AppNotifire>((ref) {
  return AppNotifire();
});
