import 'package:check_list_app/config/flavors.dart';
import 'package:check_list_app/main.dart' as runner;
import 'package:check_list_app/utils/firebase/Firebase_manager.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  F.appFlavor = Flavor.prod;
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseManager.initPlatformFirebase(Flavor.prod);
  await runner.main();
}
