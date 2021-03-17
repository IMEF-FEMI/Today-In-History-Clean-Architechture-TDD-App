// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:test/test.dart';
void main() {
  group('testing app funtionality', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });
  });
}
