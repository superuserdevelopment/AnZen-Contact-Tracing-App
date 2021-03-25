import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nss_digital_diary/models/Event.dart';
import 'package:nss_digital_diary/models/user.dart';
import 'package:nss_digital_diary/pages/fragments/reports_fragment.dart';
import 'package:nss_digital_diary/widget_assets/message_box.dart';
import 'package:nss_digital_diary/widget_assets/ui_elements.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  User user;
  Event event;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  void fetchActivity(String code) async {
    await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .collection('Events')
        .snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((document) {
        //print(document.documentID.toString());
        if (document.documentID.toString() == code) {
          if (document['title'] != null &&
              document['natureOfWork'] != null &&
              document['hours'] != null &&
              document['description'] != null &&
              document['supervisorId'] != null &&
              document['date'] != null &&
              document['verified'] != null) {
            setState(() {
              event = new Event(
                title: document['title'],
                natureOfWork: document['natureOfWork'],
                hours: int.parse(document['hours']),
                description: document['description'],
                dateTime: DateTime.parse(document['date']),
                supervisorId: document['supervisorId'],
              );
              if (document['verified'].toString() == "true") {
                event.verifyEvent();
              }
            });
            //print(event.title)

          }
          return null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    if (result != null && result.code != null) {
      // try {
      //   controller.stopCamera();
      // } catch (e) {
      //   print(e);
      // }
      fetchActivity(result.code.toString());
      //Navigator.popAndPushNamed(context, '\reports');
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "QR Code Successfully Scanned",
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                Center(
                  child: Text(
                    "Please Wait while we fetch the Activity",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Center(
                    child: event != null
                        ? ActivityCard(
                            event: event,
                          )
                        : Text("Failed to find Activity, please retry")),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Text(
                        'QR Code Successfully scanned! Data: ${result.code}',
                        style: TextStyle(fontSize: 18.0),
                      )
                    else
                      Text('Ask your supervisor for an Activity code',
                          style: TextStyle(fontSize: 18.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return snapshot.data == false
                                      ? Icon(Icons.flash_off)
                                      : Icon(Icons.flash_on);
                                },
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.flipCamera();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return describeEnum(snapshot.data) == 'back'
                                        ? Icon(Icons.camera_front_rounded)
                                        : Icon(Icons.camera_rear_rounded);
                                    // return Text(
                                    //     'Camera facing ${describeEnum(snapshot.data)}');
                                  } else {
                                    return Text('loading');
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.pauseCamera();
                            },
                            child:
                                Text('pause', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.resumeCamera();
                            },
                            child:
                                Text('resume', style: TextStyle(fontSize: 20)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (result == null) {
        setState(() {
          result = scanData;
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
