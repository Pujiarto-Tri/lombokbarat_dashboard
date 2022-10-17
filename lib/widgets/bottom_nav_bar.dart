import 'package:flutter/material.dart';

import '../screens/screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              icon: const Icon(Icons.home)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, PermohonanInformasiScreen.routeName);
              },
              icon: const Icon(Icons.document_scanner_rounded)),
          label: 'Permohonan Informasi',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, LaporanLayananScreen.routeName);
              },
              icon: const Icon(Icons.report)),
          label: 'Laporan Pelayanan',
        ),
      ],
    );
  }
}
