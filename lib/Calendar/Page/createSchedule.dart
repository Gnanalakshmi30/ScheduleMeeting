import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_scheduler/Bloc/appBloc.dart';
import 'package:meeting_scheduler/Bloc/appEvents.dart';
import 'package:meeting_scheduler/Calendar/Model/calendardataModel.dart';
import 'package:meeting_scheduler/Calendar/Service/calendarService.dart';
import 'package:meeting_scheduler/Util/commonUi.dart';
import 'package:meeting_scheduler/Util/page_router.dart';
import 'package:meeting_scheduler/Util/palette.dart';
import 'package:meeting_scheduler/Util/sizing.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key});

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController notes = TextEditingController();
  CalendarService service = CalendarService();
  bool showDateErrorMsg = false;
  bool showErrorMsg = false;
  bool showNotesErrorMsg = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Schedule Activity',
                style: TextStyle(fontSize: Sizing.height(10, 11)),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: greyColor,
                  ))
            ],
          ),
          const Divider()
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          dateField(),
          showDateErrorMsg
              ? SizedBox(
                  height: Sizing.height(6, 7),
                )
              : const SizedBox(),
          showDateErrorMsg
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Due Date is required',
                      style: TextStyle(
                          fontSize: Sizing.height(6, 7), color: redColor),
                    ),
                  ],
                )
              : const SizedBox(),
          SizedBox(
            height: Sizing.height(7, 8),
          ),
          nameField(),
          showErrorMsg
              ? SizedBox(
                  height: Sizing.height(6, 7),
                )
              : const SizedBox(),
          showErrorMsg
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Name is required',
                      style: TextStyle(
                          fontSize: Sizing.height(6, 7), color: redColor),
                    ),
                  ],
                )
              : const SizedBox(),
          SizedBox(
            height: Sizing.height(7, 8),
          ),
          notesField(),
          showNotesErrorMsg
              ? SizedBox(
                  height: Sizing.height(6, 7),
                )
              : const SizedBox(),
          showNotesErrorMsg
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Notes is required',
                      style: TextStyle(
                          fontSize: Sizing.height(6, 7), color: redColor),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
      actions: [
        Column(
          children: [
            const Divider(),
            GestureDetector(
              onTap: () {
                if (name.text == "") {
                  setState(() {
                    showErrorMsg = true;
                  });
                }

                if (notes.text == "") {
                  setState(() {
                    showNotesErrorMsg = true;
                  });
                }

                if (date.text == "") {
                  setState(() {
                    showDateErrorMsg = true;
                  });
                }

                if (name.text != "" && notes.text != "" && date.text != "") {
                  setState(() {
                    showErrorMsg = false;
                    showNotesErrorMsg = false;
                    showDateErrorMsg = false;
                  });

                  createSchedule(context);
                }
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(
                    left: Sizing.width(3, 4),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizing.width(5, 6),
                      vertical: Sizing.height(5, 6)),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: const Text(
                    'SCHEDULE',
                    style: TextStyle(color: whiteColor),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  dateField() {
    return TextFormField(
      onFieldSubmitted: (val) async {
        if (val != '') {}
      },
      controller: date,
      cursorColor: blackColor,
      style: TextStyle(fontSize: Sizing.height(7, 8)),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          labelText: 'Due Date',
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 10)),
      onChanged: (value) async {
        setState(() {
          showDateErrorMsg = false;
        });
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));
        if (pickedDate != null) {
          String formattedDate = CommonUi.dateAloneFormat.format(pickedDate);
          setState(() {
            date.text = formattedDate;
            showDateErrorMsg = false;
          });
        }
      },
    );
  }

  nameField() {
    name.selection = TextSelection.collapsed(offset: name.text.length);
    return TextFormField(
      onFieldSubmitted: (val) async {
        if (val != '') {}
      },
      controller: name,
      cursorColor: blackColor,
      style: TextStyle(fontSize: Sizing.height(7, 8)),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          labelText: 'Name',
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 10)),
      onChanged: (value) async {
        setState(() {
          showErrorMsg = false;
        });
      },
    );
  }

  notesField() {
    notes.selection = TextSelection.collapsed(offset: notes.text.length);
    return TextFormField(
      onFieldSubmitted: (val) async {},
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: notes,
      cursorColor: blackColor,
      style: TextStyle(fontSize: Sizing.height(7, 8)),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          label: const Text(
            'Notes',
          ),
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 10)),
      onChanged: (value) async {
        setState(() {
          showNotesErrorMsg = false;
        });
      },
    );
  }

  void createSchedule(context) async {
    CommonUi().showLoadingDialog(context);
    DateTime now = DateTime.now();
    String startTime = CommonUi.timeAloneFormat.format(now);
    CalenderData calenderData = CalenderData(
        date: date.text, name: name.text, notes: notes.text, time: startTime);
    await service.updateCalendarData(calenderData);
    Navigator.of(context).pushReplacementNamed(
      PageRouter.calenderPage,
    );
  }
}
