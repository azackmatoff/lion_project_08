class ServerCurrency {
  final DateTime time;
  final String? assetIdBase;
  final String? assetIdQuote;
  final double rate;

  ServerCurrency({
    required this.time,
    required this.assetIdBase,
    required this.assetIdQuote,
    required this.rate,
  });

  factory ServerCurrency.fromMap(Map<String, dynamic> json) {
    return ServerCurrency(
      time: DateTime.parse(json["time"]),
      assetIdBase: json["asset_id_base"],
      assetIdQuote: json["asset_id_quote"],
      rate: json["rate"]?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
        "time": time.toIso8601String(),
        "asset_id_base": assetIdBase,
        "asset_id_quote": assetIdQuote,
        "rate": rate,
      };
}


//  {
//         "time": "2024-04-29T16:27:30.0000000Z",
//         "asset_id_base": "BTC",
//         "asset_id_quote": "EUR",
//         "rate": 58738.946298133586178328204179
//       }