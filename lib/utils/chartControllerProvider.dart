// // ignore_for_file: invalid_use_of_protected_member
//
// import 'dart:async';
//
// import 'package:candlesticks/candlesticks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sisyphus/data/repositories/binanceRepository.dart';
// import 'package:sisyphus/data/streamValue.dart';
// import 'package:sisyphus/models/candleTickerModel.dart';
// import 'package:sisyphus/models/orderBook.dart';
// import 'package:sisyphus/models/symbols.dart';
//
//
// final currentSymbolStateProvider = StateProvider<Symbols?>((ref) {
//   return null;
// });
//
// final candleTickerStateProvider = StateProvider<CandleTickerModel?>((ref) {
//   return null;
// });
//
// final orderBookStateProvider = StateProvider<OrderBook?>((ref) {
//   return null;
// });
//
// // MAIN CHART CONTROLLER WITH CANDLES
//
// final chartControllerProvider =
// NotifierProvider<ChartController, List<Candle>>(() {
//   return ChartController();
// });
//
// class ChartController extends Notifier<List<Candle>> {
//   @override
//   List<Candle> build() {
//     return [];
//   }
//
//   BinanceRepository get _binanceRepository =>
//       ref.read(binanceRepositoryProvider);
//
//   Future<List<Candle>> getCandles(StreamValue streamValue) async {
//     try {
//       final data = await _binanceRepository.fetchCandles(
//         symbol: streamValue.symbol.symbol!,
//         interval: streamValue.interval!,
//       );
//
//       state = data;
//       return data;
//     } catch (e) {
//       return [];
//     }
//   }
//
//   Future<void> loadMoreCandles(StreamValue streamValue) async {
//     try {
//       final data = await _binanceRepository.fetchCandles(
//         symbol: streamValue.symbol.symbol!,
//         interval: streamValue.interval!,
//         endTime: state.last.date.millisecondsSinceEpoch,
//       );
//
//       state
//         ..removeLast()
//         ..addAll(data);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
//


import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/models/symbols.dart';
import 'package:sisyphus/utils/chartController.dart';
import 'package:sisyphus/utils/socketController.dart';

// final currentSymbolStateProvider = StateProvider<Symbols?>((ref) => null);

// final chartControllerProvider = StateNotifierProvider<ChartController, List<Candle>>((ref) {
//   return ChartController();
// });

final currentTimeframeProvider = StateProvider<String>((ref) => '1H');

// final socketControllerProvider = Provider<SocketController>((ref) {
//   return SocketController();
// });
