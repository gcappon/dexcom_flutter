/// [DexcomData] is the abstract class implementing the data model
/// of Dexcom generated data.
abstract class DexcomData {
  /// Returns the status of a [DexcomData]
  String toString();

  /// Converts the [value] to a json.
  dynamic toJson<T extends DexcomData>();
} // DexcomData
