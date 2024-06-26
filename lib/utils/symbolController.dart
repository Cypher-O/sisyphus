import 'package:sisyphus/utils/chartController.dart';
import 'package:sisyphus/utils/imports/generalImports.dart';

final symbolControllerProvider =
NotifierProvider<SymbolController, List<Symbols>>(() {
  return SymbolController();
});

class SymbolController extends Notifier<List<Symbols>> {
  @override
  List<Symbols> build() {
    getSymbols();
    return [];
  }

  BinanceRepository get _binanceRepository =>
      ref.read(binanceRepositoryProvider);

  Future<void> getSymbols() async {
    try {
      final data = await _binanceRepository.fetchSymbols();

      ref.read(currentSymbolStateProvider.notifier).state = data[11];

      state = data;
    } catch (e) {
      state = [];
    }
  }
}
