import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Workouts page', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('has a title in the app bar', () async {
      final title = find.byValueKey('app-bar-title');
      await driver.waitFor(title);
    });

    test('has empty workouts list when it first starts', () async {
      final emptyMessageText = find.byValueKey('empty-message');
      await driver.waitFor(emptyMessageText);
      //expect(await driver.getText(counterTextFinder), "0");
    });

    test('has a button for adding a new workout', () async {
      final label = find.byValueKey('new-workout-fab-label');
      await driver.waitFor(label);
    });
  });
}
