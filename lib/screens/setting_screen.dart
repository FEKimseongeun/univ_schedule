import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_schedule/models/firebase_auth_state.dart';
import 'package:univ_schedule/models/univ_state.dart';
import 'package:univ_schedule/models/universities_list.dart';
import 'package:univ_schedule/models/university.dart';
import 'package:univ_schedule/screens/feedback_screen.dart';
import 'package:univ_schedule/screens/introduce_screen.dart';
import 'package:univ_schedule/widgets/page_title.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _currentIndex = 0;
  bool _checked = false;
  UniversityList universities = UniversityList();

  List _univEnNameList = [];
  List _univKoNameList = [];
  List _univHexCodeList = [];
  var _selectedValue = 'yonsei';

  @override
  void initState() {
    for (int i = 0; i < universities.univList.length; i++) {
      _univEnNameList.add(universities.univList[i].univ_en_name);
      _univKoNameList.add(universities.univList[i].univ_ko_name);
      _univHexCodeList.add(universities.univList[i].hex_code);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var univState = Provider.of<UniversityState>(context, listen: true);

    _selectedValue = univState.currentUnivEnName;

    return ListView(
      children: [
        PageTitle(
          univState: univState,
          title: 'Settings',
        ),
        Container(height: 3, color: univState.currentColor),
        _heightBox(1),
        _settingList('학교 선택', univState.currentColor),
        _heightBox(3),
        _dropButton(univState),
        _divider,
        _heightBox(30),
        _settingList('개인 설정', univState.currentColor),
        _checkableSettingList('학교', univState.currentColor),
        _divider,
        _gotoAnotherPage('Schedule 추가 및 오류개선 방법', univState.currentColor,
            FeedbackScreen()),
        _divider,
        _logoutPage('log out', univState.currentColor, FeedbackScreen()),
        _divider,
        _heightBox(30),
        _settingList('우리 앱?', univState.currentColor),
        _gotoAnotherPage('앱 소개', univState.currentColor, IntroScreen()),
        _divider,
        _textBox('Version 1.0'),
        _divider,
      ],
    );
  }

  Container _textBox(String title) {
    return Container(
          color: Colors.white,
          child: ListTile(
            onTap: null,
            title: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black26),
            ),
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            minVerticalPadding: 0,
          ),
        );
  }

  Container _heightBox(double height) {
    return Container(
      height: height,
      color: Colors.white,
    );
  }

  Container _dropButton(UniversityState univState) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          isExpanded: true,
          value: _selectedValue,
          items: _univEnNameList.map((value) {
            return DropdownMenuItem(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Image.asset(
                    'images/$value.png',
                    fit: BoxFit.contain,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              value: value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentIndex = _univEnNameList.indexOf(value);
              _selectedValue = value.toString();
              univState.changeUniversity(value.toString());
              univState.chageColor(
                  Color(int.parse(_univHexCodeList[_currentIndex])));
              univState.currentHexCode = _univHexCodeList[_currentIndex];
              univState.currentUnivKoName = _univKoNameList[_currentIndex];
            });
          },
        ),
      ),
    );
  }

  Divider get _divider => Divider(
        thickness: 1,
        height: 0,
        color: Color(0xff003976),
      );

  Container _checkableSettingList(String title, Color color) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: color),
        ),
        trailing: CupertinoSwitch(
          value: _checked,
          onChanged: (onValue) {
            setState(() {
              _checked = onValue;
            });
          },
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  Container _settingList(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        color: color,
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        minVerticalPadding: 0,
      ),
    );
  }

  Container _gotoAnotherPage(String title, Color color, Widget widget) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
        },
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: color),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        minVerticalPadding: 0,
      ),
    );
  }

  Container _logoutPage(String title, Color color, Widget widget) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          Provider.of<FirebaseAuthState>(context, listen: false).signOut();
        },
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: color),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        minVerticalPadding: 0,
      ),
    );
  }

  ListTile _setting(String title, Color color) {
    return ListTile(
      minVerticalPadding: 0,
      title: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: color),
        ),
      ),
      dense: false,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
