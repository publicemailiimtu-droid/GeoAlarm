import 'package:flutter/material.dart';
import '../models/alarm_rule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample initial alarms for Phase 1 UI display
  final List<AlarmRule> _alarms = [
    const AlarmRule(
      id: '1',
      title: 'Morning Wakeup',
      isEnabled: true,
      triggerType: TriggerType.time,
      timeHour: 7,
      timeMinute: 30,
    ),
    const AlarmRule(
      id: '2',
      title: 'Arrive at Office',
      isEnabled: true,
      triggerType: TriggerType.location,
      latitude: 37.7749,
      longitude: -122.4194,
      radiusMeters: 200,
      locationName: 'Headquarters',
    ),
    const AlarmRule(
      id: '3',
      title: 'Evening Grocery Reminder',
      isEnabled: false,
      triggerType: TriggerType.timeAndLocation,
      timeHour: 18,
      timeMinute: 0,
      latitude: 37.7833,
      longitude: -122.4167,
      radiusMeters: 150,
      locationName: 'Supermarket',
    ),
  ];

  void _toggleAlarm(int index, bool value) {
    setState(() {
      final old = _alarms[index];
      _alarms[index] = old.copyWith(isEnabled: value);
    });
  }

  String _formatTriggerDetails(AlarmRule alarm) {
    final details = <String>[];

    if (alarm.triggerType.requiresTime) {
      final hourStr = alarm.timeHour.toString().padLeft(2, '0');
      final minuteStr = alarm.timeMinute.toString().padLeft(2, '0');
      details.add('Time: $hourStr:$minuteStr');
    }

    if (alarm.triggerType.requiresLocation) {
      final place = alarm.locationName ?? 'Custom Location';
      final radius = alarm.radiusMeters?.toInt() ?? 0;
      details.add('Location: $place (${radius}m)');
    }

    return details.join(' • ');
  }

  IconData _getTriggerIcon(TriggerType type) {
    switch (type) {
      case TriggerType.time:
        return Icons.access_time_filled;
      case TriggerType.location:
        return Icons.location_on;
      case TriggerType.timeAndLocation:
        return Icons.edit_calendar;
      case TriggerType.timeOrLocation:
        return Icons.alt_route;
    }
  }

  String _getTriggerLabel(TriggerType type) {
    switch (type) {
      case TriggerType.time:
        return 'Time Only';
      case TriggerType.location:
        return 'Location Only';
      case TriggerType.timeAndLocation:
        return 'Time AND Location';
      case TriggerType.timeOrLocation:
        return 'Time OR Location';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoAlarm'),
        centerTitle: false,
        elevation: 0,
      ),
      body: _alarms.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alarm_off,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No alarms configured',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _alarms.length,
              itemBuilder: (context, index) {
                final alarm = _alarms[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerHigh,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        foregroundColor: theme.colorScheme.onPrimaryContainer,
                        child: Icon(_getTriggerIcon(alarm.triggerType)),
                      ),
                      title: Text(
                        alarm.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            _getTriggerLabel(alarm.triggerType),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatTriggerDetails(alarm),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      trailing: Switch(
                        value: alarm.isEnabled,
                        onChanged: (value) => _toggleAlarm(index, value),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
