import 'package:firebase_database/firebase_database.dart';

class FirebaseLog {
  void logRealtimeDatabaseRequest(String operation, String path,
      [Map<String, dynamic>? data]) {
    print("┌────── Realtime Database Request ───────────────────");
    print("│ Operation: $operation");
    print("│ Path: $path");
    if (data != null) {
      print("│ Data: $data");
    }
    print("└────────────────────────────────────");
  }

  void logRealtimeDatabaseResponse(String operation, DataSnapshot? snapshot,
      [Object? error]) {
    print("┌────── Realtime Database Response ──────────────────");
    print("│ Operation: $operation");
    if (error != null) {
      print("│ Error: $error");
    } else {
      print("│ Data: ${snapshot?.value}");
    }
    print("└────────────────────────────────────");
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
