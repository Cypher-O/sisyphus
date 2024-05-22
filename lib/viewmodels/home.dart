// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel());
//
// class HomeViewModel extends ChangeNotifier {
//   String _someData = 'Hello from ViewModel';
//
//   String get someData => _someData;
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the state class
class HomeViewState {
  final String someData;
  final int currentTabIndex;

  HomeViewState({
    required this.someData,
    required this.currentTabIndex,
  });

  HomeViewState copyWith({
    String? someData,
    int? currentTabIndex,
  }) {
    return HomeViewState(
      someData: someData ?? this.someData,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
// Define the view model class
class HomeViewModel extends StateNotifier<HomeViewState> {
  HomeViewModel() : super(HomeViewState(someData: 'Initial data', currentTabIndex: 0));

  void updateSomeData(String newData) {
    state = state.copyWith(someData: newData);
  }

  void updateCurrentTabIndex(int index) {
    state = state.copyWith(currentTabIndex: index);
  }

  handleMenuPressed(GlobalKey<ScaffoldState> scaffoldKey) {
    if (scaffoldKey.currentState != null) {
      if (scaffoldKey.currentState!.isEndDrawerOpen) {
        scaffoldKey.currentState!.closeEndDrawer();
      } else {
        scaffoldKey.currentState!.openEndDrawer();
      }
    }
  }
}


// Define the provider
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeViewState>(
      (ref) => HomeViewModel(),
);


