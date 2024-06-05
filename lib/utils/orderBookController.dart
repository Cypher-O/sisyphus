import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderBookStateProvider = StateNotifierProvider<OrderbookController, OrderbookState>(
      (ref) => OrderbookController(),
);

class OrderbookState {
  final List<List<String>>? asks;
  final List<List<String>>? bids;

  OrderbookState({
    this.asks,
    this.bids,
  });
}

class OrderbookController extends StateNotifier<OrderbookState> {
  OrderbookController() : super(OrderbookState());

  void fetchOrderbook() {
    // Fetch orderbook data from the API
    final asks = [
      ['7000.00', '1.234'],
      ['11111.00', '2.567'],
      ['39999.00', '2.567'],
      ['2999.00', '2.567'],
      ['36920.00', '2.567'],

    ];
    final bids = [
      ['1998.00', '3.456'],
      ['4997.00', '4.789'],
      ['2997.00', '4.789'],
      ['49997.00', '4.789'],
      ['36920.12', '4.789'],
    ];
    state = OrderbookState(
      asks: asks,
      bids: bids,
    );
  }
}