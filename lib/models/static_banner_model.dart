import 'package:ppid_flutter/screens/screen.dart';

final List<Map<String, dynamic>> staticBanner = [
  {
    'app_name': 'Inovasi',
    'routeName': WebViewScreen.routeName,
    'arguments': {
      'link':
          'https://lombokbaratkab.go.id/penjaringan-inovasi-daerah-kabupaten-lombok-barat-tahun-2023/'
    },
    'img': 'assets/images/dashboard_banner/inovasi_banner.jpeg'
  },
  {
    'app_name': 'Lapor',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://lombokbarat.lapor.go.id'},
    'img': 'assets/images/dashboard_banner/lapor_banner.png'
  },
];
