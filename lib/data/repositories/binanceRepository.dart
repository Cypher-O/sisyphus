import 'package:sisyphus/utils/imports/generalImports.dart';
import 'package:http/http.dart' as http;

final binanceRepositoryProvider =
    Provider<BinanceRepository>((ref) => BinanceRepository());

class BinanceRepository {
  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    debugPrint('Fetching candles for symbol: $symbol, interval: $interval');
    final uri = Uri.parse(
      'https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? '&endTime=$endTime' : ''}',
    );
    final res = await http.get(uri);
    debugPrint('API Response: ${res.body}');
    return (jsonDecode(res.body) as List<dynamic>)
        // ignore: unnecessary_lambdas
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  Future<List<Symbols>> fetchSymbols() async {
    final uri = Uri.parse('https://api.binance.com/api/v3/ticker/price');
    final res = await http.get(uri);
    debugPrint('API Response: ${res.body}');
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Symbols.fromJson(e))
        .toList();
  }

  WebSocketChannel establishConnection(String symbol, String interval) {
    debugPrint(
        'Establishing connection for symbol: $symbol, interval: $interval');
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@kline_$interval'],
          'id': 1
        },
      ),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@depth'],
          'id': 1
        },
      ),
    );
    channel.stream.listen((event) {
      debugPrint(
          'WebSocket Data: $event');
    });
    return channel;
  }
}
