import 'package:dexcom_flutter/src/data/dexcomData.dart';

///An enumerator for hypoglycemic risk. See:
/// - Kovatchev, B, et al. Algorithmic Evaluation of Metabolic Control and
///   Risk of Severe Hypoglycemia in Type 1 and Type 2 Diabetes Using Self-Monitoring Blood Glucose Data. 
///   Diabetes Technology and Therapeutics, 5(5): 817-828, 2003.
/// - Clarke W, Kovatchev B. Statistical Tools to Analyze Continuous Glucose Monitor Data. Diabetes 
/// Technology & Therapeutics. 2009; 11(Suppl 1): S-45-S-54. doi:10.1089/dia.2008.0138. 
enum HypoglycemiaRisk{
  ///Minimal risk as defined in the references.
  MINIMAL,

  ///LOW risk as defined in the references.
  LOW,

  ///Moderate risk as defined in the references.
  MODERATE,

  ///High risk as defined in the references.
  HIGH,

}// HypoglycemiaRisk

/// [DexcomStatisticsData] is a class implementing the data model of the
/// user statistics data.
class DexcomStatisticsData implements DexcomData {

  /// Risk for the patient to have future hypoglycemic events.
  final HypoglycemiaRisk? hypoglycemiaRisk;

  /// Minimum of all EGV data for given date range
  final double? min;

  /// Maximum of all EGV data for given date range.
  final double? max;

  /// Mean of all EGV data for given date range.
  final double? mean;

  /// Median of all EGV data for given date range.
  final double? median;

  /// Statistical variance of glucose level for given date range
  final double? variance;

  /// Standard deviation of all EGV data for given date range
  final double? stdDev;

  /// Sum of all EGV data for given date range
  final double? sum;

  /// First quartile of all EGV data for given date range
  final double? q1;
  
  /// Second quartile of all EGV data for given date range
  final double? q2;

  /// Third quartile of all EGV data for given date range
  final double? q3;

  /// Percent CGM sensor was utilized for given date range
  final double? utilizationPercent;

  /// Mean number of calibrations per day for given date range
  final double? meanDailyCalibrations;

  /// Number of calendar days contributing data to the statistics calculations; 
  /// only days containing EGV data are included in this count
  final double? nDays;

  /// Total number of EGV observations for given date range
  final double? nValues;

  /// Number of EGV observations below [urgentLow] bound (exclusive) specified in [egvRanges] array
  final double? nUrgentLow;

  /// Number of EGV observations below [low] bound (exclusive) and above urgentLow bound (inclusive) specified in [egvRanges] array
  final double? nBelowRange;

  /// Number of EGV observations between [high] bound (inclusive) and above low bound (inclusive) specified in [egvRanges] array
  final double? nWithinRange;

  /// Number of EGV observations above [high] bound (exclusive) specified in [egvRanges] array
  final double? nAboveRange;
  
  /// Percentage of EGV observations below [urgentLow] bound (exclusive) specified in [egvRanges] array
  final double? percentUrgentLow;

  /// Percentage of EGV observations below [low] bound (exclusive) and above [urgentLow] bound (inclusive) specified in [egvRanges] array
  final double? percentBelowRange;

  /// Percentage of EGV observations between [high] bound (inclusive) and above [low] bound (inclusive) specified in [egvRanges] array
  final double? percentWithinRange;

  /// Percentage of EGV observations above [high] bound (exclusive) specified in [egvRanges] array
  final double? percentAboveRange;

  /// Default [DexcomStatisticsData] constructor.
  DexcomStatisticsData({
    this.hypoglycemiaRisk,
    this.min,
    this.max,
    this.mean,
    this.median,
    this.variance,
    this.stdDev,
    this.sum,
    this.q1,
    this.q2,
    this.q3,
    this.utilizationPercent,
    this.meanDailyCalibrations,
    this.nDays,
    this.nValues,
    this.nUrgentLow,
    this.nBelowRange,
    this.nWithinRange,
    this.nAboveRange,
    this.percentUrgentLow,
    this.percentBelowRange,
    this.percentWithinRange,
    this.percentAboveRange,
  });

  /// Generates a [DexcomStatisticsData] obtained from a json.
  factory DexcomStatisticsData.fromJson({required Map<String, dynamic> json}) {

    final HypoglycemiaRisk? hypoglycemiaRisk;
    if(json['hypoglycemiaRisk'] == "minimal"){
      hypoglycemiaRisk = HypoglycemiaRisk.MINIMAL;
    } else if(json['hypoglycemiaRisk'] == "low"){
      hypoglycemiaRisk = HypoglycemiaRisk.LOW;
    } else if(json['hypoglycemiaRisk'] == "moderate"){
      hypoglycemiaRisk = HypoglycemiaRisk.MODERATE;
    } else if(json['hypoglycemiaRisk'] == "high"){
      hypoglycemiaRisk = HypoglycemiaRisk.HIGH;
    } else {
      hypoglycemiaRisk = null;
    }// if

    return DexcomStatisticsData(
      hypoglycemiaRisk: hypoglycemiaRisk,
      min: json['min'] == null ? null : double.parse(json['min'].toString()),
      max: json['max'] == null ? null : double.parse(json['max'].toString()),
      mean: json['mean'] == null ? null : double.parse(json['mean'].toString()),
      median: json['median'] == null ? null : double.parse(json['median'].toString()),
      variance: json['variance'] == null ? null : double.parse(json['variance'].toString()),
      stdDev: json['stdDev'] == null ? null : double.parse(json['stdDev'].toString()),
      sum: json['sum'] == null ? null : double.parse(json['sum'].toString()),
      q1: json['q1'] == null ? null : double.parse(json['q1'].toString()),
      q2: json['q2'] == null ? null : double.parse(json['q2'].toString()),
      q3: json['q3'] == null ? null : double.parse(json['q3'].toString()),
      utilizationPercent: json['utilizationPercent'] == null ? null : double.parse(json['utilizationPercent'].toString()),
      meanDailyCalibrations: json['meanDailyCalibrations'] == null ? null : double.parse(json['meanDailyCalibrations'].toString()),
      nDays: json['nDays'] == null ? null : double.parse(json['nDays'].toString()),
      nValues: json['nValues'] == null ? null : double.parse(json['nValues'].toString()),
      nUrgentLow: json['nUrgentLow'] == null ? null : double.parse(json['nUrgentLow'].toString()),
      nBelowRange: json['nBelowRange'] == null ? null : double.parse(json['nBelowRange'].toString()),
      nWithinRange: json['nWithinRange'] == null ? null : double.parse(json['nWithinRange'].toString()),
      nAboveRange: json['nAboveRange'] == null ? null : double.parse(json['nAboveRange'].toString()),
      percentUrgentLow: json['percentUrgentLow'] == null ? null : double.parse(json['percentUrgentLow'].toString()),
      percentBelowRange: json['percentBelowRange'] == null ? null : double.parse(json['percentBelowRange'].toString()),
      percentWithinRange: json['percentWithinRange'] == null ? null : double.parse(json['percentWithinRange'].toString()),
      percentAboveRange: json['percentAboveRange'] == null ? null : double.parse(json['percentAboveRange'].toString()),
    );
  } // fromJson

  @override
  String toString() {
    
    return (StringBuffer('DexcomStatisticsData(')
          ..write('hypoglycemiaRisk: $hypoglycemiaRisk, ')
          ..write('min: $min, ')
          ..write('max: $max, ')
          ..write('mean: $mean, ')
          ..write('median: $median, ')
          ..write('variance: $variance, ')
          ..write('stdDev: $stdDev, ')
          ..write('sum: $sum, ')
          ..write('q1: $q1, ')
          ..write('q2: $q2, ')
          ..write('q3: $q3, ')
          ..write('utilizationPercent: $utilizationPercent, ')
          ..write('meanDailyCalibrations: $meanDailyCalibrations, ')
          ..write('nDays: $nDays, ')
          ..write('nValues: $nValues, ')
          ..write('nUrgentLow: $nUrgentLow, ')
          ..write('nBelowRange: $nBelowRange, ')
          ..write('nWithinRange: $nWithinRange, ')
          ..write('nAboveRange: $nAboveRange, ')
          ..write('percentUrgentLow: $percentUrgentLow, ')
          ..write('percentBelowRange: $percentBelowRange, ')
          ..write('percentWithinRange: $percentWithinRange, ')
          ..write('percentAboveRange: $percentAboveRange ')
          ..write(')'))
        .toString();
  } // toString

  @override
  Map<String, dynamic> toJson<T extends DexcomData>() {

    final String? hypoglycemiaRiskStr;
    if(hypoglycemiaRisk == HypoglycemiaRisk.MINIMAL){
      hypoglycemiaRiskStr = "minimal";
    } else if(hypoglycemiaRisk == HypoglycemiaRisk.LOW){
      hypoglycemiaRiskStr = "low";
    } else if(hypoglycemiaRisk == HypoglycemiaRisk.MODERATE){
      hypoglycemiaRiskStr = "moderate";
    } else if(hypoglycemiaRisk == HypoglycemiaRisk.HIGH){
      hypoglycemiaRiskStr = "high";
    } else {
      hypoglycemiaRiskStr = null;
    }// if

    return <String, dynamic>{
      'hypoglycemiaRisk': hypoglycemiaRiskStr,
      'min' : min,
      'max' : max,
      'mean' : mean,
      'median' : median,
      'variance' : variance,
      'stdDev' : stdDev,
      'sum' : sum,
      'q1' : q1,
      'q2' : q2,
      'q3' : q3,
      'utilizationPercent' : utilizationPercent,
      'meanDailyCalibrations' : meanDailyCalibrations,
      'nDays' : nDays,
      'nValues' : nValues,
      'nUrgentLow' : nUrgentLow,
      'nBelowRange' : nBelowRange,
      'nWithinRange' : nWithinRange,
      'nAboveRange' : nAboveRange,
      'percentUrgentLow' : percentUrgentLow,
      'percentBelowRange' : percentBelowRange,
      'percentWithinRange' : percentWithinRange,
      'percentAboveRange' : percentAboveRange,
    };
  } // toJson

} // DexcomStatisticsData
