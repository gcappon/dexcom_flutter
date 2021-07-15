import 'package:dexcom_flutter/src/data/alertSetting.dart';
import 'package:dexcom_flutter/src/data/alertScheduleSettings.dart';
/// [AlertSchedule] is a class implementing the data model of an element of the [alertScheduleList] 
/// array of a [DexcomDeviceData].
class AlertSchedule{

  /// [AlertScheduleSettings] associated with each [AlertSchedule].
  AlertScheduleSettings alertScheduleSettings;

  /// Array of [AlertSetting] for the [DexcomDeviceData] as of the [lastUploadDate].
  List<AlertSetting> alertSettings;

  /// Default [AlertSchedule] constructor.
  AlertSchedule({
    required this.alertScheduleSettings,
    required this.alertSettings,
  });

  /// Generates a [AlertSchedule] obtained from a json.
  factory AlertSchedule.fromJson({required Map<String, dynamic> json}) {
    return AlertSchedule(
      alertScheduleSettings: AlertScheduleSettings.fromJson(json: json['alertScheduleSettings']),
      alertSettings: json['alertSettings'].map<AlertSetting>((alSet) => AlertSetting.fromJson(json: alSet)).toList(),
    );
  } // AlertSchedule.fromJson


  @override
  String toString() {
    return (StringBuffer('AlertSchedule(')
          ..write('alertScheduleSettings: $alertScheduleSettings, ')
          ..write('alertSettings: $alertSettings ')
          ..write(')'))
        .toString();
  } // toString

  Map<String, dynamic> toJson() {

    return <String, dynamic>{
      'alertScheduleSettings': alertScheduleSettings.toJson(),
      'alertSettings': alertSettings.map((alSet) => alSet.toJson()),
    };
  } // toJson

}// AlertSchedule
