import 'package:check_list_app/utils/function/version_comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  IVersionComparator comparator = VersionComparator();

  test('Test 1: 1.123.342 vs 3.2.4', () {
    expect(comparator.isNewerVersion("1.123.342", "3.2.4"), true);
  });

  test('Test 2: 3.2.4 vs 3.2.4', () {
    expect(comparator.isNewerVersion("3.2.4", "3.2.4"), false);
  });

  test('Test 3: 3.2.3 vs 3.2.4', () {
    expect(comparator.isNewerVersion("3.2.3", "3.2.4"), true);
  });

  test('Test 4: 3.2.4 vs 3.2.3', () {
    expect(comparator.isNewerVersion("3.2.4", "3.2.3"), false);
  });

  test('Test 5: 3.2 vs 3.2.1', () {
    expect(comparator.isNewerVersion("3.2", "3.2.1"), true);
  });

  test('Test 6: 3.2.1 vs 3.2', () {
    expect(comparator.isNewerVersion("3.2.1", "3.2"), false);
  });

  test('Test 7: 1.0.0 vs 1.0.0.1', () {
    expect(comparator.isNewerVersion("1.0.0", "1.0.0.1"), true);
  });

  test('Test 8: 2.0 vs 2.0.0', () {
    expect(comparator.isNewerVersion("2.0", "2.0.0"), false);
  });
}
