import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/ui/widgets/uiElements/screenSizing.dart';

final baseUiProvider = ChangeNotifierProvider((ref) => BaseUiModel());

class BaseUi extends StatelessWidget {
  final List<Widget> children;
  final FloatingActionButton? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool? allowBackButton;
  final bool? safeTop;
  final Function? onRefreshFunction;
  final bool refreshedEnabled;
  final bool? resizeToAvoidBottomInset;

  const BaseUi({
    Key? key,
    this.allowBackButton,
    required this.children,
    this.floatingActionButton,
    this.appBar,
    this.safeTop,
    this.refreshedEnabled = true,
    this.resizeToAvoidBottomInset = true,
    this.onRefreshFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final model = ref.watch(baseUiProvider);
          final screenSize = ScreenSize(context: context);
          return PopScope(
            canPop: allowBackButton ?? true,
            child: !refreshedEnabled
                ? Scaffold(
              appBar: appBar,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              body: SafeArea(
                top: safeTop ?? false,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: AppColors.white,
                  child: Stack(
                    children: [
                      ...children,
                      model.isBusyState
                          ? Container(
                        height: screenSize.h,
                        width: screenSize.w,
                        color: AppColors.black.withOpacity(0.5),
                        child: Center(
                          child: customDialog(
                            Center(child: loading()),
                            align: Alignment.center,
                            height: 150,
                            width: 150,
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ),
              ),
              floatingActionButton: floatingActionButton,
            )
                : RefreshIndicator(
              displacement: 100,
              backgroundColor: AppColors.brownLight,
              color: AppColors.white,
              strokeWidth: 3,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                if (onRefreshFunction != null) {
                  return onRefreshFunction!();
                }
              },
              child: Scaffold(
                appBar: appBar,
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                body: SafeArea(
                  bottom: false,
                  top: safeTop ?? false,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.white,
                    child: Stack(
                      children: [
                        ...children,
                        model.isBusyState
                            ? Container(
                          height: screenSize.h,
                          width: screenSize.w,
                          color: AppColors.black.withOpacity(0.5),
                          child: Center(
                            child: customDialog(
                              Center(child: loading()),
                              align: Alignment.center,
                              height: 150,
                              width: 150,
                            ),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: floatingActionButton,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BaseUiModel extends ChangeNotifier {
  bool _isBusyState = false;

  bool get isBusyState => _isBusyState;

  void setBusyState(bool value) {
    _isBusyState = value;
    notifyListeners();
  }
}

// Assume these are already defined in your code
Widget customDialog(
    Widget child, {
      Alignment align = Alignment.center,
      double height = 200,
      double width = 200,
    }) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      height: height,
      width: width,
      alignment: align,
      child: child,
    ),
  );
}

Widget loading() {
  return const CircularProgressIndicator();
}

Size sS(BuildContext context) {
  return MediaQuery.of(context).size;
}

class AppColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color brownLight = Color(0xFFF5F5F5);
}