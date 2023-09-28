import 'package:equatable/equatable.dart';
import 'package:meeting_scheduler/Calendar/Model/calendardataModel.dart';

abstract class CalendarState extends Equatable {}

class InitialState extends CalendarState {
  @override
  List<Object?> get props => [];
}

class CalendarAdding extends CalendarState {
  @override
  List<Object?> get props => [];
}

class CalendarAdded extends CalendarState {
  final List<CalenderData> list;
  CalendarAdded(this.list);
  @override
  List<Object?> get props => [];
}

class CalendarError extends CalendarState {
  final String error;

  CalendarError(this.error);
  @override
  List<Object?> get props => [error];
}
