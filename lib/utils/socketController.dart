import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/data/repositories/binanceRepository.dart';
import 'package:sisyphus/data/streamValue.dart';
import 'package:sisyphus/models/candleTickerModel.dart';
import 'package:sisyphus/models/orderBook.dart';
import 'package:sisyphus/utils/candleTickerProvider.dart';
import 'package:sisyphus/utils/chartController.dart';

final socketControllerProvider = StreamProvider.family<CandleTickerModel, StreamValue?>((ref, streamValue) async* {
  final binanceRepository = ref.read(binanceRepositoryProvider);

  final channel = binanceRepository.establishConnection(
    streamValue!.symbol.symbol!.toLowerCase(),
    streamValue.interval ?? '1h',
  );

  ref.onDispose(() {
    channel.sink.close();
  });

  await for (final String value in channel.stream) {
    final map = jsonDecode(value) as Map<String, dynamic>;

    final candles = ref.read(chartControllerProvider);

    final eventType = map['e'];

    if (eventType == 'kline') {
      final candleTicker = CandleTickerModel.fromJson(map);

      ref.read(candleTickerStateProvider.notifier).state = candleTicker;

      if (candles[0].date == candleTicker.candle.date && candles[0].open == candleTicker.candle.open) {
        candles[0] = candleTicker.candle;
      } else if (candleTicker.candle.date.difference(candles[0].date) ==
          candles[0].date.difference(candles[1].date)) {
        ref.read(chartControllerProvider.notifier).state.insert(0, candleTicker.candle);
      }
    } else if (eventType == 'depthUpdate') {
      final orderBook = OrderBook.fromJson(map);

      ref.read(orderBookStateProvider.notifier).state = orderBook;
    }
  }
});


// final socketController = StreamProvider.family<CandleTickerModel, StreamValue?>(
//         (ref, streamValue) async* {
//       final binanceRepository = ref.read(binanceRepositoryProvider);
//
//       final channel = binanceRepository.establishConnection(
//         streamValue!.symbol.symbol!.toLowerCase(),
//         streamValue.interval ?? '1h',
//       );
//
//       ref.onDispose(
//             () {
//           channel.sink.close();
//         },
//       );
//
//       await for (final String value in channel.stream) {
//         final map = jsonDecode(value) as Map<String, dynamic>;
//
//         final candles = ref.read(chartControllerProvider);
//
//         final eventType = map['e'];
//
//         if (eventType == 'kline') {
//           final candleTicker = CandleTickerModel.fromJson(map);
//
//           ref.read(candleTickerStateProvider.notifier).state = candleTicker;
//
//           if (candles[0].date == candleTicker.candle.date &&
//               candles[0].open == candleTicker.candle.open) {
//             candles[0] = candleTicker.candle;
//           } else if (candleTicker.candle.date.difference(candles[0].date) ==
//               candles[0].date.difference(candles[1].date)) {
//             ref
//                 .read(chartControllerProvider.notifier)
//                 .state
//                 .insert(0, candleTicker.candle);
//           }
//         } else if (eventType == 'depthUpdate') {
//           final orderBook = OrderBook.fromJson(map);
//
//           ref.read(orderBookStateProvider.notifier).state = orderBook;
//         }
//       }
//     });
