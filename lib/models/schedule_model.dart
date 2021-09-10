import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:univ_schedule/constants/firestore_keys.dart';

class ScheduleModel {
  final String scheduleKey;
  final String scheduleName;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String universityName;
  final String category;
  final bool alarm;
  final String importance;
  final DocumentReference reference;          // firebase에디에 저장해 주었는지를 알려줍니다.

  ScheduleModel.fromMap(Map<String, dynamic>? map, this.scheduleKey, {required this.reference})           // json으로 불러올때 map으로 불러와서 우리의 양식으로 맞춰서 다시 저장해줍니다.
  : scheduleName = map?[KEY_SCHEDULENAME],
  startDateTime = map?[KEY_SCHEDULESTARTDATE],
  endDateTime = map?[KEY_SCHEDULEENDDATE],
  universityName = map?[KEY_SCHEDULEUNIVERSITYNAME],
  category = map?[KEY_SCHEDULECATEGORY],
  alarm = map?[KEY_SCHEDULEALARM],
  importance = map?[KEY_SCHEDULEIMPORTANCE];

  ScheduleModel.fromSnapshot(DocumentSnapshot snapshot)
  :this.fromMap(snapshot.data(), snapshot.id, reference: snapshot.reference);

  static Map<String, dynamic>? getMapForSchedules({required String scheduleName,required DateTime startDate, required DateTime endDate, required String universityName, required String category,required bool alarm, required String importance}) {
    Map<String, dynamic> map = Map();                                   // fromMap과 반대
    map[KEY_SCHEDULENAME] = "";
    map[KEY_SCHEDULESTARTDATE] = DateTime(2050,01,01);
    map[KEY_SCHEDULEENDDATE] = DateTime(2050,01,01);
    map[KEY_SCHEDULEUNIVERSITYNAME] = '';
    map[KEY_SCHEDULECATEGORY] = '';
    map[KEY_SCHEDULEALARM] = false;
    map[KEY_SCHEDULEIMPORTANCE] = '';

  }
}