import 'package:carousel_images/carousel_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nss_digital_diary/models/user.dart';
import 'package:nss_digital_diary/services/auth.dart';
import 'package:provider/provider.dart';

import '../loading.dart';

class LandingFragment extends StatefulWidget {
  @override
  _LandingFragmentState createState() => _LandingFragmentState();
}

class _LandingFragmentState extends State<LandingFragment> {
  final List<String> listImages = [
    'https://firebasestorage.googleapis.com/v0/b/digital-diary-8b01f.appspot.com/o/Image%20Carousel%2F5.jpg?alt=media&token=e3a5b375-c3ce-45ff-9da6-1f14d8ce0f55',
    'https://firebasestorage.googleapis.com/v0/b/digital-diary-8b01f.appspot.com/o/Image%20Carousel%2F4.jpg?alt=media&token=c2c3ca5c-adb5-47ec-88c9-92daf3ef7284',
    'https://firebasestorage.googleapis.com/v0/b/digital-diary-8b01f.appspot.com/o/Image%20Carousel%2F6.jpg?alt=media&token=808b9cad-e748-45fa-96d7-12961b6c4cf3',
    'https://firebasestorage.googleapis.com/v0/b/digital-diary-8b01f.appspot.com/o/Image%20Carousel%2F1.jpg?alt=media&token=6246c03f-08ef-49a8-b3d5-c21d615de8d9',
    'https://firebasestorage.googleapis.com/v0/b/digital-diary-8b01f.appspot.com/o/Image%20Carousel%2F2.jpg?alt=media&token=d70959e8-7599-47f0-be46-c92dcdd92004',
    'https://firebasestorage.googleapis.com/v0/b/digital-diary-8b01f.appspot.com/o/Image%20Carousel%2F3.jpg?alt=media&token=6cb21896-9983-416b-bada-5a1cd8d8cd1a',
  ];
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Logo(),
            ),
            SizedBox(height: 20.0),
            CarouselImages(
              scaleFactor: 0.6,
              listImages: listImages,
              height: 350.0,
              borderRadius: 25.0,
              cachedNetworkImage: true,
              verticalAlignment: Alignment.center,
              onTap: (index) {
                print('Tapped on page $index');
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: UpdatesCard()),
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/rasters/logo.png',
                width: 60.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    children: [
                      Text(
                        'National Service Scheme',
                        style: TextStyle(
                            //fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Vidyalankar School of Information Technology',
                        style: TextStyle(
                            fontSize: 8.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdatesCard extends StatefulWidget {
  @override
  _UpdatesCardState createState() => _UpdatesCardState();
}

class _UpdatesCardState extends State<UpdatesCard> {
  User user;
  int activites;
  int hours;

  void updateActivites() async {
    try {
      activites = await Firestore.instance
          .collection('Users')
          .document(user.uid)
          .collection('Events')
          .getDocuments()
          .then((myDocuements) {
        return myDocuements.documents.length;
      });
    } catch (e) {
      print(e);
      activites = 0;
      hours = 0;
    }
  }

  void updateHours() async {
    try {
      await Firestore.instance
          .collection('Users')
          .document(user.uid)
          .collection('Events')
          .snapshots()
          .listen((snapshot) {
        snapshot.documents.forEach((element) {
          int a = snapshot.documents
              .fold(0, (tot, doc) => tot + int.parse(doc.data['hours']));
          setState(() {
            hours = a;
          });
        });
      });
    } catch (e) {
      print(e);
      hours = 0;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activites = -1;
    hours = -1;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    if (activites == -1) {
      //print('fetching activities');
      updateActivites();
    }
    if (hours == -1 && activites != 0) {
      updateHours();
    }

    return StreamBuilder(
      stream:
          Firestore.instance.collection('Users').document(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot == null) {
          return LoadingScreen();
        }
        if (!snapshot.hasData) {
          return Text(
            'Loading, Please Wait',
            style: TextStyle(color: Colors.white),
          );
        }
        //updateActivites();
        // String event =
        //     snapshot.data['Event'] != null ? snapshot.data['Event'] : "null";
        // String college = snapshot.data['collegeName'] != null
        //     ? snapshot.data['collegeName']
        //     : "null";
        // String course = snapshot.data['course'] != null
        //     ? snapshot.data['course']
        //     : "null";
        // String bloodGroup = snapshot.data['bloodGroup'] != null
        //     ? snapshot.data['bloodGroup']
        //     : "null";
        // String birthdate = snapshot.data['birthdate'] != null
        //     ? snapshot.data['birthdate']
        //     : "null";
        // String volunteerEnrollmentCode =
        //     snapshot.data['volunteerEnrollmentCode'] != null
        //         ? snapshot.data['volunteerEnrollmentCode']
        //         : "null";
        // String address = snapshot.data['address'] != null
        //     ? snapshot.data['address']
        //     : "null";
        return Card(
          color: Theme.of(context).accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          elevation: 5.0,
          child: Container(
            //height: 100.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Progress",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubCard(
                          '     Hours     ',
                          hours.toString() == '-1' ? '0' : hours.toString(),
                          context),
                      SubCard('   Activites   ', activites.toString(), context),
                      SubCard(
                          'Hrs/Activity',
                          (hours.abs() / activites.abs()).toString() ==
                                  'Infinity'
                              ? 'NA'
                              : (hours.abs() / activites.abs())
                                  .floor()
                                  .toString(),
                          context),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget SubCard(String title, String value, BuildContext context) {
  return Card(
    elevation: 2,
    //color: Theme.of(context).primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Container(
      //width: 100,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$value",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    ),
  );
}
