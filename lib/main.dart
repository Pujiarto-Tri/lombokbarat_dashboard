import 'package:flutter/material.dart';
import 'screens/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900)),
      initialRoute: '/',
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        DocumentScreen.routeName: (context) => const DocumentScreen(),
        PermohonanInformasiScreen.routeName: (context) =>
            const PermohonanInformasiScreen(),
        LaporanLayananScreen.routeName: (context) =>
            const LaporanLayananScreen(),
        DashboardScreen.routeName: (context) => const DashboardScreen(),
        WebViewScreen.routeName: (context) => const WebViewScreen(),
      },
    );
  }
}
