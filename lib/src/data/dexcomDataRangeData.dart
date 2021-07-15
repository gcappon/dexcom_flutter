import 'package:dexcom_flutter/src/utils/formats.dart';

import 'package:dexcom_flutter/src/data/dexcomData.dart';

/// [DexcomDataRangeData] is a class implementing the data model of the
/// user EGV data.
class DexcomDataRangeData implements DexcomData {

  /// The earliest time according to the system clock for [DexcomCalibrationData] records within the Dexcom system; nominally UTC.
  final DateTime? calibrationsStartSystemTime;

  /// The latest time according to the system clock for [DexcomCalibrationData] records within the Dexcom system; nominally UTC.
  final DateTime? calibrationsEndSystemTime;

  /// The earliest time for [DexcomCalibrationData] records within the Dexcom system as displayed on the receiving device.
  final DateTime? calibrationsStartDisplayTime;

  /// The latest time for [DexcomCalibrationData] records within the Dexcom system as displayed on the receiving device.
  final DateTime? calibrationsEndDisplayTime;

  /// The earliest time according to the system clock for [DexcomEGVData] records within the Dexcom system; nominally UTC.
  final DateTime? egvsStartSystemTime;

  /// The latest time according to the system clock for [DexcomEGVData] records within the Dexcom system; nominally UTC.
  final DateTime? egvsEndSystemTime;

  /// The earliest time for [DexcomEGVData] records within the Dexcom system as displayed on the receiving device.
  final DateTime? egvsStartDisplayTime;

  /// The latest time for [DexcomEGVData] records within the Dexcom system as displayed on the receiving device.
  final DateTime? egvsEndDisplayTime;

  /// The earliest time according to the system clock for [DexcomEventData] records within the Dexcom system; nominally UTC.
  final DateTime? eventsStartSystemTime;

  /// The latest time according to the system clock for [DexcomEventData] records within the Dexcom system; nominally UTC.
  final DateTime? eventsEndSystemTime;

  /// The earliest time for [DexcomEventData] records within the Dexcom system as displayed on the receiving device.
  final DateTime? eventsStartDisplayTime;

  /// The latest time for [DexcomEventData] records within the Dexcom system as displayed on the receiving device.
  final DateTime? eventsEndDisplayTime;

  /// Default [DexcomDataRangeData] constructor.
  DexcomDataRangeData({
    this.calibrationsStartSystemTime,
    this.calibrationsEndSystemTime,
    this.calibrationsStartDisplayTime,
    this.calibrationsEndDisplayTime,
    this.egvsStartSystemTime,
    this.egvsEndSystemTime,
    this.egvsStartDisplayTime,
    this.egvsEndDisplayTime,
    this.eventsStartSystemTime,
    this.eventsEndSystemTime,
    this.eventsStartDisplayTime,
    this.eventsEndDisplayTime
  });

  /// Generates a [DexcomCalibrationData] obtained from a json.
  factory DexcomDataRangeData.fromJson({required Map<String, dynamic> json}) {

    return DexcomDataRangeData(
      calibrationsStartSystemTime: json['calibrations']['start']['systemTime'] == null ? null : Formats.fullDateFormat.parse(json['calibrations']['start']['systemTime']),
      calibrationsEndSystemTime: json['calibrations']['end']['systemTime'] == null ? null : Formats.fullDateFormat.parse(json['calibrations']['end']['systemTime']),
      calibrationsStartDisplayTime: json['calibrations']['start']['displayTime'] == null ? null : Formats.fullDateFormat.parse(json['calibrations']['start']['displayTime']),
      calibrationsEndDisplayTime: json['calibrations']['end']['displayTime'] == null ? null : Formats.fullDateFormat.parse(json['calibrations']['end']['displayTime']),
      egvsStartSystemTime: json['egvs']['start']['systemTime'] == null ? null : Formats.fullDateFormat.parse(json['egvs']['start']['systemTime']),
      egvsEndSystemTime: json['egvs']['end']['systemTime'] == null ? null : Formats.fullDateFormat.parse(json['egvs']['end']['systemTime']),
      egvsStartDisplayTime: json['egvs']['start']['displayTime'] == null ? null : Formats.fullDateFormat.parse(json['egvs']['start']['displayTime']),
      egvsEndDisplayTime: json['egvs']['end']['displayTime'] == null ? null : Formats.fullDateFormat.parse(json['egvs']['end']['displayTime']),
      eventsStartSystemTime: json['events']['start']['systemTime'] == null ? null : Formats.fullDateFormat.parse(json['events']['start']['systemTime']),
      eventsEndSystemTime: json['events']['end']['systemTime'] == null ? null : Formats.fullDateFormat.parse(json['events']['end']['systemTime']),
      eventsStartDisplayTime: json['events']['start']['displayTime'] == null ? null : Formats.fullDateFormat.parse(json['events']['start']['displayTime']),
      eventsEndDisplayTime: json['events']['end']['displayTime'] == null ? null : Formats.fullDateFormat.parse(json['events']['end']['displayTime']),
    );
  } // fromJson

  @override
  String toString() {
    
    return (StringBuffer('DexcomDataRangeData(')
          ..write('calibrationsStartSystemTime: $calibrationsStartSystemTime, ')
          ..write('calibrationsEndSystemTime: $calibrationsEndSystemTime, ')
          ..write('calibrationsStartDisplayTime: $calibrationsStartDisplayTime, ')
          ..write('calibrationsEndDisplayTime: $calibrationsEndDisplayTime, ')
          ..write('egvsStartSystemTime: $egvsStartSystemTime, ')
          ..write('egvsEndSystemTime: $egvsEndSystemTime, ')
          ..write('egvsStartDisplayTime: $egvsStartDisplayTime, ')
          ..write('egvsEndDisplayTime: $egvsEndDisplayTime, ')
          ..write('eventsStartSystemTime: $eventsStartSystemTime, ')
          ..write('eventsEndSystemTime: $eventsEndSystemTime, ')
          ..write('eventsStartDisplayTime: $eventsStartDisplayTime, ')
          ..write('eventsEndDisplayTime: $eventsEndDisplayTime ')
          ..write(')'))
        .toString();
  } // toString

  @override
  Map<String, dynamic> toJson<T extends DexcomData>() {

    return <String, dynamic>{
      'calibrationsStartSystemTime' : calibrationsStartSystemTime == null ? null : Formats.fullDateFormat.format(calibrationsStartSystemTime!),
      'calibrationsEndSystemTime' : calibrationsEndSystemTime == null ? null : Formats.fullDateFormat.format(calibrationsEndSystemTime!),
      'calibrationsStartDisplayTime' : calibrationsStartDisplayTime == null ? null : Formats.fullDateFormat.format(calibrationsStartDisplayTime!),
      'calibrationsEndDisplayTime' : calibrationsEndDisplayTime == null ? null : Formats.fullDateFormat.format(calibrationsEndDisplayTime!),
      'egvsStartSystemTime' : egvsStartSystemTime == null ? null : Formats.fullDateFormat.format(egvsStartSystemTime!),
      'egvsEndSystemTime' : egvsEndSystemTime == null ? null : Formats.fullDateFormat.format(egvsEndSystemTime!),
      'egvsStartDisplayTime' : egvsStartDisplayTime == null ? null : Formats.fullDateFormat.format(egvsStartDisplayTime!),
      'egvsEndDisplayTime' : egvsEndDisplayTime == null ? null : Formats.fullDateFormat.format(egvsEndDisplayTime!),
      'eventsStartSystemTime' : eventsStartSystemTime == null ? null : Formats.fullDateFormat.format(eventsStartSystemTime!),
      'eventsEndSystemTime' : eventsEndSystemTime == null ? null : Formats.fullDateFormat.format(eventsEndSystemTime!),
      'eventsStartDisplayTime' : eventsStartDisplayTime == null ? null : Formats.fullDateFormat.format(eventsStartDisplayTime!),
      'eventsEndDisplayTime' : eventsEndDisplayTime == null ? null : Formats.fullDateFormat.format(eventsEndDisplayTime!),
    };
  } // toJson

} // DexcomDataRangeData
