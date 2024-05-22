// class OrderBook {
//   final List<List<String>> asks;
//   final List<List<String>> bids;
//
//   OrderBook({required this.asks, required this.bids});
// }


class OrderBook {
  OrderBook(
      this.eventTime,
      this.firstUpdateId,
      this.asks,
      this.bids,
      this.eventType,
      this.symbol,
      this.finalUpdateId,
      );

  factory OrderBook.fromJson(Map<String, dynamic> map) {
    return OrderBook(
      map['E'],
      map['U'],
      map['a'] == null
          ? []
          : (map['a'] as List)
          .map((e) => e == null ? [] : (e as List))
          .toList(),
      map['b'] == null
          ? []
          : (map['b'] as List)
          .map((e) => e == null ? [] : (e as List))
          .toList(),
      map['e'],
      map['s'],
      map['u'],
    );
  }

  final int? eventTime;
  final String? eventType;
  final String? symbol;
  final int? firstUpdateId;
  final int? finalUpdateId;
  final List<List<dynamic>?>? bids;
  final List<List<dynamic>?>? asks;
}
