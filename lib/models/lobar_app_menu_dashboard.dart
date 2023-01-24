import 'package:ppid_flutter/screens/screen.dart';

final List<Map<String, dynamic>> appMenu = [
  {'text': 'PPID', 'routeName': HomeScreen.routeName},
  {
    'text': 'LPSE',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'http://lpse.lombokbaratkab.go.id/eproc4/'}
  },
  {
    'text': 'LHKPN',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://lombokbaratkab.go.id/lhkpn/'}
  },
  {
    'text': 'JDIH',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'https://jdih.lombokbaratkab.go.id/'}
  },
  {
    'text': 'SAKIP',
    'routeName': WebViewScreen.routeName,
    'arguments': {'link': 'http://sakip.lombokbaratkab.go.id/portal/home'}
  },
];
