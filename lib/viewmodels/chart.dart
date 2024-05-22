// import 'package:flutter/foundation.dart';
// import 'package:sisyphus/data/streamValue.dart';
//
// import 'package:sisyphus/models/candle.dart';
//
// class ChartViewModel extends ChangeNotifier {
//   List<CandleModel> _candles = [];
//   StreamValue? _currentStreamValue;
//
//   List<CandleModel> get candles => _candles;
//   StreamValue? get currentStreamValue => _currentStreamValue;
//
//   Future<void> getCandles(StreamValue streamValue) async {
//     _currentStreamValue = streamValue;
//     _candles = await fetchCandles(streamValue);
//     notifyListeners();
//   }
//
//   Future<void> loadMoreCandles() async {
//     if (_currentStreamValue != null) {
//       final moreCandles = await fetchMoreCandles(_currentStreamValue!);
//       _candles.addAll(moreCandles);
//       notifyListeners();
//     }
//   }
//
//   Future<List<CandleModel>> fetchCandles(StreamValue streamValue) async {
//     // Fetch the initial set of candles
//     // Return a list of CandleModel objects
//     return [];
//   }
//
//   Future<List<CandleModel>> fetchMoreCandles(StreamValue streamValue) async {
//     // Fetch more candles
//     // Return a list of CandleModel objects
//     return [];
//   }
// }

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/data/streamValue.dart';
import 'package:sisyphus/utils/candleTickerProvider.dart';
import 'package:sisyphus/utils/chartController.dart';
import 'package:sisyphus/utils/chartControllerProvider.dart';
import 'package:sisyphus/utils/socketController.dart';

class ChartViewModel extends StateNotifier<ChartState> {
  ChartViewModel(this.ref) : super(ChartState()) {
    _init();
  }

  final Ref ref;

  void _init() {
    // Initial setup if necessary
  }

  void setTradingView(bool value) {
    state = state.copyWith(isTradingView: value);
  }

  void setCurrentTime(String value) {
    state = state.copyWith(currentTime: value);
    fetchCandles();
  }

  void fetchCandles() {
    final currentSymbol = ref.read(currentSymbolStateProvider);
    if (currentSymbol != null) {
      ref.read(chartControllerProvider.notifier)
          .getCandles(StreamValue(symbol: currentSymbol, interval: state.currentTime.toLowerCase()))
          .then((value) {
        state = state.copyWith(candles: value);
        if (ref.read(candleTickerStateProvider) == null) {
          ref.read(socketControllerProvider as ProviderListenable).initialize(
              StreamValue(symbol: currentSymbol, interval: state.currentTime.toLowerCase())
          );
        }
      });
    }
  }
  // void fetchCandles() {
  //   final currentSymbol = ref.read(currentSymbolStateProvider);
  //   if (currentSymbol != null) {
  //     ref.read(chartControllerProvider.notifier)
  //         .getCandles(StreamValue(symbol: currentSymbol, interval: state.currentTime.toLowerCase()))
  //         .then((value) {
  //       state = state.copyWith(candles: value);
  //       if (ref.read(candleTickerStateProvider) == null) {
  //         ref.read(socketControllerProvider)(
  //           StreamValue(symbol: currentSymbol, interval: state.currentTime.toLowerCase()),
  //         ).initialize();
  //       }
  //     });
  //   }
  // }

  Future<void> loadMoreCandles() async {
    final currentSymbol = ref.read(currentSymbolStateProvider);
    if (currentSymbol != null) {
      await ref.read(chartControllerProvider.notifier).loadMoreCandles(
        StreamValue(
          symbol: currentSymbol,
          interval: state.currentTime.toLowerCase(),
        ),
      );
    }
  }
}

class ChartState {
  final bool isTradingView;
  final String currentTime;
  final List<Candle> candles;

  ChartState({
    this.isTradingView = true,
    this.currentTime = '1H',
    this.candles = const [],
  });

  ChartState copyWith({
    bool? isTradingView,
    String? currentTime,
    List<Candle>? candles,
  }) {
    return ChartState(
      isTradingView: isTradingView ?? this.isTradingView,
      currentTime: currentTime ?? this.currentTime,
      candles: candles ?? this.candles,
    );
  }
}

final chartViewModelProvider =
StateNotifierProvider<ChartViewModel, ChartState>((ref) {
  return ChartViewModel(ref);
});
