import 'package:sisyphus/utils/imports/generalImports.dart';

class ActionBottomSheet extends ConsumerWidget {
  const ActionBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(bottomSheetViewModelProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 34, 30, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  CupertinoSlidingSegmentedControl(
                    backgroundColor: context.isDarkMode()
                        ? black.withOpacity(.16)
                        : const Color(0xffF1F1F1),
                    thumbColor:
                    context.isDarkMode() ? const Color(0xff21262C) : white,
                    padding: const EdgeInsets.all(3),
                    groupValue: viewModel.selectedAction.index,
                    children: {
                      UserAction.buy.index: Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: GeneralTextDisplay(
                            'Buy',
                            15,
                          ),
                        ),
                      ),
                      UserAction.sell.index: Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: GeneralTextDisplay(
                            'Sell',
                            15,
                          ),
                        ),
                      ),
                    },
                    onValueChanged: (value) {
                      viewModel.updateSelectedAction(UserAction.values[value!]);
                    },
                  ),
                ],
              ),
            ),
            S(h:18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: viewModel.options.map(
                    (e) => InkWell(
                  onTap: () {
                    viewModel.updateSelectedOption(e);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: viewModel.selectedOption == e
                          ? context.isDarkMode()
                          ? const Color(0xff555C63)
                          : const Color(0xffCFD3D8)
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: GeneralTextDisplay(
                        e,
                        14,
                        textColor: context.isDarkMode() ? white : rockBlack,
                      ),
                    ),
                  ),
                ),
              ).toList(),
            ),
            S(h: 16),
            InputField(
              hintText: 'Limit price',
              suffixText: '0.00 USD',
              controller: TextEditingController(),
            ),
            S(h: 16),
            InputField(
              hintText: 'Amount',
              suffixText: '0.00 USD',
              controller: TextEditingController(),
            ),
            S(h: 16),
            InputField(
              isReadOnly: true,
              hintText: 'Type',
              suffixText: 'Good till cancelled',
              controller: TextEditingController(),
            ),
            S(h: 16),
            CustomCheckbox(
              value: true,
              onSwitch: (val) {},
              text: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    const GeneralTextDisplay(
                      'Post Only',
                      15,
                    ),
                    S(w:6),
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 14,
                    )
                  ],
                ),
              ),
            ),
            S(h:16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralTextDisplay(
                  'Total',
                  12,
                  textColor: blackTint,
                ),
                GeneralTextDisplay(
                  '0.00',
                  12,
                  textColor: blackTint,
                ),
              ],
            ),
            S(h:16),
            DefaultGradientButton(
              width: double.infinity,
              title: 'Buy BTC',
              onPressed: () {},
            ),
            S(h:15),
            Divider(
              color: blackTint.withOpacity(.1),
              thickness: 1,
            ),
            S(h:15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralTextDisplay(
                  'Total account value',
                  12,
                  textColor: blackTint,
                ),
                Row(
                  children: [
                    GeneralTextDisplay(
                      'NGN',
                      12,
                      textColor: blackTint,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: blackTint,
                    )
                  ],
                ),
              ],
            ),
            S(h:8),
            const GeneralTextDisplay(
              '0.00',
              14,
              textFontWeight: FontWeight.w600,
            ),
            S(h:16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralTextDisplay(
                  'Open Orders',
                  12,
                  textColor: blackTint,
                ),
                GeneralTextDisplay(
                  'Available',
                  12,
                  textColor: blackTint,
                ),
              ],
            ),
            S(h:8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralTextDisplay(
                  '0.00',
                  14,
                  textFontWeight: FontWeight.w600,
                ),
                GeneralTextDisplay(
                  '0.00',
                  14,
                  textFontWeight: FontWeight.w600,
                ),
              ],
            ),
            S(h:32),
            DefaultButton(
              title: 'Deposit',
              onPressed: () {},
              color: const Color(0xff2764FF),
            ),
          ],
        ),
      ),
    );
  }
}
