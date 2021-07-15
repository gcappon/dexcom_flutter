import 'package:dexcom_flutter/src/data/egvRange.dart';
import 'package:dexcom_flutter/src/utils/formats.dart';

/// [TargetRange] is a class implementing the data model of an element of the [targetRanges] 
/// array of a [StatisticsRequest].
class TargetRange{

  /// The name of the [TargetRange]
  String name;

  /// The beginning of the time window
  DateTime startTime;

  /// The end of the time window
  DateTime endTime;

  /// An containing the minimum and maximum EGV defining the target ranges.
  List<EGVRange> egvRanges;
  
  TargetRange({
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.egvRanges,
  });

  /// Generates an [TargetRange] obtained from a json.
  factory TargetRange.fromJson({required Map<String, dynamic> json}) {

    return TargetRange(
      name: json["name"], 
      startTime: Formats.onlyTime.parse(json["startTime"]),
      endTime: Formats.onlyTime.parse(json["endTime"]),
      egvRanges: json['egvRanges'].map<EGVRange>((er) => EGVRange.fromJson(json: er)).toList(),
    );

  }// TargetRange.fromJson
  
  Map<String, dynamic> toJson() {

    return <String, dynamic>{
      'name': name,
      'startTime': Formats.onlyTime.format(startTime),
      'endTime': Formats.onlyTime.format(endTime),
      'egvRanges': egvRanges.map<Map<String,dynamic>>((er) => er.toJson()).toList(),
    };
  } // toJson

  @override
  String toString() {
    
    return (StringBuffer('TargetRange(')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('egvRanges: $egvRanges ')
          ..write(')'))
        .toString();
  } // toString

}//TargetRange 