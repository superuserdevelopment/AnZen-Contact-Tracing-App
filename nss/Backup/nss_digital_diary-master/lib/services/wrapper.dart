import 'package:nss_digital_diary/pages/home_page.dart';
import 'package:nss_digital_diary/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nss_digital_diary/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) user.display();
    if (user != null) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
