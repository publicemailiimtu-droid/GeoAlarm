import 'package:flutter_test/flutter_test.dart';
import 'package:geoalarm/models/alarm_rule.dart';

void main() {
  group('AlarmRule Model & Validation Tests', () {
    test('Valid time alarm rule passes validation', () {
      const alarm = AlarmRule(
        id: '1',
        title: 'Morning Alarm',
        triggerType: TriggerType.time,
        timeHour: 8,
        timeMinute: 30,
      );

      expect(alarm.isValid, isTrue);
      expect(alarm.validate(), isNull);
    });

    test('Time alarm rule with invalid hour fails validation', () {
      const alarm = AlarmRule(
        id: '2',
        title: 'Invalid Time Alarm',
        triggerType: TriggerType.time,
        timeHour: 25,
        timeMinute: 0,
      );

      expect(alarm.isValid, isFalse);
      expect(alarm.validate(), contains('Valid time hour (0-23) is required'));
    });

    test('Valid location alarm rule passes validation', () {
      const alarm = AlarmRule(
        id: '3',
        title: 'Office Geofence',
        triggerType: TriggerType.location,
        latitude: 37.7749,
        longitude: -122.4194,
        radiusMeters: 200,
        locationName: 'Work',
      );

      expect(alarm.isValid, isTrue);
      expect(alarm.validate(), isNull);
    });

    test('Location alarm rule with invalid radius fails validation', () {
      const alarm = AlarmRule(
        id: '4',
        title: 'Invalid Location Alarm',
        triggerType: TriggerType.location,
        latitude: 37.7749,
        longitude: -122.4194,
        radiusMeters: 0,
      );

      expect(alarm.isValid, isFalse);
      expect(
        alarm.validate(),
        contains('Valid radius (> 0 meters) is required'),
      );
    });

    test(
      'Combined timeAndLocation trigger requires both time and location',
      () {
        const incompleteAlarm = AlarmRule(
          id: '5',
          title: 'Combined Alarm Incomplete',
          triggerType: TriggerType.timeAndLocation,
          timeHour: 10,
          timeMinute: 0,
        );

        expect(incompleteAlarm.isValid, isFalse);

        const completeAlarm = AlarmRule(
          id: '6',
          title: 'Combined Alarm Complete',
          triggerType: TriggerType.timeAndLocation,
          timeHour: 10,
          timeMinute: 0,
          latitude: 40.7128,
          longitude: -74.0060,
          radiusMeters: 100,
        );

        expect(completeAlarm.isValid, isTrue);
      },
    );

    test('AlarmRule toJson and fromJson roundtrip correctly', () {
      const original = AlarmRule(
        id: '7',
        title: 'JSON Test Alarm',
        isEnabled: false,
        triggerType: TriggerType.timeOrLocation,
        timeHour: 15,
        timeMinute: 45,
        latitude: 51.5074,
        longitude: -0.1278,
        radiusMeters: 300,
        locationName: 'London Office',
      );

      final jsonMap = original.toJson();
      final restored = AlarmRule.fromJson(jsonMap);

      expect(restored.id, equals(original.id));
      expect(restored.title, equals(original.title));
      expect(restored.isEnabled, equals(original.isEnabled));
      expect(restored.triggerType, equals(original.triggerType));
      expect(restored.timeHour, equals(original.timeHour));
      expect(restored.timeMinute, equals(original.timeMinute));
      expect(restored.latitude, equals(original.latitude));
      expect(restored.longitude, equals(original.longitude));
      expect(restored.radiusMeters, equals(original.radiusMeters));
      expect(restored.locationName, equals(original.locationName));
      expect(restored.isValid, isTrue);
    });
  });
}
