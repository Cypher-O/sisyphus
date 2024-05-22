import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final candleTickerStateProvider = StateProvider<CandleTicker?>((ref) {
//   return null; // Initial state is null
// });

// Define your CandleTicker class or replace it with the appropriate model
class CandleTicker {
  final Candle candle;

  CandleTicker(this.candle);
}
