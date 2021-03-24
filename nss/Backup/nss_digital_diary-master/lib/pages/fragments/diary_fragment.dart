import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nss_digital_diary/models/Event.dart';
import 'package:nss_digital_diary/models/user.dart';
import 'package:nss_digital_diary/widget_assets/ui_elements.dart';
import 'package:provider/provider.dart';

class DiaryFragment extends StatefulWidget {
  @override
  _DiaryFragmentState createState() => _DiaryFragmentState();
}

class _DiaryFragmentState extends State<DiaryFragment> {
  Event event;
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    event = Event(
        title: "Beach Cleaning Activity at Dadar Chowpatty",
        natureOfWork: "Social Service",
        dateTime: DateTime.now(),
        description:
            "Beach Cleaning was done at Dadar Chowpatty. Lorem epsum dorem jou kaou oamig. Lorem epsum dorem jou kaou oamig. Lorem epsum dorem jou kaou oamig. Lorem epsum dorem jou kaou oamig. Lorem epsum dorem jou kaou oamig. Lorem epsum dorem jou kaou oamig. Lorem epsum dorem jou kaou oamig.",
        hours: 3,
        supervisorId: "xasiaoprw5f6dv5");
    List<Event> events = new List<Event>();
    events.add(event);
    events.add(event);
    events.add(event);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              Text(
                'My Diary',
                style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Neue_Montreal',
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('Users')
                      .document(user.uid)
                      .collection("Events")
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<Event> events = new List<Event>();
                    if (!snapshot.hasData) {
                      return Text(
                        'Loading, Please Wait',
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    snapshot.data.documents.forEach((document) {
                      if (document['title'] != null &&
                          document['natureOfWork'] != null &&
                          document['hours'] != null &&
                          document['description'] != null &&
                          document['supervisorId'] != null &&
                          document['date'] != null &&
                          document['verified'] != null) {
                        Event event = new Event(
                          title: document['title'],
                          natureOfWork: document['natureOfWork'],
                          hours: int.parse(document['hours']),
                          description: document['description'],
                          dateTime: DateTime.parse(document['date']),
                          supervisorId: document['supervisorId'],
                        );

                        if (document['verified'].toString() == "true") {
                          event.verifyEvent();
                          print('Verifying');
                        }
                        print("Verified?" + event.isVerified().toString());
                        events.add(event);
                      }
                    });
                    return ActivityCardList(
                      events: events,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
