import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cielo_lio_helper/cielo_lio_helper.dart';

void main() {
  const MethodChannel channel = MethodChannel('cielo_lio_helper');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case "getEC":
          return '1111111111';
        case "getLogicNumber":
          return '12345678-9';
        case "getBatteryLevel":
          return 99;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getEC', () async {
    expect(await CieloLioHelper.ec, '1111111111');
  });

  test('getLogicNumber', () async {
    expect(await CieloLioHelper.logicNumber, '12345678-9');
  });

  test('getBatteryLevel', () async {
    expect(await CieloLioHelper.batteryLevel, 99);
  });
}
