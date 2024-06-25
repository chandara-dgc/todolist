import 'package:firebase_database/firebase_database.dart';

abstract class FirebaseRealtimeDatabase<T> {
  final T Function(Map<String, dynamic> json) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  late final DatabaseReference _dbRef;

  FirebaseRealtimeDatabase({
    required this.fromJson,
    required this.toJson,
  }) {
    _dbRef = FirebaseDatabase.instance.ref().child(keyRef());
  }

  String keyRef();

  Future<T?> getUpdateInfo() async {
    try {
      DatabaseEvent event = await _dbRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        return fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }
    } catch (e) {
      print('Error fetching update info: $e');
    }
    return null;
  }

  Future<bool> setUpdateInfo(T updateInfo) async {
    try {
      await _dbRef.set(toJson(updateInfo));
      return true;
    } catch (e) {
      print('Error setting update info: $e');
      return false;
    }
  }

  Future<bool> deleteUpdateInfo() async {
    try {
      await _dbRef.remove();
      return true;
    } catch (e) {
      print('Error deleting update info: $e');
      return false;
    }
  }

  Future<bool> updateUpdateInfo(T updateInfo) async {
    try {
      await _dbRef.update(toJson(updateInfo));
      return true;
    } catch (e) {
      print('Error updating update info: $e');
      return false;
    }
  }
}
