import 'package:dexcom_flutter/src/utils/formats.dart';

import 'package:dexcom_flutter/src/data/dexcomData.dart';

///An enumerator for the unit of measurement of the calibration value.
enum CalibrationValueUnit{
  ///Calibration blood glucose sample value is expressed as mg/dl.
  MG_DL,

  ///Calibration blood glucose sample value is expressed as mmol/l.
  MMOL_L
}// CalibrationValueUnit

/// [DexcomCalibrationData] is a class implementing the data model of the
/// user calibration data.
class DexcomCalibrationData implements DexcomData {

  /// The unit of measurement of the [value] field.
  final CalibrationValueUnit calibrationValueUnit;

  /// The time according to the system clock at which the calibration blood glucose sample was recorded; nominally UTC.
  final DateTime systemTime;

  /// The time displayed on the receiving device when the calibration blood glucose sample was recorded.
  final DateTime displayTime;

  /// The calibration blood glucose sample value. 
  final double? value;

  /// Default [DexcomCalibrationData] constructor.
  DexcomCalibrationData({
    required this.calibrationValueUnit,
    required this.systemTime,
    required this.displayTime,
    this.value,
  });

  /// Generates a [DexcomCalibrationData] obtained from a json.
  factory DexcomCalibrationData.fromJson({required Map<String, dynamic> json}) {

    final CalibrationValueUnit calibrationValueUnit;
    if(json['unit'] == "mg/dL"){
      calibrationValueUnit = CalibrationValueUnit.MG_DL;
    } else {
      calibrationValueUnit = CalibrationValueUnit.MMOL_L;
    }// if

    return DexcomCalibrationData(
      calibrationValueUnit: calibrationValueUnit,
      systemTime: Formats.fullDateFormat.parse(json['systemTime']),
      displayTime: Formats.fullDateFormat.parse(json['displayTime']),
      value: json['value'] == null ? null : double.parse(json['value'].toString()),
    );
  } // fromJson

  @override
  String toString() {
    
    return (StringBuffer('DexcomCalibrationData(')
          ..write('calibrationValueUnit: $calibrationValueUnit, ')
          ..write('systemTime: $systemTime, ')
          ..write('displayTime: $displayTime, ')
          ..write('value: $value ')
          ..write(')'))
        .toString();
  } // toString

  @override
  Map<String, dynamic> toJson<T extends DexcomData>() {

    final String calibrationValueUnitStr;
    if(calibrationValueUnit == CalibrationValueUnit.MG_DL){
      calibrationValueUnitStr = "mg/dL";
    } else {
      calibrationValueUnitStr = "mmol/L";
    }// if

    return <String, dynamic>{
      'unit': calibrationValueUnitStr,
      'systemTime' : Formats.fullDateFormat.format(systemTime),
      'displayTime' : Formats.fullDateFormat.format(displayTime),
      'value' : value,
    };
  } // toJson

} // DexcomCalibrationData
