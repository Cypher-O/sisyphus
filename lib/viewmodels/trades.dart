import 'package:sisyphus/utils/imports/generalImports.dart';

final tradesViewModelProvider =
    ChangeNotifierProvider((ref) => TradesViewModel());

class TradesViewModel extends ChangeNotifier {
  int _selectedValue = 0;

  int get selectedValue => _selectedValue;

  void setSelectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }
}
