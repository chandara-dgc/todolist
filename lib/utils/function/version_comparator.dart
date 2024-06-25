class NewOrEqualModel {
  final bool isNew;
  final bool isEqual;
  NewOrEqualModel({required this.isNew, required this.isEqual});
}

abstract class IVersionComparator {
  bool isNewerVersion(String currentVersion, String latestVersion);
  NewOrEqualModel isNewerVersionOrEqual(
      String currentVersion, String latestVersion);
}

class VersionComparator implements IVersionComparator {
  @override
  bool isNewerVersion(String currentVersion, String latestVersion) {
    final current = currentVersion.split('.').map(int.parse).toList();
    final latest = latestVersion.split('.').map(int.parse).toList();

    int length =
        current.length > latest.length ? current.length : latest.length;

    for (int i = 0; i < length; i++) {
      int currentValue = i < current.length ? current[i] : 0;
      int latestValue = i < latest.length ? latest[i] : 0;

      if (latestValue > currentValue) return true;
      if (latestValue < currentValue) return false;
    }
    return false;
  }

  @override
  NewOrEqualModel isNewerVersionOrEqual(
      String currentVersion, String latestVersion) {
    final current = currentVersion.split('.').map(int.parse).toList();
    final latest = latestVersion.split('.').map(int.parse).toList();

    int length =
        current.length > latest.length ? current.length : latest.length;

    bool isNew = false;
    bool isEqual = true;

    for (int i = 0; i < length; i++) {
      int currentValue = i < current.length ? current[i] : 0;
      int latestValue = i < latest.length ? latest[i] : 0;

      if (latestValue > currentValue) {
        isNew = true;
        isEqual = false;
        break;
      } else if (latestValue < currentValue) {
        isNew = false;
        isEqual = false;
        break;
      }
    }

    return NewOrEqualModel(isNew: isNew, isEqual: isEqual);
  }
}
