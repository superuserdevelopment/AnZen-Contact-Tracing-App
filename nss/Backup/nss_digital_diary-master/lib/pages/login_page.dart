import 'package:nss_digital_diary/pages/loading.dart';
import 'package:nss_digital_diary/services/auth.dart';
import 'package:nss_digital_diary/services/database.dart';
import 'package:nss_digital_diary/widget_assets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //Credentials
  DateTime _birthdate;
  String _volCode = '';
  String _address = '';
  String _bloodGroup = 'A+';
  String _college = 'VSIT';
  String _email = '';
  String _password = '';
  String _name = '';
  String _course = '';
  bool isRegistering = false;
  bool emailFocus = false;
  bool passFocus = false;
  bool nameFocus = false;

  @override
  Widget build(BuildContext context) {
    _PatternVibrate() {
      HapticFeedback.mediumImpact();
    }

    return loading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                    child: Logo(),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        //color: Theme.of(context).accentColor,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    //Sign in Card
                                    Card(
                                      elevation: isRegistering ? 0.0 : 10.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: isRegistering
                                              ? null
                                              : Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 4.0),
                                        ),
                                        child: Material(
                                          child: InkWell(
                                            onTap: () {
                                              HapticFeedback.mediumImpact();
                                              setState(() {
                                                isRegistering = false;
                                              });
                                            },
                                            child: Text(
                                              'Sign-in',
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: isRegistering ? 10.0 : 0.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: isRegistering
                                              ? Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 4.0)
                                              : null,
                                        ),
                                        child: Material(
                                          child: InkWell(
                                            onTap: () {
                                              HapticFeedback.mediumImpact();
                                              setState(() {
                                                isRegistering = true;
                                              });
                                            },
                                            child: Text(
                                              'Sign-up',
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //name
                                Visibility(
                                  visible: isRegistering,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Card(
                                      elevation: nameFocus ? 10.0 : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      color: Theme.of(context).primaryColor,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 20.0),
                                        child: TextFormField(
                                          onTap: () {
                                            setState(() {
                                              nameFocus = true;
                                              emailFocus = false;
                                              passFocus = false;
                                            });
                                          },
                                          validator: (val) =>
                                              val.isEmpty && isRegistering
                                                  ? 'Enter your Name'
                                                  : null,
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                              hintText: 'Name',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                              errorStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.green)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors
                                                                  .grey[600])),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.white))),
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                          onChanged: (val) {
                                            setState(() {
                                              _name = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //Name of College
                                Visibility(
                                  visible: isRegistering,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 175,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 15, 0, 0),
                                          child: Card(
                                            elevation: nameFocus ? 10.0 : 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  20.0, 10.0, 20.0, 20.0),
                                              child: DropdownButtonFormField(
                                                  value: _college,
                                                  validator: (college) =>
                                                      college.isEmpty &&
                                                              isRegistering
                                                          ? 'Enter your College'
                                                          : null,
                                                  dropdownColor:
                                                      Theme.of(context)
                                                          .accentColor,
                                                  items: [
                                                    DropdownMenuItem(
                                                      child: Text(
                                                        "VSIT",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0),
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                      value: 'VSIT',
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text(
                                                        "SIESGST",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0),
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                      value: 'SIESGST',
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text(
                                                        "Khalsa College",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0),
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                      value: 'Khalsa College',
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _college = value;
                                                    });
                                                  }),
                                            ),
                                            // child: TextFormField(
                                            //   onTap: () {
                                            //     setState(() {
                                            //       nameFocus = true;
                                            //       emailFocus = false;
                                            //       passFocus = false;
                                            //     });
                                            //   },
                                            //   validator: (val) =>
                                            //       val.isEmpty && isRegistering
                                            //           ? 'Enter your  College Name'
                                            //           : null,
                                            //   cursorColor:
                                            //       Theme.of(context).accentColor,
                                            //   decoration: InputDecoration(
                                            //       hintText: 'College',
                                            //       hintStyle: TextStyle(
                                            //           color: Colors.white,
                                            //           fontSize: 18.0),
                                            //       errorStyle: TextStyle(
                                            //           color: Colors.white,
                                            //           fontSize: 12.0),
                                            //       errorBorder: UnderlineInputBorder(
                                            //           borderSide: BorderSide(
                                            //               color: Colors.green)),
                                            //       enabledBorder:
                                            //           UnderlineInputBorder(
                                            //               borderSide: BorderSide(
                                            //                   color:
                                            //                       Colors
                                            //                           .grey[600])),
                                            //       focusedBorder:
                                            //           UnderlineInputBorder(
                                            //               borderSide: BorderSide(
                                            //                   color:
                                            //                       Colors.white))),
                                            //   style: TextStyle(
                                            //     fontSize: 18.0,
                                            //     color: Colors.white,
                                            //   ),
                                            //   onChanged: (val) {
                                            //     setState(() {
                                            //       name = val;
                                            //     });
                                            //   },
                                            // ),
                                          ),
                                        ),
                                      ),
                                      //Course
                                      Expanded(
                                        child: Visibility(
                                          visible: isRegistering,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Card(
                                              elevation: nameFocus ? 10.0 : 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    20.0, 10.0, 20.0, 20.0),
                                                child: TextFormField(
                                                  onTap: () {
                                                    setState(() {
                                                      nameFocus = true;
                                                      emailFocus = false;
                                                      passFocus = false;
                                                    });
                                                  },
                                                  validator: (val) =>
                                                      val.isEmpty &&
                                                              isRegistering
                                                          ? 'Enter your Course'
                                                          : null,
                                                  cursorColor: Theme.of(context)
                                                      .accentColor,
                                                  decoration: InputDecoration(
                                                      hintText: 'Course',
                                                      hintStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.0),
                                                      errorStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0),
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .green)),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      600])),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white))),
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                  ),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _course = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                                ),

                                //Birthdate
                                Visibility(
                                  visible: isRegistering,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Card(
                                      elevation: nameFocus ? 10.0 : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      color: Theme.of(context).primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                _birthdate != null
                                                    ? _birthdate.day
                                                            .toString() +
                                                        " / " +
                                                        _birthdate.month
                                                            .toString() +
                                                        " / " +
                                                        _birthdate.year
                                                            .toString()
                                                    : "Select a birthdate",
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
                                                        firstDate:
                                                            DateTime(1900),
                                                        lastDate:
                                                            DateTime.now())
                                                    .then((date) {
                                                  setState(() {
                                                    _birthdate = date;
                                                  });
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
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
                                  ),
                                ),
                                //Address
                                Visibility(
                                  visible: isRegistering,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Card(
                                      elevation: nameFocus ? 10.0 : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      color: Theme.of(context).primaryColor,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 20.0),
                                        child: TextFormField(
                                          maxLines: 4,
                                          maxLength: 500,
                                          onTap: () {
                                            setState(() {
                                              nameFocus = true;
                                              emailFocus = false;
                                              passFocus = false;
                                            });
                                          },
                                          validator: (val) =>
                                              val.isEmpty && isRegistering
                                                  ? 'Enter your Address'
                                                  : null,
                                          cursorColor:
                                              Theme.of(context).accentColor,
                                          decoration: InputDecoration(
                                              hintText: 'Residential Address',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                              errorStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.green)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors
                                                                  .grey[600])),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.white))),
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                          onChanged: (val) {
                                            setState(() {
                                              _address = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //Blood Group
                                Visibility(
                                  visible: isRegistering,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Card(
                                      elevation: nameFocus ? 10.0 : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      color: Theme.of(context).primaryColor,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 20.0),
                                        child: DropdownButtonFormField(
                                            value: _bloodGroup,
                                            validator: (college) =>
                                                college.isEmpty && isRegistering
                                                    ? 'Enter your Blood Group'
                                                    : null,
                                            dropdownColor:
                                                Theme.of(context).accentColor,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text(
                                                  "A+",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                value: 'A+',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "A-",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                value: 'A-',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "O+",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                value: 'O+',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "O-",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                value: 'O-',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "B+",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                value: 'B+',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "B-",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                value: 'B-',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "AB+",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                value: 'AB+',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "AB-",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                value: 'AB-',
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _bloodGroup = value;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                //Volunteer Enrollment Code
                                Visibility(
                                  visible: isRegistering,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Card(
                                      elevation: nameFocus ? 10.0 : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      color: Theme.of(context).primaryColor,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 20.0),
                                        child: TextFormField(
                                          maxLength: 12,
                                          maxLengthEnforced: true,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          onTap: () {
                                            setState(() {
                                              nameFocus = true;
                                              emailFocus = false;
                                              passFocus = false;
                                            });
                                          },
                                          validator: (val) {
                                            if (val.isEmpty && isRegistering) {
                                              return 'Enter your Volunteer Code';
                                            } else if (val.length != 12 &&
                                                isRegistering) {
                                              return 'Volunteer Code must be 12 Characters long';
                                            }
                                            return null;
                                          },
                                          cursorColor:
                                              Theme.of(context).accentColor,
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Volunteer Enrollment Code',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                              errorStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.green)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors
                                                                  .grey[600])),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.white))),
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                          onChanged: (val) {
                                            setState(() {
                                              _volCode = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //email
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Card(
                                    elevation: emailFocus ? 10.0 : 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    color: Theme.of(context).primaryColor,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 20.0),
                                      child: TextFormField(
                                        onTap: () {
                                          setState(() {
                                            emailFocus = true;
                                            passFocus = false;
                                            nameFocus = false;
                                          });
                                        },
                                        validator: (val) => val.isEmpty
                                            ? 'Enter a valid email address'
                                            : null,
                                        cursorColor:
                                            Theme.of(context).accentColor,
                                        decoration: InputDecoration(
                                            hintText: 'Email Address',
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
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
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            _email = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                //password
                                Card(
                                  elevation: passFocus ? 10.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  color: Theme.of(context).primaryColor,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 20.0),
                                    child: TextFormField(
                                      onTap: () {
                                        setState(() {
                                          emailFocus = false;
                                          passFocus = true;
                                          nameFocus = false;
                                        });
                                      },
                                      validator: (val) => val.length > 5
                                          ? null
                                          : 'Enter a password with 6 or more characters',
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
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
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                      obscureText: true,
                                      onChanged: (val) {
                                        setState(() {
                                          _password = val;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Card(
                                  color: Theme.of(context).accentColor,
                                  elevation: 10.0,
                                  borderOnForeground: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    height: 65.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 2.0),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 0.0,
                                          child: Draggable(
                                            onDragEnd: (vel) async {
                                              if (vel.offset.direction < 1.5) {
                                                print('Swipe Right');
                                                if (isRegistering) {
                                                  HapticFeedback.mediumImpact();
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    // print(name);
                                                    // print(email);
                                                    // print(password);
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    dynamic result = await _auth
                                                        .registerWithEmailFullDetails(
                                                            _email,
                                                            _password,
                                                            _college,
                                                            _name,
                                                            _course,
                                                            _address,
                                                            _bloodGroup,
                                                            _volCode,
                                                            _birthdate);

                                                    if (result.runtimeType ==
                                                        String) {
                                                      showAlertDialog('Oops',
                                                          result, context);
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    } else {
                                                      //result.generateUUID();
                                                      // result.name = _name;
                                                      // result.collegeName =
                                                      //     _college;
                                                      // result.course = _course;
                                                      // result.address = _address;
                                                      // result.birthdate =
                                                      //     _birthdate;
                                                      // result.bloodGroup =
                                                      //     _bloodGroup;
                                                      // result.volunteerEnrollmentCode =
                                                      //     _volCode;
                                                      try {
                                                        await DatabaseService(
                                                                uid: result.uid)
                                                            .updateUserDataAux(
                                                                result);
                                                      } catch (e) {
                                                        print(e.toString());
                                                      }
                                                    }
                                                  }
                                                } else {
                                                  HapticFeedback.mediumImpact();
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    print('Signing you in');
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    dynamic result =
                                                        await _auth.signInEmail(
                                                            _email, _password);
                                                    if (result.runtimeType ==
                                                        String) {
                                                      showAlertDialog('Oops',
                                                          result, context);
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    }
                                                  }
                                                }
                                              }
                                            },
                                            axis: Axis.horizontal,
                                            feedback: Container(
                                              height: 60.0,
                                              width: 60.0,
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 40.0,
                                              ),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey[600],
                                                      offset: Offset(2, 3),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 2.0,
                                                    )
                                                  ]),
                                            ),
                                            childWhenDragging: Container(
                                              height: 60.0,
                                              width: 60.0,
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 40.0,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                            child: Container(
                                              height: 60.0,
                                              width: 60.0,
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 40.0,
                                              ),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey[600],
                                                      offset: Offset(0, 3),
                                                      blurRadius: 5.0,
                                                      spreadRadius: 1.0,
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 60.0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                'Swipe Right to Continue',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Center(child: _signInButton(context))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Column(
                        children: [
                          Text(
                            'Vidyalankar School of Information Technology',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontFamily: 'Neue_Montreal',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          Text(
                            'superuserdev </>',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                //fontFamily: 'Neue_Montreal',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  )
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
              Column(
                children: [
                  Text(
                    'Digital Diary',
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    'National Service Scheme',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _signInButton(BuildContext context) {
  //AuthenticationService _auth = new AuthenticationService();
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {
      //_auth.signInWithGoogle();
      showAlertDialog(
          "Work in Progress", "Google Sign-in Coming soon", context);
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/rasters/logo.png"), height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
