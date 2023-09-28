import 'package:cloud_firestore/cloud_firestore.dart';

class CalenderData {
  final String? date;
  final String? name;
  final String? notes;
  final String? time;

  const CalenderData({this.date, this.name, this.notes, this.time});

  toJson() {
    return {"Date": date, "Name": name, "Notes": notes, "Time": time};
  }

  factory CalenderData.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return CalenderData(
        date: data!["Date"],
        name: data["Name"],
        notes: data["Notes"],
        time: data["Time"]);
  }
}
