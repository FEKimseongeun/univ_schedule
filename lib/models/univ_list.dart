import 'package:flutter/material.dart';
import 'package:univ_schedule/models/university.dart';

// 여기도 나중에 같이 얘기했던 것 처럼 firebase로 뺄 예정

class Universities {

  List<University> _univ = [
    University('yonsei','연 세 대 학 교', '0xff003976',),
    University('korea','고 려 대 학 교', '0xff940034',),
    University('sogang','서 강 대 학 교', '0xffb60006',),
    University('sungkyunkwan','성 균 관 대 학 교', '0xff7ac141',),
    University('hanyang','한 양 대 학 교', '0xff0E4A84',),
    University('chungang','중 앙 대 학 교', '0xff0174b7',),
  ];


  List get univList => _univ;
}