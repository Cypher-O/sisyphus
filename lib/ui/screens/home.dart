import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sisyphus/ui/widgets/appBar.dart';
import 'package:sisyphus/ui/widgets/baseUI.dart';
import 'package:sisyphus/ui/widgets/uiElements/buttons.dart';
import 'package:sisyphus/ui/widgets/uiElements/sizedBox.dart';
import 'package:sisyphus/utils/appTheme.dart';
import 'package:sisyphus/utils/assets.dart';
import 'package:sisyphus/utils/constants.dart';
import 'package:sisyphus/viewmodels/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseUi(
      safeTop: true,
      appBar: CustomizedAppBar(),
      children: [
        Consumer(
          builder: (context, ref, child) {
            final viewModel = ref.watch(homeViewModelProvider);
            return Center(
              child: Text(viewModel.someData),
            );
          },
        ),
      ],
    );
  }
}
