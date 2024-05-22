import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/ui/widgets/uiElements/generalTextDisplay.dart';
import 'package:sisyphus/ui/widgets/uiElements/sizedBox.dart';
import 'package:sisyphus/utils/appTheme.dart';
import 'package:sisyphus/utils/constants.dart';
import 'package:sisyphus/viewmodels/trades.dart';

class Trades extends StatefulWidget {
  const Trades({super.key});

  @override
  State<Trades> createState() => _TradesState();
}

class _TradesState extends State<Trades> {
  final ValueNotifier<int> _selectedValue = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final tradesViewModel = ref.watch(tradesViewModelProvider);
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(15),
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    SizedBox(
                      child: ValueListenableBuilder<int>(
                        valueListenable: _selectedValue,
                        builder: (context, value, child) {
                          return CupertinoSlidingSegmentedControl(
                            backgroundColor: context.isDarkMode()
                                ? black.withOpacity(.16)
                                : const Color(0xffF1F1F1),
                            thumbColor: context.isDarkMode()
                                ? const Color(0xff21262C)
                                : white,
                            padding: const EdgeInsets.all(2),
                            groupValue: value,
                            children: {
                              0: Container(
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: GeneralTextDisplay(
                                    'Open Orders',
                                    15,
                                  ),
                                ),
                              ),
                              1: Container(
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: GeneralTextDisplay(
                                    'Positions',
                                    15,
                                  ),
                                ),
                              ),
                              2: Container(
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: GeneralTextDisplay(
                                    'Order History',
                                    15,
                                  ),
                                ),
                              ),
                              3: Container(
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: GeneralTextDisplay(
                                    'Trade History',
                                    15,
                                  ),
                                ),
                              ),
                            },
                            onValueChanged: (value) {
                              if (value != null) {
                                _selectedValue.value = value;
                                tradesViewModel.setSelectedValue(value);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: _selectedValue,
                builder: (context, value, child) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        S(h: 30),
                         GeneralTextDisplay(
                          value == 0
                              ? 'No Open Orders'
                              : value == 1
                              ? 'No Positions'
                              : value == 2
                              ? 'No Order History'
                              : 'No Trade History',
                          20,
                        ),
                        S(h: 15),
                        SizedBox(
                          width: 280,
                          child: GeneralTextDisplay(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                            15,
                            textAlign: TextAlign.center,
                            textColor:
                                context.isDarkMode() ? blackTint : blackTint2,
                            noOfTextLine: 3,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
