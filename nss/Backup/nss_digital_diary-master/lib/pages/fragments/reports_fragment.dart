import 'package:flutter/material.dart';

class ReportsFragment extends StatefulWidget {
  @override
  _ReportsFragmentState createState() => _ReportsFragmentState();
}

class _ReportsFragmentState extends State<ReportsFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: ListView(
            children: [
              Text(
                'Reports',
                style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Neue_Montreal',
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
