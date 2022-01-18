class Coin {
  String symbol;
  String priceChange;
  String priceChangePercent;
  String lastPrice;

  Coin({required this.symbol, required this.priceChange, required this.priceChangePercent, required this.lastPrice});

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        symbol: json['symbol'],
        priceChange: json['priceChange'],
        priceChangePercent: json['priceChangePercent'],
        lastPrice: json['lastPrice']);
  }
}
