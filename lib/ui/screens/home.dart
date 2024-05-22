import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sisyphus/ui/widgets/appBar.dart';
import 'package:sisyphus/ui/widgets/baseUI.dart';
import 'package:sisyphus/ui/widgets/bottomSheet.dart';
import 'package:sisyphus/ui/widgets/charts.dart';
import 'package:sisyphus/ui/widgets/orderBook.dart';
import 'package:sisyphus/ui/widgets/uiElements/buttons.dart';
import 'package:sisyphus/ui/widgets/uiElements/generalTextDisplay.dart';
import 'package:sisyphus/ui/widgets/uiElements/sizedBox.dart';
import 'package:sisyphus/ui/widgets/trades.dart';
import 'package:sisyphus/utils/appTheme.dart';
import 'package:sisyphus/utils/assets.dart';
import 'package:sisyphus/utils/chartController.dart';
import 'package:sisyphus/utils/constants.dart';
import 'package:sisyphus/viewmodels/bottomSheet.dart';
import 'package:sisyphus/viewmodels/home.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final drawerItems = [
    'Exchange',
    'Wallets',
    'Roqqu Hub',
    'Log out',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleMenuPressed() {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    homeViewModel.handleMenuPressed(_key);
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(homeViewModelProvider.notifier);
    final currentSymbol = ref.watch(currentSymbolStateProvider);
    final state = ref.watch(homeViewModelProvider);
    final candlestick = ref.watch(candleTickerStateProvider);

    return BaseUi(
      scaffoldKey: _key,
      safeTop: true,
      refreshedEnabled: false,
      appBar: CustomizedAppBar(
        onMenuPressed: _handleMenuPressed,
      ),
      endDrawer: Stack(
        children: [
          Positioned(
            top: 65,
            right: 10,
            child: Container(
              height: 208,
              width: 214,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).shadowColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...drawerItems.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: GeneralTextDisplay(
                        e,
                        16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).shadowColor,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DefaultButton(
                  title: 'Buy',
                  onPressed: () {
                    openBottomSheet(context, UserAction.buy);
                  },
                  color: const Color(0xff25C26E),
                ),
              ),
              S(w:16),
              Expanded(
                child: DefaultButton(
                  title: 'Sell',
                  onPressed: () {
                    openBottomSheet(context, UserAction.buy);
                  },
                  color: const Color(0xffFF554A),
                ),
              ),
            ],
          ),
        ),
      ),
      children: [
        ListView(
          padding: const EdgeInsets.only(
            bottom: 120,
          ),
          children: [
            S(h: 8),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                  color: Theme.of(context).shadowColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  S(h: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.btcusd_icon,
                          width: 44,
                          height: 24,
                        ),
                        S(h: 8),
                        if (currentSymbol != null) ...[
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const GeneralTextDisplay(
                                "BTC/USDT",
                                18,
                              ),
                              S(w: 10),
                              const Padding(
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.keyboard_arrow_down_rounded),
                              ),
                            ],
                          ),
                        ),
                        S(w: 27),
                        const GeneralTextDisplay(
                          '20,634',
                          18,
                          textColor: textGreen,
                        ),
                        ] else ...[
                        const GeneralTextDisplay(
                          '--',
                          18,
                        ),
                        S(h: 10),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ),
                        S(h: 27),
                        const GeneralTextDisplay(
                          r'$0.0',
                          18,
                          textColor: textGreen,
                        ),
                        ]
                      ],
                    ),
                  ),
                  S(h: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_rounded,
                                      size: 18,
                                      color: blackTint,
                                    ),
                                    S(w: 5),
                                    const GeneralTextDisplay(
                                      '24h change',
                                      12,
                                      textColor: blackTint,
                                    )
                                  ],
                                ),
                                S(h: 5),
                                if (candlestick != null)...[
                                const GeneralTextDisplay(
                                  '520.80 + 1.25%',
                                  14,
                                  textColor: textGreen,
                                ),]
                                else
                                  const GeneralTextDisplay(
                                    '0.00 +0.00%',
                                    14,
                                    textColor: textGreen,
                                  ),
                              ],
                            ),
                          ),
                          S(w: 17),
                          Container(
                            width: 1,
                            height: 48,
                            color: divider.withOpacity(.08),
                          ),
                          S(w: 17),
                          SizedBox(
                            width: 90,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_upward_rounded,
                                      size: 18,
                                      color: blackTint,
                                    ),
                                    S(w: 5),
                                    const GeneralTextDisplay(
                                      '24h high',
                                      12,
                                      textColor: blackTint,
                                    )
                                  ],
                                ),
                                S(h: 5),
                                // if (candlestick != null)
                                const GeneralTextDisplay(
                                  '520.80 + 1.25%',
                                  14,
                                ),
                                // else
                                //     const GeneralTextDisplay(
                                //       '0.00 +0.00%',
                                //       14,
                                //     ),
                              ],
                            ),
                          ),
                          S(w: 17),
                          Container(
                            width: 1,
                            height: 48,
                            color: divider.withOpacity(.08),
                          ),
                          S(w: 17),
                          SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_downward_rounded,
                                      size: 18,
                                      color: blackTint,
                                    ),
                                    S(w: 5),
                                    const GeneralTextDisplay(
                                      '24h low',
                                      12,
                                      textColor: blackTint,
                                    )
                                  ],
                                ),
                                S(w: 5),
                                // if (candlestick != null)
                                const GeneralTextDisplay(
                                  '520.67 + 1.28',
                                  14,
                                )
                                // else
                                // const GeneralTextDisplay(
                                //   '0.00 -0.00%',
                                //   14,
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            S(h: 8),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                  color: Theme.of(context).shadowColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 42,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).shadowColor,
                        width: 1.5,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      onTap: (index) {
                        viewModel.updateCurrentTabIndex(index);
                      },
                      padding: const EdgeInsets.all(2),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      tabs: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Charts'),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Orderbook'),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Recent trades'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 580,
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Charts(),
                        const Orderbook(),
                        Container(
                          height: 30,
                          padding: const EdgeInsets.all(20),
                          child: const GeneralTextDisplay(
                            'Recent Trades',
                            20,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            S(h: 9),
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                  color: Theme.of(context).shadowColor,
                  width: 1.5,
                ),
              ),
              child: const Trades(),
            ),
          ],
          // Text(viewModel.someData),
        ),
      ],
    );
  }
}

void openBottomSheet(
  BuildContext context,
  UserAction userAction,
) {
  showModalBottomSheet<dynamic>(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    backgroundColor: context.isDarkMode() ? const Color(0xff20252B) : white,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext buildContext) {
      return const ActionBottomSheet();
    },
  );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:sisyphus/models/candleTickerModel.dart';
// import 'package:sisyphus/ui/widgets/appBar.dart';
// import 'package:sisyphus/ui/widgets/baseUI.dart';
// import 'package:sisyphus/ui/widgets/bottomSheet.dart';
// import 'package:sisyphus/ui/widgets/charts.dart';
// import 'package:sisyphus/ui/widgets/orderBook.dart';
// import 'package:sisyphus/ui/widgets/uiElements/buttons.dart';
// import 'package:sisyphus/ui/widgets/uiElements/generalTextDisplay.dart';
// import 'package:sisyphus/ui/widgets/uiElements/sizedBox.dart';
// import 'package:sisyphus/ui/widgets/trades.dart';
// import 'package:sisyphus/utils/appTheme.dart';
// import 'package:sisyphus/utils/assets.dart';
// import 'package:sisyphus/utils/chartController.dart';
// import 'package:sisyphus/utils/constants.dart';
// import 'package:sisyphus/viewmodels/bottomSheet.dart';
// import 'package:sisyphus/viewmodels/home.dart';
//
// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   final drawerItems = [
//     'Exchange',
//     'Wallets',
//     'Roqqu Hub',
//     'Log out',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   void _handleMenuPressed() {
//     final homeViewModel = ref.read(homeViewModelProvider.notifier);
//     homeViewModel.handleMenuPressed(_key);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = ref.watch(homeViewModelProvider.notifier);
//     final currentSymbol = ref.watch(currentSymbolStateProvider);
//     final state = ref.watch(homeViewModelProvider);
//     final candlestick = ref.watch(candleTickerStateProvider);
//
//     // Use MediaQuery to get the screen width
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isWeb = screenWidth > 800;
//
//     return BaseUi(
//       scaffoldKey: _key,
//       safeTop: true,
//       refreshedEnabled: false,
//       appBar: CustomizedAppBar(
//         onMenuPressed: _handleMenuPressed,
//       ),
//       endDrawer: buildDrawer(context),
//       bottomSheet: isWeb ? null : buildBottomSheet(context),
//       children: [
//         isWeb ? _buildWebLayout(context, currentSymbol as String?, candlestick, viewModel) : _buildMobileLayout(context, currentSymbol as String?, candlestick, viewModel),
//       ],
//     );
//   }
//   Widget _buildWebLayout(BuildContext context, String? currentSymbol, CandleTickerModel? candlestick, HomeViewModel viewModel) {
//     return Column(
//       children: [
//         S(h: 8),
//         buildInfoCard(context, currentSymbol, candlestick),
//         S(h: 8),
//         Container(
//           height: 280, // Adjust the height as needed
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                     border: Border.all(
//                       color: Theme.of(context).shadowColor,
//                       width: 1.5,
//                     ),
//                   ),
//                   child: const Charts(),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).cardColor,
//                           border: Border.all(
//                             color: Theme.of(context).shadowColor,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: const Orderbook(),
//                       ),
//                     ),
//                     S(h: 8),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).cardColor,
//                           border: Border.all(
//                             color: Theme.of(context).shadowColor,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: const Trades(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         S(h: 8),
//         buildBottomSheet(context),
//         S(h: 8),
//       ],
//     );
//   }
//
//   // Widget _buildWebLayout(BuildContext context, String? currentSymbol, CandleTickerModel? candlestick, HomeViewModel viewModel) {
//   //   return Column(
//   //     children: [
//   //       S(h: 8),
//   //       buildInfoCard(context, currentSymbol, candlestick),
//   //       S(h: 8),
//   //       Expanded(
//   //         child: Row(
//   //           children: [
//   //             Expanded(
//   //               flex: 2,
//   //               child: Container(
//   //                 decoration: BoxDecoration(
//   //                   color: Theme.of(context).cardColor,
//   //                   border: Border.all(
//   //                     color: Theme.of(context).shadowColor,
//   //                     width: 1.5,
//   //                   ),
//   //                 ),
//   //                 child: const Charts(),
//   //               ),
//   //             ),
//   //             Expanded(
//   //               flex: 1,
//   //               child: Column(
//   //                 children: [
//   //                   Expanded(
//   //                     child: Container(
//   //                       decoration: BoxDecoration(
//   //                         color: Theme.of(context).cardColor,
//   //                         border: Border.all(
//   //                           color: Theme.of(context).shadowColor,
//   //                           width: 1.5,
//   //                         ),
//   //                       ),
//   //                       child: const Orderbook(),
//   //                     ),
//   //                   ),
//   //                   S(h: 8),
//   //                   Expanded(
//   //                     child: Container(
//   //                       decoration: BoxDecoration(
//   //                         color: Theme.of(context).cardColor,
//   //                         border: Border.all(
//   //                           color: Theme.of(context).shadowColor,
//   //                           width: 1.5,
//   //                         ),
//   //                       ),
//   //                       child: const Trades(),
//   //                     ),
//   //                   ),
//   //                   S(h: 8),
//   //                   buildBottomSheet(context),  // Adding the bottom sheet here directly
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }
//
//   Widget _buildMobileLayout(BuildContext context, String? currentSymbol, CandleTickerModel? candlestick, HomeViewModel viewModel) {
//     return ListView(
//       padding: const EdgeInsets.only(bottom: 180),
//       children: [
//         S(h: 8),
//         buildInfoCard(context, currentSymbol, candlestick),
//         S(h: 8),
//         buildTabBar(context, viewModel),
//         S(h: 9),
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             border: Border.all(
//               color: Theme.of(context).shadowColor,
//               width: 1.5,
//             ),
//           ),
//           child: const Trades(),
//         ),
//       ],
//     );
//   }
//
//   Widget buildDrawer(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: 65,
//           right: 10,
//           child: Container(
//             height: 208,
//             width: 214,
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Theme.of(context).shadowColor,
//                 width: 1.5,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: drawerItems.map((e) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 13,
//                   ),
//                   child: GeneralTextDisplay(e, 16),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildBottomSheet(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         border: Border.all(
//           color: Theme.of(context).shadowColor,
//           width: 1.5,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 15),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: DefaultButton(
//                 title: 'Buy',
//                 onPressed: () {
//                   if (MediaQuery.of(context).size.width < 800) {  // Ensure this is not web view
//                     openBottomSheet(context, UserAction.buy);
//                   }
//                 },
//                 color: const Color(0xff25C26E),
//               ),
//             ),
//             S(w: 16),
//             Expanded(
//               child: DefaultButton(
//                 title: 'Sell',
//                 onPressed: () {
//                   if (MediaQuery.of(context).size.width < 800) {  // Ensure this is not web view
//                     openBottomSheet(context, UserAction.sell);
//                   }
//                 },
//                 color: const Color(0xffFF554A),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildInfoCard(BuildContext context, String? currentSymbol, CandleTickerModel? candlestick) {
//     return Container(
//         height: 120,
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           border: Border.all(
//             color: Theme.of(context).shadowColor,
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//             children: [
//             S(h: 20),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: [
//               SvgPicture.asset(
//                 ImageAssets.btcusd_icon,
//                 width: 44,
//                 height: 24,
//               ),
//               S(h: 8),
//               if (currentSymbol != null) ...[
//                 InkWell(
//                   onTap: () {},
//                   child: Row(
//                     children: [
//                       const GeneralTextDisplay("BTC/USDT", 18),
//                       S(w: 10),
//                       const Padding(
//                         padding: EdgeInsets.all(2),
//                         child: Icon(Icons.keyboard_arrow_down_rounded),
//                       ),
//                     ],
//                   ),
//                 ),
//                 S(w: 27),
//                 const GeneralTextDisplay('20,634', 18, textColor: textGreen),
//               ] else ...[
//                 const GeneralTextDisplay('--', 18),
//                 S(h: 10),
//                 InkWell(
//                   onTap: () {},
//                   child: const Padding(
//                     padding: EdgeInsets.all(2),
//                     child: Icon(Icons.keyboard_arrow_down_rounded),
//                   ),
//                 ),
//                 S(h: 27),
//                 const GeneralTextDisplay(r'$0.0', 18, textColor: textGreen),
//               ],
//             ],
//           ),
//         ),
//         S(h: 18),
//         Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//     buildInfoColumn(Icons.access_time_rounded, '24h change', '520.80 + 1.25%', candlestick != null),
//       S(w: 17),
//       buildDivider(),
//       S(w: 17),
//       buildInfoColumn(Icons.arrow_upward_rounded, '24h high', '520.80 + 1.25%', candlestick != null),
//       S(w: 17),
//       buildDivider(),
//       S(w: 17),
//       buildInfoColumn(Icons.arrow_downward_rounded, '24h low', '520.67 + 1.28', candlestick != null),
//     ],
//     ),
//     ),
//         ),
//             ],
//         ),
//     );
//   }
//
//   Widget buildInfoColumn(IconData icon, String label, String value, bool isDataAvailable) {
//     return SizedBox(
//       width: 100,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, size: 18, color: blackTint),
//               S(w: 5),
//               GeneralTextDisplay(label, 12, textColor: blackTint),
//             ],
//           ),
//           S(h: 5),
//           GeneralTextDisplay(isDataAvailable ? value : '0.00 +0.00%', 14, textColor: textGreen),
//         ],
//       ),
//     );
//   }
//
//   Widget buildDivider() {
//     return Container(
//       width: 1,
//       height: 48,
//       color: divider.withOpacity(.08),
//     );
//   }
//
//   Widget buildTabBar(BuildContext context, HomeViewModel viewModel) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         border: Border.all(
//           color: Theme.of(context).shadowColor,
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 42,
//             margin: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               color: Theme.of(context).shadowColor,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: Theme.of(context).shadowColor,
//                 width: 1.5,
//               ),
//             ),
//             child: TabBar(
//               controller: _tabController,
//               onTap: (index) {
//                 viewModel.updateCurrentTabIndex(index);
//               },
//               padding: const EdgeInsets.all(2),
//               labelStyle: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 13,
//               ),
//               tabs: [
//                 DecoratedBox(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text('Charts'),
//                 ),
//                 DecoratedBox(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text('Orderbook'),
//                 ),
//                 DecoratedBox(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text('Recent trades'),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 300,
//             child: TabBarView(
//               controller: _tabController,
//               physics: const NeverScrollableScrollPhysics(),
//               children: const [
//                 Charts(),
//                 Orderbook(),
//                 Trades(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void openBottomSheet(
//     BuildContext context,
//     UserAction userAction,
//     ) {
//   showModalBottomSheet<dynamic>(
//     isScrollControlled: true,
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(16),
//         topRight: Radius.circular(16),
//       ),
//     ),
//     backgroundColor: context.isDarkMode() ? const Color(0xff20252B) : white,
//     barrierColor: Colors.black.withOpacity(0.5),
//     builder: (BuildContext buildContext) {
//       return const ActionBottomSheet();
//     },
//   );
// }
//
//
