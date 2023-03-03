import 'package:ppid_flutter/screens/screen.dart';

final List<Map<String, dynamic>> bannerDashboard = [
  {
    'banner_title': 'Lapor!',
    'routeName': WebViewScreen.routeName,
    'img': 'assets/images/dashboard_banner/lapor_banner.png',
    'arguments': {'link': 'https://lombokbarat.lapor.go.id/'}
  },
  {
    'banner_title': 'Pajak',
    'routeName': WebViewScreen.routeName,
    'img': 'assets/images/dashboard_banner/pajak_banner.jpeg',
    'arguments': {
      'link':
          'https://bapenda.lombokbaratkab.go.id/pengumuman/pembayaran-pbb-p2-sekarang-sudah-on-line--29/'
    }
  },
  {
    'banner_title': 'Posyandu',
    'routeName': WebViewScreen.routeName,
    'img': 'assets/images/dashboard_banner/posyandu_banner.jpeg',
  },
];
