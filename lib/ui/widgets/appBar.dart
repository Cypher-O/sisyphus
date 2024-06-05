import 'package:sisyphus/utils/imports/generalImports.dart';

class CustomizedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  const CustomizedAppBar({super.key, required this.onMenuPressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).shadowColor,
            width: 1.5,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          ImageAssets.logo_icon,
          colorFilter: ColorFilter.mode(
            context.isDarkMode() ? Colors.white : Colors.black,
            BlendMode.srcIn,
          ),
        ),
        actions: [
          DefaultImageButton(
            image: ImageAssets.user_image,
            onPressed: () {},
          ),
          S(w: 15),
          DefaultImageButton(
            size: 24,
            image: ImageAssets.globe_icon,
            isSvg: true,
            onPressed: () {},
          ),
          S(w: 15),
          DefaultImageButton(
            image: ImageAssets.menu_icon,
            isSvg: true,
            onPressed: onMenuPressed,
          ),
          S(w: 15),
        ],
      ),
    );
  }
}
