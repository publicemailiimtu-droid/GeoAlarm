enum TriggerType {
  time,
  location,
  timeAndLocation,
  timeOrLocation;

  bool get requiresTime =>
      this == TriggerType.time ||
      this == TriggerType.timeAndLocation ||
      this == TriggerType.timeOrLocation;

  bool get requiresLocation =>
      this == TriggerType.location ||
      this == TriggerType.timeAndLocation ||
      this == TriggerType.timeOrLocation;
}

class AlarmRule {
  final String id;
  final String title;
  final bool isEnabled;
  final TriggerType triggerType;

  // Time trigger properties
  final int? timeHour;
  final int? timeMinute;

  // Location trigger properties
  final double? latitude;
  final double? longitude;
  final double? radiusMeters;
  final String? locationName;

  const AlarmRule({
    required this.id,
    required this.title,
    this.isEnabled = true,
    required this.triggerType,
    this.timeHour,
    this.timeMinute,
    this.latitude,
    this.longitude,
    this.radiusMeters,
    this.locationName,
  });

  /// Validates whether the alarm rule has all required valid parameters
  /// for its selected trigger type. Returns null if valid, or an error message.
  String? validate() {
    if (id.trim().isEmpty) {
      return 'Alarm ID cannot be empty.';
    }
    if (title.trim().isEmpty) {
      return 'Alarm title cannot be empty.';
    }

    if (triggerType.requiresTime) {
      if (timeHour == null || timeHour! < 0 || timeHour! > 23) {
        return 'Valid time hour (0-23) is required for time triggers.';
      }
      if (timeMinute == null || timeMinute! < 0 || timeMinute! > 59) {
        return 'Valid time minute (0-59) is required for time triggers.';
      }
    }

    if (triggerType.requiresLocation) {
      if (latitude == null || latitude! < -90 || latitude! > 90) {
        return 'Valid latitude (-90 to 90) is required for location triggers.';
      }
      if (longitude == null || longitude! < -180 || longitude! > 180) {
        return 'Valid longitude (-180 to 180) is required for location triggers.';
      }
      if (radiusMeters == null || radiusMeters! <= 0) {
        return 'Valid radius (> 0 meters) is required for location triggers.';
      }
    }

    return null;
  }

  bool get isValid => validate() == null;

  AlarmRule copyWith({
    String? id,
    String? title,
    bool? isEnabled,
    TriggerType? triggerType,
    int? timeHour,
    int? timeMinute,
    double? latitude,
    double? longitude,
    double? radiusMeters,
    String? locationName,
  }) {
    return AlarmRule(
      id: id ?? this.id,
      title: title ?? this.title,
      isEnabled: isEnabled ?? this.isEnabled,
      triggerType: triggerType ?? this.triggerType,
      timeHour: timeHour ?? this.timeHour,
      timeMinute: timeMinute ?? this.timeMinute,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      locationName: locationName ?? this.locationName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isEnabled': isEnabled,
      'triggerType': triggerType.name,
      'timeHour': timeHour,
      'timeMinute': timeMinute,
      'latitude': latitude,
      'longitude': longitude,
      'radiusMeters': radiusMeters,
      'locationName': locationName,
    };
  }

  factory AlarmRule.fromJson(Map<String, dynamic> json) {
    return AlarmRule(
      id: json['id'] as String,
      title: json['title'] as String,
      isEnabled: json['isEnabled'] as bool? ?? true,
      triggerType: TriggerType.values.firstWhere(
        (e) => e.name == json['triggerType'],
        orElse: () => TriggerType.time,
      ),
      timeHour: json['timeHour'] as int?,
      timeMinute: json['timeMinute'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      radiusMeters: (json['radiusMeters'] as num?)?.toDouble(),
      locationName: json['locationName'] as String?,
    );
  }
}
