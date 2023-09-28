import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meeting_scheduler/Calendar/Model/calendardataModel.dart';

class CalendarService {
  final auth = FirebaseFirestore.instance;
  updateCalendarData(CalenderData scheduledata) async {
    try {
      await auth.collection('create_schedule').add(scheduledata.toJson());
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<List<CalenderData>> getCalendarData() async {
    try {
      var res = await auth.collection('create_schedule').get();
      final scheduledata =
          res.docs.map((e) => CalenderData.fromSnapshot(e)).toList();
      return scheduledata;
    } on Exception catch (e) {
      rethrow;
    }
  }
}
