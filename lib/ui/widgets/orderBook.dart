import 'package:sisyphus/utils/imports/generalImports.dart';
import 'package:sisyphus/utils/orderBookController.dart';

class Orderbook extends ConsumerStatefulWidget {
  const Orderbook({super.key});

  @override
  ConsumerState<Orderbook> createState() => _OrderbookState();
}
class _OrderbookState extends ConsumerState<Orderbook> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchOrderbook();
    });
  }

  void _fetchOrderbook() {
    final orderBookController = ref.read(orderBookStateProvider.notifier);
    orderBookController.fetchOrderbook();
  }

  @override
  Widget build(BuildContext context) {
    final orderBookState = ref.watch(orderBookStateProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: context.isDarkMode()
                          ? const Color(0xff353945)
                          : const Color(0xffCFD3D8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SvgPicture.asset(
                      ImageAssets.select1_icon,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      // color: Color(0xffCFD3D8),
                    ),
                    child: SvgPicture.asset(
                      ImageAssets.select2_icon,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: const BoxDecoration(
                      // color: Color(0xffCFD3D8),
                    ),
                    child: SvgPicture.asset(
                      ImageAssets.select2_icon,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.isDarkMode()
                      ? const Color(0xff353945)
                      : const Color(0xffCFD3D8),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    const GeneralTextDisplay(
                      '10',
                      12,
                    ),
                    S(h:5),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
        S(h:12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralTextDisplay(
                    'Price',
                    15,
                    textColor: context.isDarkMode() ? blackTint : blackTint2,
                  ),
                  S(h:5),
                  GeneralTextDisplay(
                    '(USDT)',
                    11,
                    textColor: context.isDarkMode() ? blackTint : blackTint2,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GeneralTextDisplay(
                    'Amounts',
                    15,
                    textColor: context.isDarkMode() ? blackTint : blackTint2,
                  ),
                  S(h:5),
                  GeneralTextDisplay(
                    '(BTC)',
                    11,
                    textColor: context.isDarkMode() ? blackTint : blackTint2,
                  )
                ],
              ),
              GeneralTextDisplay(
                'Total',
                15,
                textColor: context.isDarkMode() ? blackTint : blackTint2,
              ),
            ],
          ),
        ),
        S(h:15),
        if (orderBookState.asks != null && orderBookState.bids != null) ...[
          Column(
            children: List.generate(
              orderBookState.asks!.length > 5 ? 5 : orderBookState.asks!.length,
                  (index) => Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: const Color(0xffFF6838).withOpacity(.15),
                      height: 28,
                      width: (double.tryParse(orderBookState.asks![index][0])! *
                          double.tryParse(orderBookState.asks![index][1])!) /
                          100,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GeneralTextDisplay(
                          orderBookState.asks![index][0],
                          15,
                          textColor:  const Color(0xffFF6838),
                        ),
                        GeneralTextDisplay(
                          double.tryParse(
                            orderBookState.asks![index][1],
                          )!
                              .toStringAsFixed(3),
                          15,
                        ),
                        GeneralTextDisplay(
                          (double.tryParse(orderBookState.asks![index][0])! +
                              double.tryParse(orderBookState.asks![index][1])!)
                              .formatValue2(),
                          15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          S(h:19),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GeneralTextDisplay(
                '${double.tryParse(orderBookState.asks![1]![0]!.toString())}',
                16,
                textColor: const Color(0xff25C26E),
              ),
              S(h:13),
              Icon(
                Icons.arrow_upward_rounded,
                size: 18,
                color:
                context.isDarkMode() ? blackTint : const Color(0xff25C26E),
              ),
              S(h:13),
              GeneralTextDisplay(
                '${double.tryParse(orderBookState.bids![1]![0]!.toString())}',
                16,
                textColor: context.isDarkMode() ? white : appBlack,
              ),
            ],
          ),
          S(h:19),
          IntrinsicHeight(
            child: Column(
              children: List.generate(
                orderBookState.bids!.length > 5 ? 5 : orderBookState.bids!.length,
                    (index) => Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        color: const Color(0xff25C26E).withOpacity(.15),
                        height: 30,
                        width: (double.tryParse(orderBookState.bids![index]![0])! *
                            double.tryParse(orderBookState.bids![index]![1])!) /
                            100,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GeneralTextDisplay(
                            '${double.tryParse(orderBookState.bids![index]![0]!.toString())}',
                            15,
                            textColor: const Color(0xffFF6838),
                          ),
                          GeneralTextDisplay(
                            double.tryParse(
                              orderBookState.bids![index]![1]!.toString(),
                            )!
                                .toStringAsFixed(3),
                            15,
                          ),
                          GeneralTextDisplay(
                            (double.tryParse(orderBookState.bids![index]![0])! +
                                double.tryParse(orderBookState.bids![index]![1])!)
                                .formatValue2(),
                            15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        S(h:19),
      ],
    );
  }
}