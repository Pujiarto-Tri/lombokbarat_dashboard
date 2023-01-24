import 'package:ppid_flutter/screens/screen.dart';

final List<Map<String, dynamic>> appMenu = [
  {'app_name': 'PPID', 'routeName': PpidScreen.routeName},
  {
    'app_name': 'LPSE',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'http://lpse.lombokbaratkab.go.id/eproc4/'}
  },
  {
    'app_name': 'LHKPN',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://lombokbaratkab.go.id/lhkpn/'}
  },
  {
    'app_name': 'JDIH',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://jdih.lombokbaratkab.go.id/'}
  },
  {
    'app_name': 'SAKIP',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'http://sakip.lombokbaratkab.go.id/portal/home'}
  },
  {
    'app_name': 'Survey',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://ikm.lombokbaratkab.go.id/'}
  },
  {
    'app_name': 'RPJMD',
    'routeName': WebViewScreen.routeName,
    'arguments': {
      'link':
          'https://lombokbaratkab.go.id/rencana-pembangunan-jangka-menengah-daerah-rpjmd-kabupaten-lombok-barat-tahun-2019-2024/'
    }
  },
  {
    'app_name': 'E-Kinerja',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://ekinerja-asn.lombokbaratkab.go.id/'}
  },
];
