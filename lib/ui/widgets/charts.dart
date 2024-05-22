// import 'package:candlesticks/candlesticks.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sisyphus/ui/widgets/selectTimeframe.dart';
// import 'package:sisyphus/ui/widgets/uiElements/generalTextDisplay.dart';
// import 'package:sisyphus/ui/widgets/uiElements/sizedBox.dart';
// import 'package:sisyphus/utils/appTheme.dart';
// import 'package:sisyphus/utils/assets.dart';
// import 'package:sisyphus/utils/candleTickerProvider.dart';
// import 'package:sisyphus/utils/chartController.dart';
// import 'package:sisyphus/utils/chartControllerProvider.dart';
// import 'package:sisyphus/utils/constants.dart';
// import 'package:sisyphus/viewmodels/chart.dart';
//
// class Charts extends ConsumerWidget {
//   const Charts({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final chartViewModel = ref.watch(chartViewModelProvider);
//     final currentSymbol = ref.watch(currentSymbolStateProvider);
//     final candlestick = ref.watch(candleTickerStateProvider);
//
//     return Column(
//       children: [
//         S(h:7),
//         TimeframeSelector(
//           onSelected: (value) {
//             ref.read(chartViewModelProvider.notifier).setCurrentTime(value);
//           },
//         ),
//         S(h:15),
//         Divider(
//           color: blackTint.withOpacity(.1),
//           thickness: 1,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 9,
//           ),
//           child: Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   if (!chartViewModel.isTradingView) {
//                     ref.read(chartViewModelProvider.notifier).setTradingView(true);
//                   }
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 400),
//                   margin: const EdgeInsets.symmetric(horizontal: 3),
//                   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: chartViewModel.isTradingView
//                         ? context.isDarkMode()
//                         ? const Color(0xff555C63)
//                         : const Color(0xffCFD3D8)
//                         : Colors.transparent,
//                   ),
//                   child: Center(
//                     child: GeneralTextDisplay(
//                       'Trading view',
//                       14,
//                       textColor: context.isDarkMode() ? white : blackTint2,
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   if (chartViewModel.isTradingView) {
//                     ref.read(chartViewModelProvider.notifier).setTradingView(false);
//                   }
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 400),
//                   margin: const EdgeInsets.symmetric(horizontal: 3),
//                   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: !chartViewModel.isTradingView
//                         ? context.isDarkMode()
//                         ? const Color(0xff555C63)
//                         : const Color(0xffCFD3D8)
//                         : Colors.transparent,
//                   ),
//                   child: Center(
//                     child: GeneralTextDisplay(
//                       'Depth',
//                       14,
//                       textColor: context.isDarkMode() ? white : blackTint2,
//                     ),
//                   ),
//                 ),
//               ),
//               S(h:5),
//               SvgPicture.asset(
//                 ImageAssets.expand_icon,
//               ),
//             ],
//           ),
//         ),
//         Divider(
//           color: blackTint.withOpacity(.1),
//           thickness: 1,
//         ),
//         if (chartViewModel.candles.isNotEmpty)
//           SizedBox(
//             height: 400,
//             width: double.infinity,
//             child:
//             Candlesticks(
//               key: Key(currentSymbol!.symbol! + chartViewModel.currentTime),
//               // style: CandleSticksStyle(
//               //   borderColor: blackTint2.withOpacity(.5),
//               //   background: Colors.transparent,
//               //   primaryBull: const Color(0xff00C076),
//               //   secondaryBull: const Color(0xff25C26E),
//               //   primaryBear: const Color(0xffFF6838),
//               //   secondaryBear: const Color(0xffFF6838),
//               //   hoverIndicatorBackgroundColor: blackTint,
//               //   primaryTextColor: blackTint2,
//               //   secondaryTextColor: blackTint2,
//               //   mobileCandleHoverColor: blackTint,
//               //   loadingColor: appBlack,
//               //   toolBarColor: Colors.transparent,
//               // ),
//               candles: chartViewModel.candles,
//               onLoadMoreCandles: () async {
//
//                await ref.read(chartViewModelProvider.notifier).loadMoreCandles();
//               },
//               // displayZoomActions: false,
//               actions: [
//                 ToolBarAction(
//                   width: 45,
//                   onPressed: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 5),
//                     child: SvgPicture.asset(
//                       ImageAssets.arrowDown_icon,
//                       width: 25,
//                       height: 25,
//                     ),
//                   ),
//                 ),
//                 ToolBarAction(
//                   width: 60,
//                   onPressed: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 2),
//                     child: GeneralTextDisplay(
//                       currentSymbol.symbol!,
//                       11,
//                       textColor: blackTint2,
//                     ),
//                   ),
//                 ),
//                 if (candlestick != null)
//                   ToolBarAction(
//                     width: 55,
//                     onPressed: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 2),
//                       child: Row(
//                         children: [
//                           const GeneralTextDisplay(
//                             'O ',
//                             11,
//                             textColor: blackTint2,
//                           ),
//                           GeneralTextDisplay(
//                             candlestick.candle.open.formatValue(),
//                             11,
//                             textColor: textGreen,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 if (candlestick != null)
//                   ToolBarAction(
//                     width: 55,
//                     onPressed: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 2),
//                       child: Row(
//                         children: [
//                           const GeneralTextDisplay(
//                             'H ',
//                             11,
//                             textColor: blackTint2,
//                           ),
//                           GeneralTextDisplay(
//                             candlestick.candle.high.formatValue(),
//                             11,
//                             textColor: textGreen,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 if (candlestick != null)
//                   ToolBarAction(
//                     width: 55,
//                     onPressed: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 2),
//                       child: Row(
//                         children: [
//                           const GeneralTextDisplay(
//                             'L ',
//                             11,
//                             textColor: blackTint2,
//                           ),
//                           GeneralTextDisplay(
//                             candlestick.candle.low.formatValue(),
//                             11,
//                             textColor: textGreen,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 if (candlestick != null)
//                   ToolBarAction(
//                     width: 55,
//                     onPressed: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 2),
//                       child: Row(
//                         children: [
//                           const GeneralTextDisplay(
//                             'C ',
//                             11,
//                             textColor: blackTint2,
//                           ),
//                           GeneralTextDisplay(
//                             candlestick.candle.close.formatValue(),
//                             11,
//                             textColor: textGreen,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }
//
//

import 'dart:math';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/ui/widgets/selectTimeframe.dart';
import 'package:sisyphus/ui/widgets/uiElements/generalTextDisplay.dart';
import 'package:sisyphus/ui/widgets/uiElements/sizedBox.dart';
import 'package:sisyphus/utils/appTheme.dart';
import 'package:sisyphus/utils/assets.dart';
import 'package:sisyphus/utils/chartController.dart';
import 'package:sisyphus/utils/constants.dart';
import 'package:sisyphus/viewmodels/chart.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/ui/widgets/selectTimeframe.dart';
import 'package:sisyphus/ui/widgets/uiElements/generalTextDisplay.dart';
import 'package:sisyphus/ui/widgets/uiElements/sizedBox.dart';
import 'package:sisyphus/utils/assets.dart';
import 'package:sisyphus/utils/constants.dart';
import 'package:sisyphus/viewmodels/chart.dart';

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
