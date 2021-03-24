class Event {
  String title;
  String natureOfWork;
  String description;
  String supervisorId;
  DateTime dateTime;
  int hours;
  bool _verified;

  Event(
      {this.title,
      this.dateTime,
      this.natureOfWork,
      this.description,
      this.hours,
      this.supervisorId}) {
    _verified = false;
  }

  void verifyEvent() {
    _verified = true;
  }

  bool isVerified() {
    return _verified;
  }
}
