import 'package:check_list_app/model/app_update/app_update_model.dart';
import 'package:check_list_app/utils/firebase/real_time_database/firebase_real_time_database.dart';

class UpdateAppService extends FirebaseRealtimeDatabase<AppUpdateModel> {
  UpdateAppService()
      : super(
          fromJson: (json) => AppUpdateModel.fromJson(json),
          toJson: (model) => model.toJson(),
        );

  @override
  String keyRef() => 'appUpdate';
}
