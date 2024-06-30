import 'package:bot_toast/bot_toast.dart';
import 'package:check_list_app/widget/core/loading_widget.dart';
import 'package:flutter/material.dart';

mixin Toast {
  showLoading() {
    BotToast.showCustomLoading(toastBuilder: (callback) {
      return const Loading();
    });
  }

  hideLoading() {
    BotToast.closeAllLoading();
  }

  showToast(String text) {
    BotToast.showText(text: text);
  }

  clearAll() {
    BotToast.cleanAll();
  }

  void showToastNotification({
    required String title,
    required BuildContext context,
    Duration? duration,
    String? subtitle,
    Color? backgroundColor,
    Widget? leading,
    Function? onClose,
  }) {
    // BuildContext _context = context ?? NavigationService.navigationKey.currentContext!;
    BotToast.showNotification(
      crossPage: false,
      duration: duration,
      leading: (_) => AspectRatio(
        aspectRatio: 1 / 1.5,
        child: Container(
          alignment: Alignment.centerRight,
          child: leading,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      title: (_) => Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      backgroundColor:
          backgroundColor ?? Theme.of(context).badgeTheme.backgroundColor,
      subtitle: (_) => Text(
        subtitle ?? "",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.75)),
      ),
      onClose: () => {
        onClose != null ? onClose() : () {},
      },
    );
  }
}
