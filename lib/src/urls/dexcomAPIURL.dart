/// [DexcomAPIURL] is the abstract class implementing the data model
/// of a url of Dexcom APIs.
abstract class DexcomAPIURL {
  /// The string representation of the url.
  String url;

  /// A boolean flag that indicated if the [DexcomAPIURL] refers to the Sandbox Data or Production data
  bool isSandbox;

  /// Default [DexcomAPIURL] constructor.
  DexcomAPIURL({
    required this.url,
    required this.isSandbox
  });
} // DexcomAPIURL
