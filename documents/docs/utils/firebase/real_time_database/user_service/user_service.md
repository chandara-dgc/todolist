import 'package:check_list_app/model/user/user_model.dart';
import 'package:check_list_app/utils/firebase/real_time_database/firebase_real_time_database.dart';

class UserModelDatabase extends FirebaseRealtimeDatabase<UserModel> {
  UserModelDatabase()
      : super(
          fromJson: (json) => UserModel.fromJson(json),
          toJson: (model) => model.toJson(),
        );

  @override
  String keyRef() => 'userModel';
}
