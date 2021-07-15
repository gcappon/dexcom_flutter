import 'package:dexcom_flutter/src/utils/formats.dart';

/// An enumerator for the days of the week this [AlertScheduleSettings] value applies to.
enum AlertScheduleSettingsDayOfWeek {
  /// Monday
  MONDAY,

  /// Tuesday
  TUESDAY,

  /// Wednesday
  WEDNESDAY,

  /// Thursday
  THURSDAY,

  /// Friday
  FRIDAY,

  /// Saturday
  SATURDAY,

  /// Sunday
  SUNDAY,
}

/// AlertScheduleSettingsDayOfWeek

/// [AlertScheduleSettings] is a class implementing the data model of the [alertScheduleSettings]. 
/// array of an [AlertSchedule].
class AlertScheduleSettings {
  /// The name of the [AlertScheduleSettings].
  final String? alertScheduleSettingsName;

  /// Decribes whether the user has the alert schedule enabled on their display device.
  final bool enabled;

  /// The default schedule is the alert schedule used in the absence of other applicable alert schedules
  final bool defaultSchedule;

  /// The time each day when the alert schedule begins corresponds to the device's display time
  final DateTime startTime;

  /// The time each day when the alert schedule ends corresponds to the device's display time
  final DateTime endTime;

  /// An array containing [AlertScheduleSettingsDayOfWeek] this alert schedule value applies to; this array must contain one (or more) of the following strings in English: "sunday", "monday", "tuesday", "wednesday", "thursday", "friday" and/or "saturday"
  List<AlertScheduleSettingsDayOfWeek> alertScheduleSettingsDaysOfWeek;

  /// Default [AlertScheduleSettings] constructor.
  AlertScheduleSettings({
    this.alertScheduleSettingsName,
    required this.enabled,
    required this.defaultSchedule,
    required this.startTime,
    required this.endTime,
    required this.alertScheduleSettingsDaysOfWeek,
  });

  /// Generates a [AlertScheduleSettings] obtained from a json.
  factory AlertScheduleSettings.fromJson({required Map<String, dynamic> json}) {
    return AlertScheduleSettings(
      alertScheduleSettingsName: json['alertScheduleSettingName'],
      enabled: json['isEnabled'],
      defaultSchedule: json['isDefaultSchedule'],
      startTime: Formats.onlyTimeNoSeconds.parse(json['startTime']),
      endTime: Formats.onlyTimeNoSeconds.parse(json['endTime']),
      alertScheduleSettingsDaysOfWeek: json['daysOfWeek'].map<AlertScheduleSettingsDayOfWeek>((str) {
        final AlertScheduleSettingsDayOfWeek ret;
        if (str == "monday") {
          ret = AlertScheduleSettingsDayOfWeek.MONDAY;
        } else if (str == "tuesday") {
          ret = AlertScheduleSettingsDayOfWeek.TUESDAY;
        } else if (str == "wednesday") {
          ret = AlertScheduleSettingsDayOfWeek.WEDNESDAY;
        } else if (str == "thursday") {
          ret = AlertScheduleSettingsDayOfWeek.THURSDAY;
        } else if (str == "friday") {
          ret = AlertScheduleSettingsDayOfWeek.FRIDAY;
        } else if (str == "saturday") {
          ret = AlertScheduleSettingsDayOfWeek.SATURDAY;
        } else {
          ret = AlertScheduleSettingsDayOfWeek.SUNDAY;
        } // if
        return ret;
      }).toList(),
    );
  } // fromJson

  @override
  String toString() {
    return (StringBuffer('AlertScheduleSettings(')
          ..write('alertScheduleSettingsName: $alertScheduleSettingsName, ')
          ..write('enabled: $enabled, ')
          ..write('defaultSchedule: $defaultSchedule, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write(
              'alertScheduleSettingsDaysOfWeek: $alertScheduleSettingsDaysOfWeek ')
          ..write(')'))
        .toString();
  } // toString

  /// Converts the [AlertScheduleSettings] to a json.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'alertScheduleSettingsName': alertScheduleSettingsName,
      'enabled': enabled,
      'defaultSchedule': defaultSchedule,
      'startTime': Formats.onlyTimeNoSeconds.format(startTime),
      'endTime': Formats.onlyTimeNoSeconds.format(endTime),
      'daysOfWeek': alertScheduleSettingsDaysOfWeek.map((dow) {
        final String ret;
        if (dow == AlertScheduleSettingsDayOfWeek.MONDAY) {
          ret = "monday";
        } else if (dow == AlertScheduleSettingsDayOfWeek.TUESDAY) {
          ret = "tuesday";
        } else if (dow == AlertScheduleSettingsDayOfWeek.WEDNESDAY) {
          ret = "wednesday";
        } else if (dow == AlertScheduleSettingsDayOfWeek.THURSDAY) {
          ret = "thursday";
        } else if (dow ==  AlertScheduleSettingsDayOfWeek.FRIDAY) {
          ret = "friday";
        } else if (dow == AlertScheduleSettingsDayOfWeek.SATURDAY) {
          ret = "saturday";
        } else {
          ret = "sunday";
        } // if
        return ret;
      }),
    };
  } // toJson

} // AlertScheduleSettings
