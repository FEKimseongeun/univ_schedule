import 'package:univ_schedule/models/schedule.dart';

// 스케줄 목록인데 Firebase에 저장한 값을 불러와야하지만 일단 실험용으로 코드내에 저장해놨습니다. 나중에 같이 빼요.. ㅎㅎ

class SchedulesList {
  List<Schedule> _ScheduleList = [
    Schedule(
        name: '개강',
        datetime: DateTime(2021, 06, 17, 09, 00, 000).toUtc(),
        universityList: UniversityList.yonsei,
        alarmSwitch: true,
        category: Category.REGISTER,
        importance: Importance.subscribe),
    Schedule(
        name: '중간고사',
        datetime: DateTime(2021, 06, 28, 09, 00, 000).toUtc(),
        universityList: UniversityList.yonsei,
        alarmSwitch: true,
        category: Category.EXAM,
        importance: Importance.subscribe),
    Schedule(
        name: '축제',
        datetime: DateTime(2021, 07, 11, 09, 00, 000).toUtc(),
        universityList: UniversityList.yonsei,
        alarmSwitch: false,
        category: Category.ACTIVITY,
        importance: Importance.subscribe),
    Schedule(
        name: '기말고사',
        datetime: DateTime(2021, 07, 12, 09, 00, 000).toUtc(),
        universityList: UniversityList.yonsei,
        alarmSwitch: true,
        category: Category.EXAM,
        importance: Importance.subscribe),
    Schedule(
        name: '종강',
        datetime: DateTime(2021, 07, 14, 09, 00, 000).toUtc(),
        universityList: UniversityList.yonsei,
        alarmSwitch: true,
        category: Category.REGISTER,
        importance: Importance.subscribe),
    Schedule(
        name: '성적발표',
        datetime: DateTime(2021, 07, 21, 09, 00, 000).toUtc(),
        universityList: UniversityList.yonsei,
        alarmSwitch: false,
        category: Category.ACTIVITY,
        importance: Importance.subscribe),
  ];

  List get scheduleList => _ScheduleList;
}
