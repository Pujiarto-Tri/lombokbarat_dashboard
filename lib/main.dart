import 'dart:io';

import 'package:flutter/material.dart';
import 'screens/screen.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

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

void main() async {
  //================ W A R N I N G=============================//
  HttpOverrides.global = MyHttpOverrides();
  //==========================================================//
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  requestStoragePermission();

  runApp(const MyApp());
}

void requestStoragePermission() async {
  var status = await Permission.storage.request();

  if (status.isGranted) {
    // Permission granted, you can perform actions that require storage access
  } else if (status.isDenied) {
    // Permission denied, show a message or dialog to the user explaining why permission is needed
  } else if (status.isPermanentlyDenied) {
    // Permission permanently denied, show a dialog to the user with instructions on how to enable the permission from settings
  }
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
        KecamatanListScreen.routeName: (context) => const KecamatanListScreen(),
        TelponListScreen.routeName: (context) => const TelponListScreen(),
      },
    );
  }
}
