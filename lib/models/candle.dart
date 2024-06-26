class CandleModel {
  final double open;
  final double high;
  final double low;
  final double close;
  final DateTime timestamp;

  CandleModel({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.timestamp,
  });
}