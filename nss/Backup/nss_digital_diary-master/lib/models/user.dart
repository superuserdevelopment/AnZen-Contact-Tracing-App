class User {
  String uid;
  String collegeName;
  String course;
  String name;
  String email;
  String address;
  String bloodGroup;
  String volunteerEnrollmentCode;
  DateTime birthdate;
  void display() {
    print(
        'UID: $uid\nname: $name\nVolunteer Enrollment Code: $volunteerEnrollmentCode\nemail: $email\nCollege: $collegeName\nCourse: $course\nAddress: $address\nBlood Group: $bloodGroup\nBirthdate: $birthdate.toString');
  }

  User(
      {this.uid,
      this.name,
      this.email,
      this.collegeName,
      this.course,
      this.birthdate,
      this.address,
      this.bloodGroup,
      this.volunteerEnrollmentCode}) {}
}
