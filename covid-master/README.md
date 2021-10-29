# anZen - The Contact Tracing Application

<table>
  <tr>
    <td colspan=4 align=center><img src="/covid-master/Project_Media/mockup2.gif">
  </tr>
<tr>
<td><img src="/covid-master/Project_Media/login.gif">
</td>
  <td><img src="/covid-master/Project_Media/Main_Screen.gif">
</td>  
<td><img src="/covid-master/Project_Media/Contact-Tracing.gif">
</td>
  <td><img src="/covid-master/Project_Media/analytics.gif">
</td>
    </tr>  
<table>


## Overview:

This app _“anZen”_ aims to overcome the current limitations of the popular contact tracing app while maintaining the privacy of the users by implementing the following features:

* Real-time contact tracing & distance alerts, even if other people do not have the app installed.
* Information is shared anonymously with nearby devices even without internet.
* Alerting users via push notifications if they are present in the vicinity with multiple medium to high-risk people.

* Live-updates with visual representations of cumulative cases in India as well as in a particular state. 

* Reporting oneself as Covid +ve.

* The app also contains various guidelines & articles about:

* Maintaining social-distancing protocols.

* Symptoms observed by Covid +ve patients.

* Proper sanitization measures to be taken by an individual at home, work & in public places.
  
## Development Details:
  * Developed using Flutter for Android, iOS & Web.
  * Currently compiled and tested on Android 9.0.
  * Backend services based on Google Firebase (Free tier).
  * Covid Analytics data sourced from free open-source API (https://www.covid19india.org)
  * Uses Bluetooth Low Energy to search for nearby devices.
  * User's anonymous information is embedded in the UID  (Unique Identification Number) of the bluetooth device
  * Distance from others is calculated based on the RSSI (Relative Signal Strength Index)

