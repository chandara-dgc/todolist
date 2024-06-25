import 'package:check_list_app/utils/app_print/app_print.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseLog {
  void logRealtimeDatabaseRequest(String operation, String path,
      [Map<String, dynamic>? data]) {
    AppPrint.info("┌────── Realtime Database Request ───────────────────");
    AppPrint.info("│ Operation: $operation");
    AppPrint.info("│ Path: $path");
    if (data != null) {
      AppPrint.info("│ Data: $data");
    }
    AppPrint.info("└────────────────────────────────────");
  }

  void logRealtimeDatabaseResponse(String operation, DataSnapshot? snapshot,
      [Object? error]) {
    AppPrint.error("┌────── Realtime Database Response ──────────────────");
    AppPrint.error("│ Operation: $operation");
    if (error != null) {
      AppPrint.error("│ Error: $error");
    } else {
      AppPrint.error("│ Data: ${snapshot?.value}");
    }
    AppPrint.error("└────────────────────────────────────");
  }

  Future<void> setDataInRealtimeDatabase(
      String path, Map<String, dynamic> data) async {
    final databaseRef = FirebaseDatabase.instance.ref(path);
    logRealtimeDatabaseRequest("SetData", path, data);
    try {
      await databaseRef.set(data);
      final snapshot = await databaseRef.get();
      logRealtimeDatabaseResponse("SetData", snapshot);
    } catch (e) {
      logRealtimeDatabaseResponse("SetData", null, e);
    }
  }

  Future<void> getDataFromRealtimeDatabase(String path) async {
    final databaseRef = FirebaseDatabase.instance.ref(path);
    logRealtimeDatabaseRequest("GetData", path);
    try {
      final snapshot = await databaseRef.get();
      logRealtimeDatabaseResponse("GetData", snapshot);
    } catch (e) {
      logRealtimeDatabaseResponse("GetData", null, e);
    }
  }
}
