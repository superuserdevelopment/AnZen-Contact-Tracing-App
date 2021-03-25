import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nss_digital_diary/models/user.dart';
import 'package:nss_digital_diary/pages/fragments/diary_fragment.dart';
import 'package:nss_digital_diary/pages/fragments/new_event_fragment.dart';
import 'package:nss_digital_diary/pages/fragments/reports_fragment.dart';
import 'package:nss_digital_diary/pages/loading.dart';
import 'package:nss_digital_diary/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import 'fragments/account_fragment.dart';
import 'fragments/landing_fragment.dart';

class HomePage extends StatefulWidget {
  int index = 0;
  HomePage(int i) {
    index = i;
  }
  @override
  _HomePageState createState() => _HomePageState(index);
}

class _HomePageState extends State<HomePage> {
  final AuthenticationService _auth = AuthenticationService();
  //final DatabaseService _databaseService = DatabaseService();
  final List<Widget> _fragments = [
    LandingFragment(),
    DiaryFragment(),
    NewEventFragment(),
    ReportsFragment(),
    AccountFragment(),
  ];
  int _currentIndex = 0;

  _HomePageState(int index) {
    _currentIndex = index;
  }
  @override
  void initState() {
    super.initState();
    //_databaseService.retrieveCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // body: SafeArea(
        //   child: _fragments[_currentIndex],
        // ),
        body: Stack(
          children: [
            appBarHomePage(context),
            _fragments[_currentIndex],
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
          child: CustomNavigationBar(
            backgroundColor: Theme.of(context).accentColor,
            iconSize: 30.0,
            elevation: 10.0,
            currentIndex: _currentIndex,
            strokeColor: Colors.white,
            borderRadius: Radius.circular(15.0),
            selectedColor: Theme.of(context).primaryColor,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            unSelectedColor: Colors.white,
            isFloating: true,
            items: [
              CustomNavigationBarItem(
                icon: Icons.home,
              ),
              CustomNavigationBarItem(
                icon: Icons.book,
              ),
              CustomNavigationBarItem(icon: Icons.add_circle),
              CustomNavigationBarItem(
                icon: Icons.graphic_eq,
              ),
              CustomNavigationBarItem(
                icon: Icons.account_circle,
              ),
            ],
          ),
        ));
  }
}

Widget appBarHomePage(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 8,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(
        bottom: new Radius.circular(25.0),
      ),
      boxShadow: [
        BoxShadow(blurRadius: 10.0, color: Colors.grey[900]),
      ],
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Image.asset(
          //   'assets/rasters/icon.png',
          //   width: 47.0,
          // ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "Home",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0,
            ),
          )
        ],
      ),
    ),
  );
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        // boxShadow: [
        //   BoxShadow(blurRadius: 10.0, color: Colors.grey[900]),
        // ],
        color: Colors.white,
      ),
    );
  }
}

// Widget horizontalCard(String text, BuildContext context, Color color) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 7.5),
//     child: Container(
//         //height: 50.0,
//         //width: 100.0,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25.0),
//           // boxShadow: [
//           //   BoxShadow(blurRadius: 10.0, color: Colors.grey[900]),
//           // ],
//           color: color,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 text,
//                 style: TextStyle(fontSize: 16.0),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 color: Colors.white,
//               )
//             ],
//           ),
//         )),
//   );
// }

// Widget horizontalCardFull(
//     BuildContext context, String title, String desc, double height) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 7.5),
//     child: Container(
//         height: height,
//         width: MediaQuery.of(context).size.width / 2 - 30.0,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25.0),
//           // boxShadow: [
//           //   BoxShadow(blurRadius: 10.0, color: Colors.grey[900]),
//           // ],
//           color: Theme.of(context).primaryColorLight,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               icon,
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               Text(
//                 desc,
//                 style: TextStyle(fontSize: 12.0),
//               ),
//             ],
//           ),
//         )),
//   );
// }
