import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nss_digital_diary/models/Event.dart';
import 'package:nss_digital_diary/models/user.dart';
import 'package:nss_digital_diary/services/auth.dart';
import 'package:nss_digital_diary/services/database.dart';
import 'package:nss_digital_diary/widget_assets/message_box.dart';
import 'package:provider/provider.dart';

import '../loading.dart';

class NewEventFragment extends StatefulWidget {
  @override
  _NewEventFragmentState createState() => _NewEventFragmentState();
}

class _NewEventFragmentState extends State<NewEventFragment> {
  final AuthenticationService _auth = AuthenticationService();
  final _NewEventformKey = GlobalKey<FormState>();
  DateTime _date;
  String _title = '';
  String _natureOfWork = '';
  String _description = '';
  String _supervisorId = '';
  int _hours = 0;
  bool loading = false;
  _PatternVibrate() {
    HapticFeedback.mediumImpact();
  }

  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return loading
        ? LoadingScreen()
        : SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: ListView(
                  children: [
                    Text(
                      'New Activity',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Neue_Montreal',
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _NewEventformKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: Card(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 30.0),
                              child: Column(
                                children: [
                                  //Name
                                  Card(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 10),
                                      child: TextFormField(
                                        //key: _NewEventformKey,
                                        validator: (val) => val.isEmpty
                                            ? 'Enter the title'
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: 'Title of Activity',
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            errorStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600])),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white))),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            _title = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  //Nature of Event
                                  Card(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 10),
                                      child: TextFormField(
                                        //key: _NewEventformKey,
                                        validator: (val) => val.isEmpty
                                            ? 'Enter the Nature of Work'
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: 'Nature of Work',
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            errorStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600])),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white))),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            _natureOfWork = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  //Description
                                  Card(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 10),
                                      child: TextFormField(
                                        //key: _NewEventformKey,
                                        maxLines: 5,
                                        maxLength: 1000,
                                        validator: (val) => val.isEmpty
                                            ? 'Enter the description'
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: 'Description',
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            errorStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600])),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white))),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            _description = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  //Date of the activity
                                  Card(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              _date != null
                                                  ? _date.day.toString() +
                                                      " / " +
                                                      _date.month.toString() +
                                                      " / " +
                                                      _date.year.toString()
                                                  : "Date of the Activity",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                              )),
                                          RaisedButton(
                                            elevation: 10.0,
                                            onPressed: () {
                                              showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime.now())
                                                  .then((date) {
                                                setState(() {
                                                  _date = date;
                                                });
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Theme.of(context)
                                                        .accentColor)),
                                            color: Colors.white,
                                            child: Icon(Icons.add),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  //Hours
                                  Card(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 10),
                                      child: TextFormField(
                                        //key: _NewEventformKey,
                                        keyboardType: TextInputType.number,
                                        validator: (val) => val.isEmpty
                                            ? 'Enter valid hours'
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: 'Hours',
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            errorStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600])),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white))),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            _hours = int.parse(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  //Supervisor Information
                                  Card(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 10),
                                      child: TextFormField(
                                        //key: _NewEventformKey,
                                        validator: (val) => val.isEmpty
                                            ? 'Enter valid supervisorId'
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: 'Supervisor ID',
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            errorStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600])),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white))),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            _supervisorId = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  RaisedButton(
                                    elevation: 10.0,
                                    onPressed: () async {
                                      if (_NewEventformKey.currentState
                                          .validate()) {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          loading = true;
                                        });
                                        Event event = new Event(
                                            title: _title,
                                            description: _description,
                                            natureOfWork: _natureOfWork,
                                            dateTime: _date,
                                            supervisorId: _supervisorId,
                                            hours: _hours);
                                        print(event.toString());
                                        try {
                                          await DatabaseService(uid: user.uid)
                                              .updateEvent(event);
                                          showAlertDialog(
                                              "Successful",
                                              "Activity Added Successfully",
                                              context);
                                          setState(() {
                                            loading = false;
                                          });
                                        } catch (e) {
                                          showAlertDialog(
                                              "Error", e.toString(), context);
                                          print(e.toString());
                                        }
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    color: Theme.of(context).accentColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Save",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 35.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
