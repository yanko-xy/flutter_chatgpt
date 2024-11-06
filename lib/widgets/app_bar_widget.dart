import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool centerTitle;
  final String title;
  final Icon? leadingIcon;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingTap,
    this.actions,
    this.centerTitle = true,
  });

  get _leading {
    return InkWell(
      onTap: onLeadingTap,
      child: leadingIcon ?? const Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      leading: _leading,
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
