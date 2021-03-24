import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nss_digital_diary/models/user.dart';
import 'package:nss_digital_diary/services/auth.dart';
import 'package:provider/provider.dart';

import '../loading.dart';

class AccountFragment extends StatefulWidget {
  @override
  _AccountFragmentState createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    print(user.uid);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Users')
            .document(user.uid)
            .snapshots(),
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
          String name =
              snapshot.data['name'] != null ? snapshot.data['name'] : "null";
          String email =
              snapshot.data['email'] != null ? snapshot.data['email'] : "null";
          String college = snapshot.data['collegeName'] != null
              ? snapshot.data['collegeName']
              : "null";
          String course = snapshot.data['course'] != null
              ? snapshot.data['course']
              : "null";
          String bloodGroup = snapshot.data['bloodGroup'] != null
              ? snapshot.data['bloodGroup']
              : "null";
          String birthdate = snapshot.data['birthdate'] != null
              ? snapshot.data['birthdate']
              : "null";
          String volunteerEnrollmentCode =
              snapshot.data['volunteerEnrollmentCode'] != null
                  ? snapshot.data['volunteerEnrollmentCode']
                  : "null";
          String address = snapshot.data['address'] != null
              ? snapshot.data['address']
              : "null";
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: ListView(
                  children: [
                    Text(
                      'My Profile',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Neue_Montreal',
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Center(
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 20.0),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Profile Details",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                Divider(
                                  color: Theme.of(context).accentColor,
                                  thickness: 2.0,
                                ),
                                Text(
                                  "Name: $name",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Email: $email",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "College Name: $college",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Course: $course",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Birth Date: $birthdate",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Address: $address",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Blood Group: $bloodGroup",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Volunteer Enrollment Code: $volunteerEnrollmentCode",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Divider(
                                  color: Theme.of(context).accentColor,
                                  thickness: 2.0,
                                ),
                                Center(
                                  child: RaisedButton(
                                    hoverColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      AuthenticationService _auth =
                                          new AuthenticationService();
                                      _auth.signOut();
                                    },
                                    color: Theme.of(context).accentColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
