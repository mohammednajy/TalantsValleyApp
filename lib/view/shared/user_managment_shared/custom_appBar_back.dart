import 'package:flutter/material.dart';


class CustomAppBarWithBack extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithBack({
    required this.title,
    this.backWithClear,
    Key? key,
  }) : super(key: key);
  final String title;
  final Widget? backWithClear;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 80,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
      ),
      leading: backWithClear ??
          IconButton(
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.centerRight,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}
