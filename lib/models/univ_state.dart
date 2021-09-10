import 'package:flutter/material.dart';
import 'package:univ_schedule/models/universities_list.dart';

class UniversityState extends ChangeNotifier {
  UniversityList universitiesList = UniversityList();

  String currentUnivEnName = "yonsei";            // 나중에 본인 계정에 저장된 학교를 불러올 예정
  String currentUnivKoName = "연세대학교";
  String currentHexCode = "0xff003976";
  Color currentColor = Color(0xff003976);

  @override
  void dispose() {
    currentUnivEnName = "";
    currentColor = Colors.black;
    notifyListeners();
  }

  void changeUniversity(String selectedUniv) {
    currentUnivEnName = selectedUniv;
    notifyListeners();
  }

  void chageColor(Color color) {
    currentColor = color;
    notifyListeners();
  }

  void getCurrentUnivKoName(String ko_name) {
    currentUnivKoName = ko_name;
    notifyListeners();
  }

  void getCurrentUnivHexCode(String hex_code) {
    currentHexCode = hex_code;
    notifyListeners();
  }
}
