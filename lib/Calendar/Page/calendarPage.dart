import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_scheduler/Bloc/appBloc.dart';
import 'package:meeting_scheduler/Bloc/appEvents.dart';
import 'package:meeting_scheduler/Bloc/appState.dart';
import 'package:meeting_scheduler/Calendar/Model/calendardataModel.dart';
import 'package:meeting_scheduler/Calendar/Page/createSchedule.dart';
import 'package:meeting_scheduler/Calendar/Service/calendarService.dart';
import 'package:meeting_scheduler/Util/commonUi.dart';
import 'package:meeting_scheduler/Util/palette.dart';
import 'package:meeting_scheduler/Util/sizing.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  CalendarService service = CalendarService();
  List<CalenderData> loginDetail = [];

  final CalendarController calenderController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RepositoryProvider(
          create: (context) => CalendarService(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return const CreateSchedule();
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Sizing.width(3, 2),
                          vertical: Sizing.height(7, 8)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizing.width(4, 5),
                          vertical: Sizing.height(5, 6)),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        'ADD',
                        style: TextStyle(color: whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: BlocProvider<CalendarBloc>(
                  create: (context) => CalendarBloc(
                      serviceData:
                          RepositoryProvider.of<CalendarService>(context))
                    ..add(LoadCalendar()),
                  child: BlocListener<CalendarBloc, CalendarState>(
                    listener: (context, state) {},
                    child: BlocBuilder<CalendarBloc, CalendarState>(
                        builder: (context, state) {
                      if (state is CalendarAdded) {
                        return SfCalendar(
                          view: CalendarView.month,
                          allowedViews: const [
                            CalendarView.day,
                            CalendarView.week,
                            CalendarView.month,
                          ],
                          controller: calenderController,
                          initialDisplayDate: DateTime.now(),
                          showDatePickerButton: true,
                          todayHighlightColor: redColor,
                          showNavigationArrow: true,
                          allowDragAndDrop: true,
                          allowAppointmentResize: true,
                          monthViewSettings: const MonthViewSettings(
                              appointmentDisplayMode:
                                  MonthAppointmentDisplayMode.appointment,
                              showAgenda: true),
                          dataSource: MeetingData(getAppointments(state.list)),
                          onTap: calendarTapped,
                        );
                      }
                      return Container();
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      String startDate =
          CommonUi.modifiedDateFormat.format(appointmentDetails.startTime);
      String endDate =
          CommonUi.modifiedDateFormat.format(appointmentDetails.endTime);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Name : ${appointmentDetails.subject}'),
              content: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Notes : ${appointmentDetails.notes.toString()}",
                      style: TextStyle(fontSize: Sizing.height(9, 10)),
                    ),
                    SizedBox(
                      height: Sizing.height(3, 4),
                    ),
                    Text('Start time : $startDate',
                        style: TextStyle(fontSize: Sizing.height(9, 10))),
                    SizedBox(
                      height: Sizing.height(3, 4),
                    ),
                    Text('End time : $endDate',
                        style: TextStyle(fontSize: Sizing.height(9, 10))),
                    SizedBox(
                      height: Sizing.height(3, 4),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}

List<Appointment> getAppointments(List<CalenderData> calenderState) {
  List<Appointment> meetings = [];

  for (var element in calenderState) {
    DateTime sDate = DateTime.parse(element.date ?? '');
    String hour = (element.time ?? '').split(':').first;
    String min = (element.time ?? '').split(':').last;
    DateTime startTime = DateTime(
        sDate.year, sDate.month, sDate.day, int.parse(hour), int.parse(min), 0);
    DateTime now = DateTime.now();
    String currentDate = CommonUi.dateAloneFormat.format(now);
    String compareDate = CommonUi.dateAloneFormat.format(sDate);
    Color boxColor;
    if (DateTime.parse(compareDate).isAfter(DateTime.parse(currentDate))) {
      boxColor = yellowColor;
    } else if (DateTime.parse(compareDate)
        .isBefore(DateTime.parse(currentDate))) {
      boxColor = redColor;
    } else if (DateTime.parse(compareDate) == (DateTime.parse(currentDate))) {
      boxColor = primaryColor;
    } else {
      boxColor = secondaryColor;
    }

    meetings.add(Appointment(
        startTime: startTime,
        endTime: startTime.add(const Duration(hours: 2)),
        subject: element.name ?? '',
        notes: element.notes,
        color: boxColor));
  }

  return meetings;
}

class MeetingData extends CalendarDataSource {
  MeetingData(List<Appointment> source) {
    appointments = source;
  }
}
