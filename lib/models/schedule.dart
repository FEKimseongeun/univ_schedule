
// schedule양식을 미리 짜두었는데 이부분도 수정해야할 부분이 많네요

enum Category { EXAM, ACTIVITY, REGISTER }
enum UniversityList { seoul, yonsei, korea, sogang, sungkyunkwan, hanyang, chungang}
enum Importance { delete, remain, subscribe}

class Schedule {
  final String name;
  final DateTime datetime;
  final UniversityList universityList;
  final bool alarmSwitch;
  final Category category;
  final Importance importance;


  Schedule({required this.name, required this.datetime, required this.universityList, required this.alarmSwitch, required this.category, required this.importance});
}