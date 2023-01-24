import 'package:flutter/material.dart';
import 'package:ppid_flutter/screens/opd_screen/opd_list_screen.dart';
import 'screens/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lombok Barat Dashboard',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900)),
      initialRoute: '/',
      routes: {
        PpidScreen.routeName: (context) => const PpidScreen(),
        DocumentScreen.routeName: (context) => const DocumentScreen(),
        PermohonanInformasiScreen.routeName: (context) =>
            const PermohonanInformasiScreen(),
        LaporanLayananScreen.routeName: (context) =>
            const LaporanLayananScreen(),
        DashboardScreen.routeName: (context) => const DashboardScreen(),
        WebViewScreen.routeName: (context) => const WebViewScreen(),
        OpdListScreen.routeName: (context) => const OpdListScreen(),
      },
    );
  }
}
