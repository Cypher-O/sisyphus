import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserAction { buy, sell }

class BottomSheetViewModel extends ChangeNotifier {
  UserAction _selectedAction = UserAction.buy;
  String _selectedOption = 'Limit';

  UserAction get selectedAction => _selectedAction;
  String get selectedOption => _selectedOption;

  // Define your options variable here
  List<String> options = ['Limit', 'Market', 'Stop-Limit'];

  void updateSelectedAction(UserAction action) {
    _selectedAction = action;
    notifyListeners();
  }

  void updateSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }
}

final bottomSheetViewModelProvider =
ChangeNotifierProvider<BottomSheetViewModel>((ref) => BottomSheetViewModel());
