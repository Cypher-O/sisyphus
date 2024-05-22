// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sisyphus/models/symbols.dart';
// import 'package:sisyphus/utils/chartController.dart';
// import 'package:sisyphus/utils/chart_controller.dart';
// import 'package:sisyphus/utils/socketController.dart';
// import 'package:sisyphus/utils/socket_controller.dart';
// import 'package:sisyphus/viewmodels/chart.dart';
//
// final currentSymbolStateProvider = StateProvider<Symbols?>((ref) => null);
//
// final chartControllerProvider = StateNotifierProvider<ChartController, List<Candle>>((ref) {
//   return ChartController();
// });
//
// final currentTimeframeProvider = StateProvider<String>((ref) => '1H');
//
// final socketControllerProvider = Provider<SocketController>((ref) {
//   return SocketController();
// });
//
// final chartViewModelProvider = StateNotifierProvider<ChartViewModel, ChartState>((ref) {
//   return ChartViewModel(ref);
// });
