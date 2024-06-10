import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotchBottomNavBar extends StatelessWidget {
  const NotchBottomNavBar({
    super.key,
    required this.titles,
    required this.icons,
    required this.currentIndex,
    this.onTap,
  });

  final List<String> titles;
  final List<IconData> icons;
  final int currentIndex ;
  final  Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.zero,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap:onTap ,
        items: List.generate(
          5,
          (index) => BottomNavigationBarItem(
            icon: Icon(icons[index]),
            label: titles[index].tr(),
            tooltip: titles[index].tr(),
          ),
        ),
      ),
    );
  }
}
