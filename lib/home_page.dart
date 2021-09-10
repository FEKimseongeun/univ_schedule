import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_schedule/constants/screen_size.dart';
import 'package:univ_schedule/constants/univ_material_color.dart';
import 'package:univ_schedule/models/univ_state.dart';
import 'package:univ_schedule/screens/calendar_screen.dart';
import 'package:univ_schedule/screens/schedule_list_screen.dart';
import 'package:univ_schedule/screens/setting_screen.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.calendar_today_sharp,), label: "Calendar"),
    BottomNavigationBarItem(icon: Icon(Icons.storage,), label: "Schedule"),
    BottomNavigationBarItem(icon: Icon(Icons.settings,), label: "Setting"),
  ];

  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static List<Widget> _screens = <Widget>[
    CalendarScreen(),
    ScheduleListScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;           // 여기서 각자의 화면의 크기를 가져오고 size 클래스의 size에 넣어서 앱 안에서 쓸 수 있습니다.
    UniversityState univState = Provider.of<UniversityState>(context, listen: false);

    return MaterialApp(
      theme: ThemeData(
          primarySwatch: univ_color[univ_color_string.indexOf(univState.currentUnivEnName)],
      ),
      home: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: Scaffold(
          key: _key,
          body: SafeArea(
            child: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedFontSize: 10,
            items: btmNavItems,
            unselectedItemColor: Colors.black38,
            selectedItemColor: univState.currentColor,
            currentIndex: _selectedIndex,
            onTap: _onBtmItemClick,
          ),
        ),
      ),
    );

  }
    void _onBtmItemClick(int index) {
          setState(() {
            _selectedIndex = index;
          });
    }
}
