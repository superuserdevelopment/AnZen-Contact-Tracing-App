import 'package:flutter/material.dart';
import 'package:nss_digital_diary/pages/fragments/diary_fragment.dart';
import 'package:nss_digital_diary/pages/fragments/new_event_fragment.dart';
import 'package:nss_digital_diary/pages/fragments/qr_scanner.dart';
import 'package:nss_digital_diary/pages/fragments/reports_fragment.dart';
import 'package:nss_digital_diary/pages/home_page.dart';
import 'package:nss_digital_diary/pages/login_page.dart';
import 'package:nss_digital_diary/services/auth.dart';
import 'package:nss_digital_diary/services/wrapper.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    StreamProvider<User>.value(
      value: AuthenticationService().user,
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Wrapper(),
        '/newActivity': (context) => HomePage(2),
        '/diary': (context) => HomePage(1),
        '/reports': (context) => HomePage(3),
        '/qr': (context) => QRScanner(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Color(0xFF36326F),
        fontFamily: 'Neue_Montreal',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: Wrapper(),
    );
  }
}
