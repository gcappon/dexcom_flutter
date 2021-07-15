import 'package:dexcom_flutter/dexcom_flutter.dart';
import 'package:dexcom_flutter/src/data/targetRange.dart';

/// [StatisticsRequest] is a class that implement the data model of the request body 
/// of a statistics request to Dexcom API.
class StatisticsRequest{

  List<TargetRange> targetRanges;

  StatisticsRequest({required this.targetRanges}) : assert(checkValidity(targetRanges));
  
  /// A method that checks the validity of the [StatisticsRequest] for the given [targetRanges].
  static bool checkValidity(List<TargetRange> targetRanges){
    
    bool ret = true;
    
    List<int> flags = [0, 0, 0];
    List<num?> bounds = [null, null, null];

    Duration duration = Duration(seconds: 0);    
    for(int t = 0; t < targetRanges.length; t++){
      //check if the egvRange has exactly 3 elements
      ret = targetRanges[t].egvRanges.length == 3;

      //Step 1: for each element of [targetRanges] check if [egvRanges] contains all the three zones. 
      for(int er = 0; er < 3; er++){
        if(targetRanges[t].egvRanges[er].egvRangeName == EGVRangeName.URGENT_LOW){
          flags[0] = 1;
          bounds[0] = targetRanges[t].egvRanges[er].bound;
        }else if(targetRanges[t].egvRanges[er].egvRangeName == EGVRangeName.LOW){
          flags[1] = 1;
          bounds[1] = targetRanges[t].egvRanges[er].bound;
        }else if(targetRanges[t].egvRanges[er].egvRangeName == EGVRangeName.HIGH){
          flags[2] = 1;
          bounds[2] = targetRanges[t].egvRanges[er].bound;
        }//if
      }// for r

      num flagSum = 0;
      flags.forEach((num e){flagSum += e;}); //compute sum of flags
      ret = flagSum == 3; // check

      flags = [0,0,0]; // reset flags

      
      //Step 2: check if for the specified bounds it holds urgentLow < low < high
      ret = bounds[0] != null && bounds[1] != null && bounds[0]! < bounds[1]!; //urgentLow < low
      ret = bounds[1] != null && bounds[2] != null && bounds[1]! < bounds[2]!; //low < high

      bounds = [null, null, null]; // reset bounds

      // Accumulate total time window spanned by the target ranges (must be 24 hours)
      if(targetRanges[t].endTime.isBefore(targetRanges[t].startTime)){
        duration += targetRanges[t].endTime.difference(targetRanges[t].startTime);
        duration += Duration(hours: 24);
      }else{
        duration += targetRanges[t].endTime.difference(targetRanges[t].startTime);
      }
      
    }// for t    

    //Step 3: check if the total time window spanned by the targetRanges is 24 hours
    ret = duration == Duration(hours: 24);

    if(ret == false) throw DexcomBadRequestException(message: "The specified targetRanges do not span a 24-hour long window");

    return ret;
  }// check

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'targetRanges': targetRanges.map<Map<String, dynamic>>((tr) => tr.toJson()).toList(),
    };
  } // toJson

  @override
  String toString() {
    
    return (StringBuffer('StatisticsRequest(')
          ..write('targetRanges: $targetRanges ')
          ..write(')'))
        .toString();
  } // toString

}// StatisticsRequest