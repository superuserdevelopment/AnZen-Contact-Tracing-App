import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nss_digital_diary/models/Event.dart';
import 'package:nss_digital_diary/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection('Users');
  // final CollectionReference coursesCollection =
  //     Firestore.instance.collection('Courses');
  //final CollectionReference noteItemsCollection = Firestore.instance.collection('NoteItems');

  Future updateUserData(
    String name,
    String email,
    String uuid,
  ) async {
    return await usersCollection.document(uid).setData({
      'name': name,
      'email': email,
      'lowRisk': true,
      'medRisk': false,
      'highRisk': false,
      'positive': false,
      'contacts': [],
      'uuid': uuid,
    });
  }

  Future updateUserDataAux(User user) async {
    return await usersCollection.document(uid).setData({
      'name': user.name,
      'email': user.email,
      'collegeName': user.collegeName,
      'course': user.course,
      'birthdate': user.birthdate.toString(),
      'bloodGroup': user.bloodGroup,
      'address': user.address,
      'volunteerEnrollmentCode': user.volunteerEnrollmentCode,
    });
  }

  Future updateEvent(Event event) async {
    return await usersCollection
        .document(uid)
        .collection("Events")
        .document()
        .setData({
      'title': event.title,
      'description': event.description,
      'natureOfWork': event.natureOfWork,
      'date': event.dateTime.toString(),
      'hours': event.hours.toString(),
      'supervisorId': event.supervisorId,
      'verified': event.isVerified(),
    });
  }

  // Future<List<Course>> retrieveCourse() async {
  //   QuerySnapshot coursesQuery = await coursesCollection.getDocuments();
  //   List<Course> courses = new List<Course>();
  //   coursesQuery.documents.forEach((document) {
  //     courses.add(Course(
  //       uid: document.documentID,
  //       name: document['title'],
  //     ));
  //   });
  //   for (int i = 0; i < courses.length; i++) {
  //     courses[i].display();
  //   }
  //   return courses;
  // }
  // Future fetchUserDetails(String userUid) async {
  //   try {
  //     return StreamBuilder(
  //         stream: Firestore.instance
  //             .collection('Users')
  //             .document(userUid)
  //             .snapshots(),
  //         builder: (context, snapshot) {
  //           if (snapshot == null) {
  //             return null;
  //           }
  //           if (!snapshot.hasData) {
  //             return Text(
  //               'Loading, Please Wait',
  //               style: TextStyle(color: Colors.white),
  //             );
  //           }
  //           String name =
  //               snapshot.data['name'] != null ? snapshot.data['name'] : "null";
  //           String email = snapshot.data['email'] != null
  //               ? snapshot.data['email']
  //               : "null";
  //           String college = snapshot.data['collegeName'] != null
  //               ? snapshot.data['collegeName']
  //               : "null";
  //           String course = snapshot.data['course'] != null
  //               ? snapshot.data['course']
  //               : "null";
  //           String bloodGroup = snapshot.data['bloodGroup'] != null
  //               ? snapshot.data['bloodGroup']
  //               : "null";
  //           String birthdate = snapshot.data['birthdate'] != null
  //               ? snapshot.data['birthdate']
  //               : "null";
  //           String volunteerEnrollmentCode =
  //               snapshot.data['volunteerEnrollmentCode'] != null
  //                   ? snapshot.data['birthdate']
  //                   : "null";
  //           String address = snapshot.data['address'] != null
  //               ? snapshot.data['address']
  //               : "null";
  //           User user = new User(
  //               uid: userUid,
  //               name: name,
  //               email: email,
  //               collegeName: college,
  //               course: course,
  //               birthdate: DateTime.parse(birthdate),
  //               volunteerEnrollmentCode: volunteerEnrollmentCode,
  //               bloodGroup: bloodGroup,
  //               address: address);
  //           return user;
  //         });
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  Future updateWishlist(String userUid, String courseUid) async {
    try {
      await usersCollection.document(userUid).updateData({
        'wishlistedCourses': FieldValue.arrayUnion([courseUid]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future removeWishlist(String userUid, String courseUid) async {
    try {
      await usersCollection.document(userUid).updateData({
        'wishlistedCourses': FieldValue.arrayRemove([courseUid]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future updateCart(String userUid, String courseUid) async {
    try {
      await usersCollection.document(userUid).updateData({
        'cart': FieldValue.arrayUnion([courseUid]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future removeCart(String userUid, String courseUid) async {
    try {
      await usersCollection.document(userUid).updateData({
        'cart': FieldValue.arrayRemove([courseUid]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future emptyCart(String userUid) async {
    try {
      await usersCollection.document(userUid).updateData({
        'cart': [],
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future enrollCourse(String userUid, String courseUid) async {
    try {
      await usersCollection.document(userUid).updateData({
        'enrolledCourses': FieldValue.arrayUnion([courseUid])
      });
      dynamic progress =
          await usersCollection.document(userUid).get().then((value) {
        print(value.data['progress']);
        return value.data['progress'];
      });
      if (progress.isNotEmpty) {
        progress[courseUid] = 0;
      } else {
        progress = new Map();
        progress[courseUid] = 0;
      }
      print(progress);
      await usersCollection.document(userUid).updateData({
        'progress': progress,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
