import 'package:flutter/material.dart';

abstract class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildAppWidget(context);
  }

  Widget buildAppWidget(BuildContext context);
}
