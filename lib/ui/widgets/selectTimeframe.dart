import 'package:sisyphus/utils/chartControllerProvider.dart';
import 'package:sisyphus/utils/imports/generalImports.dart';

class TimeframeSelector extends ConsumerWidget {
  TimeframeSelector({
    required this.onSelected,
    super.key,
  });

  final Function(String) onSelected;

  final List<String> timeframes = [
    '1H',
    '2H',
    '4H',
    '1D',
    '1W',
    '1M',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(currentTimeframeProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GeneralTextDisplay(
              'Time',
              14,
              textColor: context.isDarkMode() ? white : blackTint2,
            ),
            S(h:6),
            ...timeframes.map(
                  (e) => InkWell(
                onTap: () {
                  ref.read(currentTimeframeProvider.notifier).state = e;
                  onSelected.call(e);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 40,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: currentTime == e
                        ? context.isDarkMode()
                        ? const Color(0xff555C63)
                        : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: GeneralTextDisplay(
                      e,
                      14,
                      textColor: context.isDarkMode() ? white : blackTint2,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 25,
                    color: divider.withOpacity(.08),
                  ),
                  S(h:5),
                  SvgPicture.asset(
                    ImageAssets.charts_icon,
                    colorFilter: ColorFilter.mode(
                      context.isDarkMode() ? white : blackTint2,
                      BlendMode.colorBurn,
                    ),
                  )
                ],
              ),
            ),
            S(h:6),
            Container(
              width: 1,
              height: 25,
              color: divider.withOpacity(.08),
            ),
            S(h:6),
            GeneralTextDisplay(
              'Fx Indicators',
              14,
              textColor: context.isDarkMode() ? blackTint : blackTint2,
            ),
            S(h:6),
          ],
        ),
      ),
    );
  }
}
