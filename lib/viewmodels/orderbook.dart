import 'package:sisyphus/utils/imports/generalImports.dart';
import 'package:sisyphus/utils/orderBookController.dart';

class OrderBookViewModel extends ChangeNotifier {
  OrderBook? _orderBook;

  OrderBook? get orderBook => _orderBook;

  void setOrderBook(OrderBook orderBook) {
    _orderBook = orderBook;
    notifyListeners();
  }

  void fetchOrderbook(OrderbookController orderBookController) {
    orderBookController.fetchOrderbook();
  }
}

final orderBookViewModelProvider = ChangeNotifierProvider((ref) => OrderBookViewModel());
