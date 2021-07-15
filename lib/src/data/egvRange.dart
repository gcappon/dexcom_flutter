/// An enumerator class that defines the name of the [EGVRange]
enum EGVRangeName{
  /// Urgent low threshold.
  URGENT_LOW,

  /// Low thrshold.
  LOW, 

  /// High threshold.
  HIGH
}// EGVRangeName

/// [EGVRange] is a class implementing the data model of an element of the [egvRanges] 
/// array of a [TargetRange].
class EGVRange{

  /// The name of the [EGVRange]
  EGVRangeName egvRangeName;

  /// The threshold value.
  int bound;
  
  EGVRange({
    required this.egvRangeName,
    required this.bound,
  });

  /// Generates an [EGVRange] obtained from a json.
  factory EGVRange.fromJson({required Map<String, dynamic> json}) {

    EGVRangeName egvRangeName;
    if(json['name']=="urgentLow"){
      egvRangeName = EGVRangeName.URGENT_LOW;
    }else if(json['name']=="low"){
      egvRangeName = EGVRangeName.LOW;
    }else{
      egvRangeName = EGVRangeName.HIGH;
    }// if

    return EGVRange(
      egvRangeName: egvRangeName, 
      bound: int.parse(json['bound'].toString()),
    );

  }// EGVRange.fromJson
  
  Map<String, dynamic> toJson() {

    String egvRangeNameStr;
    if(egvRangeName == EGVRangeName.URGENT_LOW){
      egvRangeNameStr = "urgentLow";
    }else if(egvRangeName == EGVRangeName.LOW){
      egvRangeNameStr = "low";
    }else{
      egvRangeNameStr = "high";
    }// if

    return <String, dynamic>{
      'name': egvRangeNameStr,
      'bound': bound,
    };
  } // toJson

  @override
  String toString() {
    
    return (StringBuffer('EGVRange(')
          ..write('name: $egvRangeName, ')
          ..write('bound: $bound ')
          ..write(')'))
        .toString();
  } // toString


}//EGVRange 