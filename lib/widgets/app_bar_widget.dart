import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool centerTitle;
  final String? title;
  final Widget? titleWidget;
  final Icon? leadingIcon;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    this.title,
    this.leadingIcon,
    this.onLeadingTap,
    this.actions,
    this.centerTitle = true,
    this.titleWidget,
  });

  get _leading {
    return InkWell(
      onTap: () {
        if (onLeadingTap != null) onLeadingTap!();
        Get.back();
      },
      child: leadingIcon ?? const Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      leading: !_isFirstPage() ? _leading : null,
      title: titleWidget ?? Text(title ?? ""),
      actions: actions,
    );
  }

  _isFirstPage() {
    return Get.previousRoute.isEmpty || Get.previousRoute == "/" || Get.currentRoute == "/";
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
