import 'package:check_list_app/notifier/update_app/update_app_notifire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AppScreen extends ConsumerWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateNotifier = ref.read(updateProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateNotifier.checkForUpdate();
    });
    return buildScreen(context, ref);
  }

  Widget buildScreen(BuildContext context, WidgetRef ref);
}
