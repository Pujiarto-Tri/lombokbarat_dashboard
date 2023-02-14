import 'package:ppid_flutter/screens/screen.dart';

final List<Map<String, dynamic>> appMenu = [
  {
    'app_name': 'PPID',
    'routeName': PpidScreen.routeName,
    'icon': 'assets/images/app_icon/logo_ppid.png'
  },
  {
    'app_name': 'LPSE',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'http://lpse.lombokbaratkab.go.id/eproc4/'},
    'icon': 'assets/images/app_icon/logo-LPSE-3.png'
  },
  {
    'app_name': 'LHKPN',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://lombokbaratkab.go.id/lhkpn/'},
    'icon': 'assets/images/app_icon/logo_elhkpn.png'
  },
  {
    'app_name': 'JDIH',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://jdih.lombokbaratkab.go.id/'},
    'icon': 'assets/images/app_icon/logo_jdih.png'
  },
  {
    'app_name': 'SAKIP',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'http://sakip.lombokbaratkab.go.id/portal/home'},
    'icon': 'assets/images/app_icon/logo_sakip.png',
  },
  {
    'app_name': 'Survey',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://ikm.lombokbaratkab.go.id/'},
    'icon': 'assets/images/app_icon/logo_survey.png'
  },
  {
    'app_name': 'RPJMD',
    'routeName': WebViewScreen.routeName,
    'arguments': {
      'link':
          'https://lombokbaratkab.go.id/rencana-pembangunan-jangka-menengah-daerah-rpjmd-kabupaten-lombok-barat-tahun-2019-2024/'
    },
    'icon': 'assets/images/app_icon/logo_rpjmd.png'
  },
  {
    'app_name': 'E-Kinerja',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://ekinerja-asn.lombokbaratkab.go.id/'},
    'icon': 'assets/images/app_icon/logo_ekinerja.png'
  },
  {
    'app_name': 'LAPOR!',
    'routeName': WebViewScreen.routeName,
    'arguments': {
      'link':
          'https://www.lapor.go.id/instansi/pemerintah-kabupaten-lombok-barat'
    },
    'icon': 'assets/images/app_icon/logo_lapor.jpg'
  },
  {
    'app_name': 'OPD',
    'routeName': OpdListScreen.routeName,
    'icon': 'assets/images/app_icon/logo_opd.png'
  },
  {
    'app_name': 'Kecamatan',
    'routeName': OpdListScreen.routeName,
    'icon': 'assets/images/app_icon/logo_kecamatan.png'
  },
  {
    'app_name': 'Desa',
    'routeName': OpdListScreen.routeName,
    'icon': 'assets/images/app_icon/logo_desa.png'
  },
  {
    'app_name': 'Telpon',
    'routeName': OpdListScreen.routeName,
    'icon': 'assets/images/app_icon/logo_telpon.png'
  },
];
