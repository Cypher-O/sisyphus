import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/ui/widgets/dialog.dart';
import 'package:sisyphus/ui/widgets/uiElements/screenSizing.dart';
// class BaseUi extends StatelessWidget {
//   final List<Widget> children;
//   final FloatingActionButton? floatingActionButton;
//   final PreferredSizeWidget? appBar;
//   final Widget? endDrawer;
//   final Widget? bottomSheet;
//   final bool? allowBackButton;
//   final bool? safeTop;
//   final GlobalKey<ScaffoldState>? scaffoldKey;
//   final Function? onRefreshFunction;
//   final bool refreshedEnabled;
//   final bool? resizeToAvoidBottomInset;
//
//   const BaseUi({
//     Key? key,
//     this.allowBackButton,
//     required this.children,
//     this.floatingActionButton,
//     this.appBar,
//     this.endDrawer,
//     this.bottomSheet,
//     this.safeTop,
//     this.scaffoldKey,
//     this.refreshedEnabled = true,
//     this.resizeToAvoidBottomInset = true,
//     this.onRefreshFunction,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final model = ref.watch(baseUiProvider);
//         final screenSize = ScreenSize(context: context);
//         return PopScope(
//           canPop: allowBackButton ?? true,
//           child: !refreshedEnabled
//               ? Scaffold(
//             key: scaffoldKey,
//             appBar: appBar,
//             bottomSheet: bottomSheet,
//             resizeToAvoidBottomInset: resizeToAvoidBottomInset,
//             body: SafeArea(
//               top: safeTop ?? false,
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Theme.of(context).colorScheme.background,
//                 child: Stack(
//                   children: [
//                     ...children,
//                     model.isBusyState
//                         ? Container(
//                       height: screenSize.h,
//                       width: screenSize.w,
//                       color: Theme.of(context)
//                           .colorScheme
//                           .onBackground
//                           .withOpacity(0.5),
//                       child: Center(
//                         child: customDialog(
//                           Center(child: loading()),
//                           align: Alignment.center,
//                           height: 150,
//                           width: 150,
//                         ),
//                       ),
//                     )
//                         : Container(),
//                   ],
//                 ),
//               ),
//             ),
//             floatingActionButton: floatingActionButton,
//             endDrawer: endDrawer, // Add endDrawer here
//           )
//               : RefreshIndicator(
//             displacement: 100,
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             color: Theme.of(context).colorScheme.onPrimary,
//             strokeWidth: 3,
//             triggerMode: RefreshIndicatorTriggerMode.onEdge,
//             onRefresh: () async {
//               if (onRefreshFunction != null) {
//                 return onRefreshFunction!();
//               }
//             },
//             child: Scaffold(
//               key: scaffoldKey,
//               appBar: appBar,
//               resizeToAvoidBottomInset: resizeToAvoidBottomInset,
//               body: SafeArea(
//                 bottom: false,
//                 top: safeTop ?? false,
//                 child: Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   color: Theme.of(context).colorScheme.background,
//                   child: Stack(
//                     children: [
//                       ...children,
//                       model.isBusyState
//                           ? Container(
//                         height: screenSize.h,
//                         width: screenSize.w,
//                         color: Theme.of(context)
//                             .colorScheme
//                             .onBackground
//                             .withOpacity(0.5),
//                         child: Center(
//                           child: customDialog(
//                             Center(child: loading()),
//                             align: Alignment.center,
//                             height: 150,
//                             width: 150,
//                           ),
//                         ),
//                       )
//                           : Container(),
//                     ],
//                   ),
//                 ),
//               ),
//               floatingActionButton: floatingActionButton,
//               endDrawer: endDrawer, // Add endDrawer here
//             ),
//           ), // Add bottomSheet here
//         );
//       },
//     );
//   }
// }
//
//
// Widget loading() {
//   return const CircularProgressIndicator();
// }
//
//
// final baseUiProvider = ChangeNotifierProvider((ref) => BaseUiModel());
//
//
// class BaseUiModel extends ChangeNotifier {
//   bool _isBusyState = false;
//
//   bool get isBusyState => _isBusyState;
//
//   void setBusyState(bool value) {
//     _isBusyState = value;
//     notifyListeners();
//   }
// }


class BaseUi extends StatelessWidget {
  final List<Widget> children;
  final FloatingActionButton? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final bool? allowBackButton;
  final bool? safeTop;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Function? onRefreshFunction;
  final bool refreshedEnabled;
  final bool? resizeToAvoidBottomInset;

  const BaseUi({
    Key? key,
    this.allowBackButton,
    required this.children,
    this.floatingActionButton,
    this.appBar,
    this.endDrawer,
    this.bottomSheet,
    this.safeTop,
    this.scaffoldKey,
    this.refreshedEnabled = true,
    this.resizeToAvoidBottomInset = true,
    this.onRefreshFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final model = ref.watch(baseUiProvider);
        final screenSize = MediaQuery.of(context).size;
        return PopScope(
          canPop: allowBackButton ?? true,
          child: !refreshedEnabled
              ? Scaffold(
            key: scaffoldKey,
            appBar: appBar,
            bottomSheet: bottomSheet,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            body: SafeArea(
              top: safeTop ?? false,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Theme.of(context).colorScheme.background,
                child: Stack(
                  children: [
                    ...children,
                    model.isBusyState
                        ? Container(
                      height: screenSize.height,
                      width: screenSize.width,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.5),
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
            endDrawer: endDrawer, // Add endDrawer here
          )
              : RefreshIndicator(
            displacement: 100,
            backgroundColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.onPrimary,
            strokeWidth: 3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              if (onRefreshFunction != null) {
                return onRefreshFunction!();
              }
            },
            child: Scaffold(
              key: scaffoldKey,
              appBar: appBar,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              body: SafeArea(
                bottom: false,
                top: safeTop ?? false,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).colorScheme.background,
                  child: Stack(
                    children: [
                      ...children,
                      model.isBusyState
                          ? Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
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
              endDrawer: endDrawer, // Add endDrawer here
            ),
          ), // Add bottomSheet here
        );
      },
    );
  }
}

Widget loading() {
  return const CircularProgressIndicator();
}

final baseUiProvider = ChangeNotifierProvider((ref) => BaseUiModel());

class BaseUiModel extends ChangeNotifier {
  bool _isBusyState = false;

  bool get isBusyState => _isBusyState;

  void setBusyState(bool value) {
    _isBusyState = value;
    notifyListeners();
  }
}
