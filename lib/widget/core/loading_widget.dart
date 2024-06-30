import 'package:check_list_app/constants/config_constant.dart';
import 'package:check_list_app/widget/core/app_widget.dart';
import 'package:flutter/material.dart';

class Loading extends AppWidget {
  const Loading({Key? key, this.loading = true}) : super(key: key);
  final bool loading;
  @override
  Widget buildAppWidget(BuildContext context) {
    if (loading) {
      return Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ConfigConstant.radius2),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: const CircularProgressIndicator(),
      );
    } else {
      return const Text("Loaded");
    }
  }
}


