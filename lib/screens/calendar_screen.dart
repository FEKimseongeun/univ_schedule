import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:univ_schedule/models/firebase_auth_state.dart';
import 'package:univ_schedule/models/schedule.dart';
import 'package:univ_schedule/models/schedule_list.dart';
import 'package:univ_schedule/models/univ_state.dart';
import 'package:univ_schedule/repo/user_network_repository.dart';
import 'package:univ_schedule/screens/detail_schedule.dart';
import 'package:univ_schedule/widgets/page_title.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List scheduleList = SchedulesList().scheduleList;
  Map<DateTime, List<Schedule>>? selectedSchedules = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime sampleDay = DateTime(2021, 07, 22).toUtc();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedSchedules = {       // 내가 짰는데 이게 뭔말이야?
      scheduleList[0].datetime: [scheduleList[0]],
      scheduleList[1].datetime: [scheduleList[1]],
      scheduleList[2].datetime: [scheduleList[2]],
      scheduleList[3].datetime: [scheduleList[3]],
      scheduleList[4].datetime: [scheduleList[4]],
      scheduleList[5].datetime: [scheduleList[5]],
    };
    print(DateTime(2021, 07, 22, 09, 00, 000).toUtc());
    // initList();
    super.initState();
  }

  // initList() async {
  //   for (int i = 0; i < ScheduleList.length; i++) {
  //     DateTime _dateTime;
  //     _dateTime = ScheduleList[i].datetime;
  //     if (selectedSchedules?[_dateTime] == null) {
  //       selectedSchedules?[ScheduleList[i].datetime] = await [
  //         Schedule(
  //             name: ScheduleList[i].name,
  //             importance: ScheduleList[i].importance,
  //             universityList: ScheduleList[i].universityList,
  //             category: ScheduleList[i].category,
  //             alarmSwitch: ScheduleList[i].alarmSwitch,
  //             datetime: ScheduleList[i].datetime),
  //       ];
  //       print('@@@if@@@ : ${selectedSchedules?[_dateTime]![0].name}');
  //       print(
  //           '@@@if@@@ : ${selectedSchedules?[_dateTime]![0].datetime.toString()}');
  //     } else {
  //       selectedSchedules?[_dateTime]?.add(
  //         Schedule(
  //             name: ScheduleList[i].name,
  //             importance: ScheduleList[i].importance,
  //             universityList: ScheduleList[i].universityList,
  //             category: ScheduleList[i].category,
  //             alarmSwitch: ScheduleList[i].alarmSwitch,
  //             datetime: ScheduleList[i].datetime),
  //       );
  //       print('@@@else@@@ : ${selectedSchedules?[_dateTime]![1].name}');
  //       print(
  //           '@@@else@@@ : ${selectedSchedules?[_dateTime]![1].datetime.toString()}');
  //     }
  //   }
  //   setState(() {});
  // }

  List<Schedule> _getEventsfromDay(DateTime date) {
    return selectedSchedules![date] ?? []; // {selectedEvents[date] : ListEvent}
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var univState = Provider.of<UniversityState>(context, listen: true);

    return Scaffold(
      body: ListView(
        children: [
          PageTitle(
            univState: univState,
            title: 'Schedule Calendar',
          ),
          Container(height: 3, color: univState.currentColor),
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: univState.currentColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: univState.currentColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Schedule schedule) =>
                Column(
                  children: [
                    ListTile(
                    title: TextButton(
              child: Text(
                    schedule.name,
              ),
              onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => DetailSchedule()));
                    print('asdasd');
              },
            )),
                    Divider(thickness: 1,),
                  ],
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: univState.currentColor,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Add Event",
              style: TextStyle(color: univState.currentColor),
            ),
            content: TextFormField(
              cursorColor: univState.currentColor,
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: univState.currentColor),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: univState.currentColor),
                ),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else if (selectedDay.isBefore(DateTime.now())) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        '오늘 날짜보다 이후에 있는 시간만 추가 가능합니다.',
                      ),
                      backgroundColor: univState.currentColor,
                    ));
                  } else {
                    if (selectedSchedules![selectedDay] != null) {
                      selectedSchedules![selectedDay]!.add(
                        Schedule(
                            name: _eventController.text,
                            importance: Importance.subscribe,
                            universityList: UniversityList.yonsei,
                            category: Category.ACTIVITY,
                            alarmSwitch: false,
                            datetime: DateTime.now()),
                      );
                    } else {
                      selectedSchedules![selectedDay] = [
                        Schedule(
                            name: _eventController.text,
                            importance: Importance.subscribe,
                            universityList: UniversityList.yonsei,
                            category: Category.ACTIVITY,
                            alarmSwitch: false,
                            datetime: DateTime.now()),
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
