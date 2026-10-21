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

    test(
      'copyWith() preserves untouched fields and allows updating fields',
      () {
        const original = AlarmRule(
          id: '10',
          title: 'Original Alarm',
          isEnabled: true,
          triggerType: TriggerType.time,
          timeHour: 9,
          timeMinute: 15,
          latitude: 12.34,
          longitude: 56.78,
          radiusMeters: 100,
          locationName: 'Home',
        );

        final updated = original.copyWith(
          title: 'Updated Title',
          isEnabled: false,
        );

        expect(updated.id, equals('10'));
        expect(updated.title, equals('Updated Title'));
        expect(updated.isEnabled, isFalse);
        expect(updated.triggerType, equals(TriggerType.time));
        expect(updated.timeHour, equals(9));
        expect(updated.timeMinute, equals(15));
        expect(updated.latitude, equals(12.34));
        expect(updated.longitude, equals(56.78));
        expect(updated.radiusMeters, equals(100));
        expect(updated.locationName, equals('Home'));
      },
    );

    test('copyWith() allows explicitly clearing nullable fields to null', () {
      const original = AlarmRule(
        id: '11',
        title: 'Full Alarm',
        triggerType: TriggerType.timeAndLocation,
        timeHour: 8,
        timeMinute: 30,
        latitude: 37.7749,
        longitude: -122.4194,
        radiusMeters: 200,
        locationName: 'Office',
      );

      final cleared = original.copyWith(
        timeHour: null,
        timeMinute: null,
        latitude: null,
        longitude: null,
        radiusMeters: null,
        locationName: null,
      );

      expect(cleared.id, equals('11'));
      expect(cleared.title, equals('Full Alarm'));
      expect(cleared.timeHour, isNull);
      expect(cleared.timeMinute, isNull);
      expect(cleared.latitude, isNull);
      expect(cleared.longitude, isNull);
      expect(cleared.radiusMeters, isNull);
      expect(cleared.locationName, isNull);
    });

    test('fromJson() throws FormatException for invalid triggerType', () {
      final invalidJson = {
        'id': '99',
        'title': 'Bad Json Alarm',
        'triggerType': 'unknownType',
      };

      expect(
        () => AlarmRule.fromJson(invalidJson),
        throwsA(isA<FormatException>()),
      );
    });

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
