import 'package:sisyphus/utils/chartController.dart';
import 'package:sisyphus/utils/imports/generalImports.dart';

class Charts extends ConsumerWidget {
  const Charts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartViewModel = ref.watch(chartViewModelProvider);
    final currentSymbol = ref.watch(currentSymbolStateProvider);
    final candlestick = ref.watch(candleTickerStateProvider);

    final dummyCandles = generateDummyCandles(50); // Ensure enough data points

    return Column(
      children: [
        S(h: 7),
        TimeframeSelector(
          onSelected: (value) {
            ref.read(chartViewModelProvider.notifier).setCurrentTime(value);
          },
        ),
        S(h: 15),
        Divider(
          color: blackTint.withOpacity(.1),
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 9,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (!chartViewModel.isTradingView) {
                    ref.read(chartViewModelProvider.notifier).setTradingView(true);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: chartViewModel.isTradingView
                        ? context.isDarkMode()
                        ? const Color(0xff555C63)
                        : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: GeneralTextDisplay(
                      'Trading view',
                      14,
                      textColor: context.isDarkMode() ? white : blackTint2,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (chartViewModel.isTradingView) {
                    ref.read(chartViewModelProvider.notifier).setTradingView(false);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: !chartViewModel.isTradingView
                        ? context.isDarkMode()
                        ? const Color(0xff555C63)
                        : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: GeneralTextDisplay(
                      'Depth',
                      14,
                      textColor: context.isDarkMode() ? white : blackTint2,
                    ),
                  ),
                ),
              ),
              S(h: 5),
              SvgPicture.asset(
                ImageAssets.expand_icon,
              ),
            ],
          ),
        ),
        Divider(
          color: blackTint.withOpacity(.1),
          thickness: 1,
        ),
        if (dummyCandles.isNotEmpty) // Check if there are dummy candles
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Candlesticks(
              key: Key(currentSymbol?.symbol ?? 'dummy_symbol' + chartViewModel.currentTime),
              candles: dummyCandles,
              onLoadMoreCandles: () async {
                await ref.read(chartViewModelProvider.notifier).loadMoreCandles();
              },
            ),
          ),
      ],
    );
  }

  List<Candle> generateDummyCandles(int count) {
    final List<Candle> candles = [];
    final now = DateTime.now();
    double prevClose = 100.0;
    for (int i = 0; i < count; i++) {
      final date = now.subtract(Duration(days: count - i));
      final open = prevClose;
      final changePercent = Random().nextDouble() * 0.05; // Generate random change percentage
      final high = open * (1 + changePercent);
      final low = open * (1 - changePercent);
      final close = (high + low) / 2; // Average of high and low
      candles.add(
        Candle(
          date: date,
          open: open,
          high: high,
          low: low,
          close: close,
          volume: 1000 + i * 100,

        ),
      );
      prevClose = close;
    }
    return candles;
  }
}

extension on double {
  String formatValue() {
    return toStringAsFixed(2);
  }
}
