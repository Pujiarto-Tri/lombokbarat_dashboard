import 'dart:io';

import 'package:flutter/material.dart';
import 'screens/screen.dart';

//================== W A R N I N G ===========================//
//  THIS CLASS FOR TESTING PURPOSES ONLY //
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
//============== END OF WARNING ==============================//

void main() {
  //================ W A R N I N G=============================//
  HttpOverrides.global = MyHttpOverrides();
  //==========================================================//
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
