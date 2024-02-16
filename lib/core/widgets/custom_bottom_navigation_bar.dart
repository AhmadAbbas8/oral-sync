import "package:flutter/material.dart";

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.black12,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          fixedColor: Colors.black,
          selectedIconTheme: const IconThemeData(
            color: Colors.black,
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentIndex == 0 ? Colors.black : Colors.grey,
              ),
              label: 'Home',
            ),
            //
            BottomNavigationBarItem(
              icon: Icon(
                Icons.messenger,
                color: currentIndex == 1 ? Colors.black : Colors.grey,
              ),
              label: 'Message',
            ),
            //
            BottomNavigationBarItem(
              icon: Icon(
                Icons.archive_rounded,
                color: currentIndex == 2 ? Colors.black : Colors.grey,
              ),
              label: 'Archive',
            ),
            //
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
                color: currentIndex == 3 ? Colors.black : Colors.grey,
              ),
              label: 'My Profile',
            ),
          ],
        ));
  }
}
