// ignore_for_file: invalid_use_of_protected_member

import 'package:sisyphus/utils/imports/generalImports.dart';

final currentSymbolStateProvider = StateProvider<Symbols?>((ref) {
  return null;
});

final candleTickerStateProvider = StateProvider<CandleTickerModel?>((ref) {
  return null;
});

final orderBookStateProvider = StateProvider<OrderBook?>((ref) {
  return null;
});

// MAIN CHART CONTROLLER WITH CANDLES

final chartControllerProvider =
NotifierProvider<ChartController, List<Candle>>(() {
  return ChartController();
});

class ChartController extends Notifier<List<Candle>> {
  @override
  List<Candle> build() {
    return [];
  }

  BinanceRepository get _binanceRepository =>
      ref.read(binanceRepositoryProvider);

  Future<List<Candle>> getCandles(StreamValue streamValue) async {
    try {
      final data = await _binanceRepository.fetchCandles(
        symbol: streamValue.symbol.symbol!,
        interval: streamValue.interval!,
      );

      state = data;
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<void> loadMoreCandles(StreamValue streamValue) async {
    try {
      final data = await _binanceRepository.fetchCandles(
        symbol: streamValue.symbol.symbol!,
        interval: streamValue.interval!,
        endTime: state.last.date.millisecondsSinceEpoch,
      );

      state
        ..removeLast()
        ..addAll(data);
    } catch (e) {
      print(e);
    }
  }
}
