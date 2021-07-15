import 'package:dexcom_flutter/src/utils/formats.dart';

import 'package:dexcom_flutter/src/data/dexcomData.dart';

import 'package:dexcom_flutter/src/data/alertSchedule.dart';

///An enumerator for generation of trasmitter associated to the device.
enum TransmitterGeneration{
  ///Dexcom G4.
  G4,

  ///Dexcom G5.
  G5,
  
  ///Dexcom G6.
  G6,
  
}// TransmitterGeneration

///An enumerator for the type of display device used to receive the transmitter signal.
enum DisplayDevice{
  ///Dexcom receiver.
  RECEIVER,

  ///Dexcom Share receiver.
  SHARE_RECEIVER,
  
  ///Dexcom Touchscreen Receiver.
  TOUCHSCREEN_RECEIVER,

  //iOS device.
  IOS,

  //Android device.
  ANDROID,
  
}// DisplayDevice

/// [DexcomDeviceData] is a class implementing the data model of the
/// user device data.
class DexcomDeviceData implements DexcomData {

  /// The [TransmitterGeneration] of the Dexcom device.
  final TransmitterGeneration? transmitterGeneration;

  /// The [DisplayDevice] of the Dexcom device.
  final DisplayDevice? displayDevice;

  /// Server timestamp, in UTC, of last upload event for the device that 
  /// contributed data in the specified time window; note that this may be outside 
  /// the range defined by the [startDate] and [endDate] query parameters
  final DateTime lastUploadDate;

  /// Array of [AlertSchedule] for the device as of the [lastUploadDate].
  final List<AlertSchedule> alertScheduleList;

  /// Default [DexcomDeviceData] constructor.
  DexcomDeviceData({
    this.transmitterGeneration,
    this.displayDevice,
    required this.lastUploadDate,
    required this.alertScheduleList,
  });

  /// Generates a [DexcomDeviceData] obtained from a json.
  factory DexcomDeviceData.fromJson({required Map<String, dynamic> json}) {

    final TransmitterGeneration? transmitterGeneration;
    if(json['transmitterGeneration'] == "g4"){
      transmitterGeneration = TransmitterGeneration.G4;
    } else if(json['transmitterGeneration'] == "g5"){
      transmitterGeneration = TransmitterGeneration.G5;
    } else if(json['transmitterGeneration'] == "g6"){
      transmitterGeneration = TransmitterGeneration.G6;
    } else{
      transmitterGeneration = null;
    }// if

    final DisplayDevice? displayDevice;
    if(json['displayDevice'] == "receiver"){
      displayDevice = DisplayDevice.RECEIVER;
    } else if(json['displayDevice'] == "shareReceiver"){
      displayDevice = DisplayDevice.SHARE_RECEIVER;
    } else if(json['displayDevice'] == "touchscreenReceiver"){
      displayDevice = DisplayDevice.TOUCHSCREEN_RECEIVER;
    } else if(json['displayDevice'] == "iOS"){
      displayDevice = DisplayDevice.IOS;
    } else if(json['displayDevice'] == "android"){
      displayDevice = DisplayDevice.ANDROID;
    } else{
      displayDevice = null;
    }// if

    
    return DexcomDeviceData(
      transmitterGeneration: transmitterGeneration,
      displayDevice: displayDevice,
      lastUploadDate: Formats.fullDateFormat.parse(json['lastUploadDate']),
      alertScheduleList: json['alertScheduleList'].map<AlertSchedule>((alSc) => AlertSchedule.fromJson(json: alSc)).toList(),
    );
  } // fromJson

  @override
  String toString() {
    
    return (StringBuffer('DexcomDeviceData(')
          ..write('transmitterGeneration: $transmitterGeneration, ')
          ..write('displayDevice: $displayDevice, ')
          ..write('lastUploadDate: $lastUploadDate, ')
          ..write('alertScheduleList: $alertScheduleList ')
          ..write(')'))
        .toString();
  } // toString

  @override
  Map<String, dynamic> toJson<T extends DexcomData>() {

    final String? transmitterGenerationStr;
    if(transmitterGeneration == TransmitterGeneration.G4){
      transmitterGenerationStr = "g4";
    } else if(transmitterGeneration == TransmitterGeneration.G5){
      transmitterGenerationStr = "g5";
    } else if(transmitterGeneration == TransmitterGeneration.G6){
      transmitterGenerationStr = "g6";
    } else{
      transmitterGenerationStr = null;
    }// if

    final String? displayDeviceStr;
    if(displayDevice == DisplayDevice.RECEIVER){
      displayDeviceStr = "receiver";
    } else if(displayDevice == DisplayDevice.SHARE_RECEIVER){
      displayDeviceStr = "shareReceiver";
    } else if(displayDevice == DisplayDevice.TOUCHSCREEN_RECEIVER){
      displayDeviceStr = "touchscreenReceiver";
    } else if(displayDevice == DisplayDevice.IOS){
      displayDeviceStr = "iOS";
    } else if(displayDevice == DisplayDevice.ANDROID){
      displayDeviceStr = "android";
    } else{
      displayDeviceStr = null;
    }// if

    return <String, dynamic>{
      'transmitterGeneration': transmitterGenerationStr,
      'displayDevice' : displayDeviceStr,
      'lastUploadDate' : Formats.fullDateFormat.format(lastUploadDate),
      'alertScheduleList' : alertScheduleList.map((alSc) => alSc.toJson()),
    };
  } // toJson

} // DexcomDeviceData
