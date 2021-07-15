import 'package:dexcom_flutter/src/utils/formats.dart';

///An enumerator for the name of the [AlertSetting].
enum AlertSettingName{
  /// Triggers on a glucose value that crosses the High value.
  HIGH,

  /// Triggers on a glucose value that crosses the Low value.
  LOW,
  
  /// Triggers on a glucose rate that crosses a Rise Rate value.
  RISE,

  /// Triggers on a glucose rate that crosses a Fall Rate value
  FALL,

  /// Triggers on a glucose value that crosses the Urgent Low value
  URGENT_LOW,

  /// Triggers when system is predicting the user will fall below the Urgent Low value in the near future
  URGENT_LOW_SOON,

  /// Triggers an alert when the display is out of communication range after the programmed delay; corresponds to the Signal Loss alert
  OUT_OF_RANGE,

  /// Triggers when the display device stops receiving EGV data from the transmitter for a certain amount of time; corresponds to the No Readings alert
  NO_READINGS,
  
}// AlertSettingName

/// An enumerator for the unit of measurement of the [value] of the [AlertSetting].
enum AlertSettingUnit{
  
  /// mg/dL
  MG_DL,

  /// mmol/L
  MMOL_L,

  /// mg/dL/min
  MG_DL_MIN,
  
  /// mmol/L/min
  MMOL_L_MIN,

  /// minutes
  MINUTES,
  
}/// AlertSettingUnit

/// [AlertSetting] is a class implementing the data model of an element of the [alertSettings]. 
/// array of an [AlertSchedule].
class AlertSetting{

  /// The name of the [AlertSetting].
  final AlertSettingName alertSettingName;

  /// The value at which the alert is set. 
  /// - For [AlertSettingName.HIGH] alert: 120 - 400 mg/dL
  /// - For [AlertSettingName.LOW] alert: 60 - 100 mg/dL
  /// - For [AlertSettingName.RISE] alert: 2 or 3 mg/dL/min
  /// - For [AlertSettingName.FALL] alert: 2 or 3 mg/dL/min
  /// - For [AlertSettingName.URGENT_LOW] alert: 55 mg/dL (not user-editable)
  /// - For [AlertSettingName.URGENT_LOW_SOON] alert: 55 mg/dL (not user-editable)
  /// - For [AlertSettingName.OUT_OF_RANGE] alert: 20 - 240 minutes
  /// - For [AlertSettingName.NO_READINGS] alert: 20 minutes (not user-editable)
  double? value; 

  /// Unit of measurement for the alert [value].
  AlertSettingUnit? alertSettingUnit;

  /// Time (in minutes) before resuming alarming after the alert has been acknowledged and cleared.
  double? snooze;

  /// Indication of whether or not the alert is enabled on the device.
  bool enabled;

  /// Time according to the system clock when alert setting was last adjusted by the user; nominally UTC.
  DateTime systemTime;

  /// Display time when alert setting was last adjusted by the user.
  DateTime displayTime;

  /// Default [AlertSetting] constructor.
  AlertSetting({
    required this.alertSettingName,
    this.value,
    this.alertSettingUnit,
    this.snooze,
    required this.enabled,
    required this.systemTime,
    required this.displayTime,
  });

  /// Generates a [AlertSetting] obtained from a json.
  factory AlertSetting.fromJson({required Map<String, dynamic> json}) {

    final AlertSettingName alertSettingName;
    if(json['alertName'] == "high"){
      alertSettingName = AlertSettingName.HIGH;
    } else if(json['alertName'] == "low"){
      alertSettingName = AlertSettingName.LOW;
    } else if(json['alertName'] == "rise"){
      alertSettingName = AlertSettingName.RISE;
    } else if(json['alertName'] == "fall"){
      alertSettingName = AlertSettingName.FALL;
    } else if(json['alertName'] == "urgentLow"){
      alertSettingName = AlertSettingName.URGENT_LOW;
    } else if(json['alertName'] == "urgentLowSoon"){
      alertSettingName = AlertSettingName.URGENT_LOW_SOON;
    } else if(json['alertName'] == "outOfRange"){
      alertSettingName = AlertSettingName.OUT_OF_RANGE;
    } else{
      alertSettingName = AlertSettingName.NO_READINGS;
    }// if

    final AlertSettingUnit? alertSettingUnit;
    if(json['unit'] == "mg/dL"){
      alertSettingUnit = AlertSettingUnit.MG_DL;
    } else if(json['unit'] == "mmol/L"){
      alertSettingUnit = AlertSettingUnit.MMOL_L;
    } else if(json['unit'] == "mg/dL/min"){
      alertSettingUnit = AlertSettingUnit.MG_DL_MIN;
    } else if(json['unit'] == "mmol/L/min"){
      alertSettingUnit = AlertSettingUnit.MMOL_L_MIN;
    } else if(json['unit'] == "minutes"){
      alertSettingUnit = AlertSettingUnit.MINUTES;
    } else{
      alertSettingUnit = null;
    }// if

    return AlertSetting(
      alertSettingName: alertSettingName,
      value: json['value'] == null ? null : double.parse(json['value'].toString()),
      alertSettingUnit: alertSettingUnit,
      snooze: json['snooze'] == null ? null : double.parse(json['snooze'].toString()),
      enabled: json['enabled'],
      systemTime: Formats.fullDateFormat.parse(json['systemTime']),
      displayTime: Formats.fullDateFormat.parse(json['displayTime']),
    );
  } // fromJson

  @override
  String toString() {
    
    return (StringBuffer('AlertSetting(')
          ..write('alertSettingName: $alertSettingName, ')
          ..write('value: $value, ')
          ..write('alertSettingUnit: $alertSettingUnit, ')
          ..write('snooze: $snooze, ')
          ..write('enabled: $enabled, ')
          ..write('systemTime: $systemTime, ')
          ..write('displayTime: $displayTime ')
          ..write(')'))
        .toString();
  } // toString

  /// Converts the [AlertSetting] to a json.
  Map<String, dynamic> toJson() {

    final String alertSettingNameStr;
    if(alertSettingName== AlertSettingName.HIGH){
      alertSettingNameStr = "high";
    } else if(alertSettingName == AlertSettingName.LOW){
      alertSettingNameStr = "low";
    } else if(alertSettingName == AlertSettingName.RISE){
      alertSettingNameStr = "rise";
    } else if(alertSettingName == AlertSettingName.FALL){
      alertSettingNameStr = "fall";
    } else if(alertSettingName == AlertSettingName.URGENT_LOW){
      alertSettingNameStr = "urgentLow";
    } else if(alertSettingName == AlertSettingName.URGENT_LOW_SOON){
      alertSettingNameStr = "urgentLowSoon";
    } else if(alertSettingName == AlertSettingName.OUT_OF_RANGE){
      alertSettingNameStr = "outOfRange";
    } else{
      alertSettingNameStr = "noReadings";
    }// if

    final String? alertSettingUnitStr;
    if(alertSettingUnit == AlertSettingUnit.MG_DL){
      alertSettingUnitStr = "mg/dL";
    } else if(alertSettingUnit == AlertSettingUnit.MMOL_L){
      alertSettingUnitStr = "mmol/L";
    } else if(alertSettingUnit == AlertSettingUnit.MG_DL_MIN){
      alertSettingUnitStr = "mg/dL/min";
    } else if(alertSettingUnit == AlertSettingUnit.MMOL_L_MIN){
      alertSettingUnitStr = "mmol/L/min";
    } else if(alertSettingUnit == AlertSettingUnit.MINUTES){
      alertSettingUnitStr = "minutes";
    } else{
      alertSettingUnitStr = null;
    }// if

    return <String, dynamic>{
      'alertName': alertSettingNameStr,
      'systemTime' : Formats.fullDateFormat.format(systemTime),
      'displayTime' : Formats.fullDateFormat.format(displayTime),
      'value' : value,
      'unit' : alertSettingUnitStr,
      'snooze' : snooze,
      'enabled' : enabled,
    };
  } // toJson

}// AlertSetting
