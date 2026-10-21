import 'package:flutter_test/flutter_test.dart';
import 'package:geoalarm/main.dart';

void main() {
  testWidgets('GeoAlarm app launches and renders home screen title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GeoAlarmApp());

    expect(find.text('GeoAlarm'), findsOneWidget);
    expect(find.text('Morning Wakeup'), findsOneWidget);
  });
}
