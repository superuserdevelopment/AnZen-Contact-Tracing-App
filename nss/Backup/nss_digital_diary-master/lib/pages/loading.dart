import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getData() async {
    await Future.delayed(Duration(seconds: 4));
    Navigator.pushNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitFadingGrid(
            size: 80.0,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Loading',
            style: TextStyle(color: Colors.white, fontSize: 40.0),
          ),
          Text(
            'Breathe in... Breathe out...',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'Circular-Medium'),
          ),
        ],
      )),
      bottomNavigationBar: _company(),
    );
  }
}

Widget _company() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'superuserdev </>',
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
      ],
    ),
  );
}
