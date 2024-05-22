// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sisyphus/utils/appTheme.dart';
//
// class CustomCheckbox extends ConsumerWidget {
//   const CustomCheckbox({
//     required this.value,
//     super.key,
//     this.onSwitch,
//     this.text,
//   });
//
//   final bool value;
//   final ValueChanged<bool>? onSwitch;
//   final Widget? text;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isToggled = ref.watch(customCheckboxStateProvider(value));
//
//     return InkWell(
//       onTap: () {
//         ref.read(customCheckboxStateProvider(value).notifier).toggle();
//         if (onSwitch != null) {
//           onSwitch!(isToggled);
//         }
//       },
//       child: Row(
//         children: [
//           AnimatedContainer(
//             height: 17,
//             width: 17,
//             duration: const Duration(milliseconds: 300),
//             decoration: BoxDecoration(
//               color: isToggled ? Theme.of(context).cardColor : Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(
//                 color: blackTint,
//                 width: 1.1,
//               ),
//             ),
//             child: isToggled
//                 ? const Center(
//               child: Icon(
//                 Icons.check_rounded,
//                 size: 13,
//                 color: blackTint2,
//               ),
//             )
//                 : const SizedBox(),
//           ),
//           if (text != null) ...[text!]
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCheckboxState extends StateNotifier<bool> {
  CustomCheckboxState(bool initialValue) : super(initialValue);

  void toggle() {
    state = !state;
  }
}

final customCheckboxStateProvider =
StateNotifierProvider.autoDispose<CustomCheckboxState, bool>((ref) {
  return CustomCheckboxState(false); // Initial value can be set here
});

class CustomCheckbox extends ConsumerWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onSwitch,
    required this.text,
  });

  final bool value;
  final ValueChanged<bool> onSwitch;
  final Widget text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isToggled = ref.watch(customCheckboxStateProvider);
    return GestureDetector(
      onTap: () {
        ref.read(customCheckboxStateProvider.notifier).toggle();
        onSwitch(!isToggled);
      },
      child: Row(
        children: [
          AnimatedContainer(
            height: 17,
            width: 17,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isToggled ? Theme.of(context).cardColor : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.black,
                width: 1.1,
              ),
            ),
            child: isToggled
                ? const Center(
              child: Icon(
                Icons.check_rounded,
                size: 13,
                color: Colors.black,
              ),
            )
                : const SizedBox(),
          ),
          if (text != null) ...[text]
        ],
      ),
    );
  }
}
