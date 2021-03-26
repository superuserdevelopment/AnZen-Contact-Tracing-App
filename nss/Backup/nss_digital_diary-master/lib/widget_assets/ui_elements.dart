import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nss_digital_diary/models/Event.dart';
import 'package:nss_digital_diary/models/user.dart';
import 'package:nss_digital_diary/services/database.dart';
import 'package:nss_digital_diary/widget_assets/message_box.dart';
import 'package:provider/provider.dart';

class ActivityCard extends StatefulWidget {
  final Event event;
  bool showSideMenu = true;
  ActivityCard({this.event, this.showSideMenu});
  @override
  _ActivityCardState createState() =>
      _ActivityCardState(event: event, showSideMenu: showSideMenu);
}

class _ActivityCardState extends State<ActivityCard> {
  final DatabaseService _databaseService = new DatabaseService();
  bool showSideMenu = true;
  Event event;
  _ActivityCardState({this.event, this.showSideMenu});
  IconData bookmark = Icons.bookmark_outline;
  IconData add = Icons.shopping_cart_outlined;
  int progress;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            //color: Theme.of(context).primaryColor,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(event.title,
                                  //overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              Text(event.natureOfWork,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Card(
                          color: Theme.of(context).accentColor,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text('${event.hours.toString()}hrs',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                        event.dateTime.day.toString() +
                            " - " +
                            event.dateTime.month.toString() +
                            " - " +
                            event.dateTime.year.toString(),
                        style: TextStyle(fontSize: 18.0)),
                    Divider(
                      thickness: 2,
                    ),
                    Text(event.description, style: TextStyle(fontSize: 12.0)),
                    Text("Supervisor ID: ${event.supervisorId}",
                        style: TextStyle(fontSize: 12.0)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          color: Theme.of(context).accentColor,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      event.isVerified()
                                          ? 'Verified'
                                          : 'Verification Pending',
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    event.isVerified()
                                        ? Icons.check_box_rounded
                                        : Icons.check_box_outline_blank_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)))),
                            onPressed: () async {
                              DatabaseService databaseService =
                                  new DatabaseService(uid: user.uid);
                              await databaseService.deleteEvent(event.id);
                              showAlertDialog(
                                  "Deleted",
                                  "Activity successfully deleted, visit this page again to see the changes",
                                  context);
                            },
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  //Icon(Icons.qr_code_rounded),
                                  // SizedBox(
                                  //   height: 5.0,
                                  // ),
                                  Text('Delete Event'),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ]),
            )));
  }
}

class ActivityCardList extends StatefulWidget {
  final List<Event> events;
  bool showSideMenu = true;
  ActivityCardList({this.events, this.showSideMenu});
  @override
  _ActivityCardListState createState() =>
      _ActivityCardListState(events: events, showSideMenu: showSideMenu);
}

class _ActivityCardListState extends State<ActivityCardList> {
  List<Event> events;
  bool showSideMenu = true;
  _ActivityCardListState({this.events, this.showSideMenu});
  @override
  Widget build(BuildContext context) {
    if (showSideMenu == null) {
      showSideMenu = true;
    }
    return Container(
      child: new ListView.builder(
          itemCount: events.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext ctxt, int index) => ActivityCard(
                event: events[index],
                showSideMenu: showSideMenu,
              )),
    );
  }
}
