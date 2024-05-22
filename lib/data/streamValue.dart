import 'package:sisyphus/models/symbols.dart';

class StreamValue {
  StreamValue({
    required this.symbol,
    required this.interval,
  });
  late Symbols symbol;
  late String? interval;
}
