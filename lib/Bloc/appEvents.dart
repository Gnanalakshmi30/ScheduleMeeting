import 'package:equatable/equatable.dart';
import 'package:meeting_scheduler/Calendar/Model/calendardataModel.dart';

abstract class CalendarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCalendar extends CalendarEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCalendarState extends CalendarEvent {
  final CalenderData scheduleDataModel;

  UpdateCalendarState(this.scheduleDataModel);
}
