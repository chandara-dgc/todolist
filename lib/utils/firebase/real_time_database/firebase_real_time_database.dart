import 'package:check_list_app/utils/types/type.dart';
import 'package:firebase_database/firebase_database.dart';

/// A generic abstract class for interacting with Firebase Realtime Database.
///
/// The class provides methods to fetch, set, update, and delete data,
/// as well as to check the connection status and add listeners for updates.
///
/// Type parameter [T] represents the model class that will be used with the database.
abstract class FirebaseRealtimeDatabase<T> {
  final JsonToModel<T> fromJson;
  final ModelToJson<T> toJson;
  late final DatabaseReference _dbRef;

  /// Constructs a [FirebaseRealtimeDatabase] with the provided JSON serialization functions.
  ///
  /// The [fromJson] function converts a JSON map to a model object of type [T].
  /// The [toJson] function converts a model object of type [T] to a JSON map.
  FirebaseRealtimeDatabase({
    required this.fromJson,
    required this.toJson,
  }) {
    _dbRef = FirebaseDatabase.instance.ref().child(keyRef());
  }

  /// Returns the key reference for the Firebase database path.
  ///
  /// This method must be implemented by subclasses to specify the
  /// database path for the data.
  String keyRef();

  /// Fetches the update information from the database.
  ///
  /// Retrieves the data at the specified database reference path and
  /// converts it to a model object of type [T] using the [fromJson] function.
  /// Returns `null` if no data is found or if an error occurs.
  Future<T?> fetchUpdateInfo() async {
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

  /// Sets the update information in the database.
  ///
  /// Converts the provided [updateInfo] model object to a JSON map using
  /// the [toJson] function and sets it at the specified database reference path.
  /// Returns `true` if the operation is successful, `false` otherwise.
  Future<bool> setUpdateInfo(T updateInfo) async {
    try {
      await _dbRef.set(toJson(updateInfo));
      return true;
    } catch (e) {
      print('Error setting update info: $e');
      return false;
    }
  }

  /// Deletes the update information from the database.
  ///
  /// Removes the data at the specified database reference path.
  /// Returns `true` if the operation is successful, `false` otherwise.
  Future<bool> deleteUpdateInfo() async {
    try {
      await _dbRef.remove();
      return true;
    } catch (e) {
      print('Error deleting update info: $e');
      return false;
    }
  }

  /// Updates the update information in the database.
  ///
  /// Converts the provided [updateInfo] model object to a JSON map using
  /// the [toJson] function and updates it at the specified database reference path.
  /// Returns `true` if the operation is successful, `false` otherwise.
  Future<bool> updateUpdateInfo(T updateInfo) async {
    try {
      await _dbRef.update(toJson(updateInfo));
      return true;
    } catch (e) {
      print('Error updating update info: $e');
      return false;
    }
  }

  /// Checks if there is an active connection to the database.
  ///
  /// Returns `true` if connected to the Firebase Realtime Database, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final DatabaseReference connectedRef =
          FirebaseDatabase.instance.ref('.info/connected');
      final DatabaseEvent event = await connectedRef.once();
      return event.snapshot.value == true;
    } catch (e) {
      print('Error checking connection status: $e');
      return false;
    }
  }

  /// Adds a listener to the database reference.
  ///
  /// The provided [onData] callback is called whenever there is a change
  /// at the specified database reference path. The callback receives the updated
  /// data as a model object of type [T] or `null` if the data is deleted.
  void addUpdateListener(void Function(T?) onData) {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value != null
          ? fromJson(Map<String, dynamic>.from(event.snapshot.value as Map))
          : null;
      onData(data);
    });
  }
}