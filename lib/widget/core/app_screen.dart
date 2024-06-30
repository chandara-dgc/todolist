import 'package:check_list_app/notifier/update_app/update_app_notifire.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class AppScreen extends HookConsumerWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(updateProvider.notifier);
    return PopScope(
      canPop: true,
      child: buildScreen(context, ref),
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref);
}
