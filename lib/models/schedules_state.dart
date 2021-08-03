import 'package:flutter/cupertino.dart';
import 'package:univ_schedule/models/schedule_list.dart';

class SchedulesState extends ChangeNotifier {
  SchedulesList schedulesList = SchedulesList();

  List currentScheduleList = SchedulesList().scheduleList;

  void getCurrentSchedule() {
    currentScheduleList = schedulesList.scheduleList;
  }
}
