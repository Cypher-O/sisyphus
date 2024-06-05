import 'package:sisyphus/utils/chartController.dart';
import 'package:sisyphus/utils/imports/generalImports.dart';

class ChartViewModel extends StateNotifier<ChartState> {
  ChartViewModel(this.ref) : super(ChartState()) {
    _init();
  }

  final Ref ref;

  void _init() {
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
