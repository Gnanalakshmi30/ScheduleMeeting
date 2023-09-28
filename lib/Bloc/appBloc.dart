import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_scheduler/Bloc/appEvents.dart';
import 'package:meeting_scheduler/Bloc/appState.dart';
import 'package:meeting_scheduler/Calendar/Model/calendardataModel.dart';
import 'package:meeting_scheduler/Calendar/Service/calendarService.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarService serviceData;
  late List<CalenderData> schedulelist;

  CalendarBloc({required this.serviceData}) : super(InitialState()) {
    List<CalenderData> schedulelist = [];

    on<LoadCalendar>((event, emit) async {
      emit(CalendarAdding());
      try {
        schedulelist = await serviceData.getCalendarData();
        emit(CalendarAdded(schedulelist));
      } catch (e) {
        emit(CalendarError(e.toString()));
      }
    });

    on<UpdateCalendarState>((event, emit) async {
      emit(CalendarAdding());
      try {
        await Future.delayed(const Duration(seconds: 3), () async {
          schedulelist =
              await serviceData.updateCalendarData(event.scheduleDataModel);
          emit(CalendarAdded(schedulelist));
        });
      } catch (e) {
        emit(CalendarError(e.toString()));
      }
    });
  }
}
