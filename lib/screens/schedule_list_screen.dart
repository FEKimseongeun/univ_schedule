import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:univ_schedule/constants/screen_size.dart';
import 'package:univ_schedule/models/schedule_list.dart';
import 'package:univ_schedule/models/schedule.dart';
import 'package:univ_schedule/models/schedules_state.dart';
import 'package:univ_schedule/screens/detail_schedule.dart';
import 'package:univ_schedule/models/univ_state.dart';
import 'package:univ_schedule/widgets/page_title.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen>
    with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagePageMargin = 0;
  double _rightImagePageMargin = size!.width;
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    _iconAnimationController = AnimationController(
        vsync: this,
        // vsync TickerProvider   <- 위에 SingleTickerProviderStateMixin
        duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose(); // memory leak을 없앤다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var univState = Provider.of<UniversityState>(context, listen: true);
    List scheduleList = SchedulesList().scheduleList;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd (E)");

    return Scaffold(
      body: Column(
        children: [
          PageTitle(
            univState: univState,
            title: 'Schedule List',
          ),
          Container(height: 3, color: univState.currentColor),

          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  _tapButtons(),
                  SizedBox(height: 3,),
                  Container(
                    height: 2,
                    color: univState.currentColor,
                  )
                ]),
              ),
              _imagePager(),
            ],
          )),

          // for (int i = 0; i < scheduleList.length; i++)
          //   if (daysBetween(DateTime.now(), scheduleList[i].datetime) > 0)
          //     SectionSwitch(
          //       scheduleList[i].name,
          //       // Dday: scheduleList[i].datetime.difference(DateTime.now()).inDays,       // isBefore을 써서 삼항연산자로 나타내주
          //       Dday: daysBetween(DateTime.now(), scheduleList[i].datetime),
          //       date: dateFormat.format(scheduleList[i].datetime), back_color: Colors.white, text_color: univState.currentColor,
          //       // date: scheduleList[i].datetime,
          //     )
          //   else if (daysBetween(DateTime.now(), scheduleList[i].datetime) == 0)
          //     SectionSwitch(
          //       scheduleList[i].name,
          //       Dday: daysBetween(DateTime.now(), scheduleList[i].datetime),
          //       date: dateFormat.format(scheduleList[i].datetime), back_color: univState.currentColor, text_color: Colors.white,
          //     ),
          // SectionSwitch('context, "종강", 154, univState.currentColor,),
          _divider,
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: univState.currentColor,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
                // controller: _eventController,
                ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: null,
                // onPressed: () {
                //   if (_eventController.text.isEmpty) {
                //
                //   } else {
                //     if (selectedEvents![selectedDay] != null) {
                //       selectedEvents![selectedDay]!.add(
                //         Event(title: _eventController.text),
                //       );
                //     } else {
                //       selectedEvents![selectedDay] = [
                //         Event(title: _eventController.text)
                //       ];
                //     }
                //
                //   }
                //   Navigator.pop(context);
                //   _eventController.clear();
                //   setState((){});
                //   return;
                // },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }

  Divider get _divider => Divider(
        height: 3,
        color: Colors.black,
      );

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  SliverToBoxAdapter _imagePager() {
    SchedulesState scheduleState = Provider.of<SchedulesState>(context);
    List scheduleList =
        Provider.of<SchedulesState>(context).schedulesList.scheduleList;
    UniversityState universityState = Provider.of<UniversityState>(context);
    // gridview는 남는 자리 다 차지한다 쓸데없이.. true로 놓으면 방지가능
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            transform: Matrix4.translationValues(_leftImagePageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: Column(
              children: [
                for (int i = 0;
                i < scheduleState.currentScheduleList.length;
                i++)
                  _images(
                      text_color: universityState.currentColor,
                      Dday: 10,
                      date: scheduleList[i].datetime,
                      name: scheduleList[i].name),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            transform: Matrix4.translationValues(_rightImagePageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: Text('asdf'),
          ),
        ],
      ),
    );
  }

  Widget feedListBuilder(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      color: Colors.red,
    );
  }

  ListView _listView() {
    return ListView.builder(
        itemBuilder: (context, index) => Text(
              'asdfas',
              style: TextStyle(fontSize: 5),
            ),
        itemCount: 5);
  }

  GridView _images(
      {required String name,
      required int Dday,
      required DateTime date,
      required Color text_color}) {
    SchedulesState scheduleState = Provider.of<SchedulesState>(context);
    UniversityState universityState = Provider.of<UniversityState>(context);

    return GridView.count(
      crossAxisCount: 1,
      physics: NeverScrollableScrollPhysics(),
      // customScrollView 안에 gridview가 있는데 스크롤 중복 방지해야한다. customscrollview의 scroll만 받는다.
      shrinkWrap: true,
      childAspectRatio: 8,
      children: [
        SectionSwitch(name,
            Dday: Dday,
            date: date,
            back_color: Colors.white,
            text_color: text_color),
      ],
      //   List.generate(
      //       30,
      //           (index) => Container(color:Colors.red, child: Text(index.toString()))),
    );
  }

  Widget _tapButtons() {
    UniversityState univState =
        Provider.of<UniversityState>(context, listen: true);

    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    _tabSelected(SelectedTab.left);
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: _selectedTab == SelectedTab.left
                        ? univState.currentColor
                        : Colors.black26,
                  ),
                ),
                Text(
                  'Whole Schedules',
                  style: TextStyle(
                    color: _selectedTab == SelectedTab.left
                        ? univState.currentColor
                        : Colors.black26,
                  ),
                ),
              ],
            ),
          ),

          VerticalDivider(indent:1, width:10 ,thickness: 2,color: univState.currentColor),
          // Container(height: 30, width: 2,color: univState.currentColor,),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _tabSelected(SelectedTab.right);
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: _selectedTab == SelectedTab.right
                            ? univState.currentColor
                            : Colors.black26,
                      ),
                    ),
                    Text(
                      'My Schedules',
                      style: TextStyle(
                        color: _selectedTab == SelectedTab.right
                            ? univState.currentColor
                            : Colors.black26,
                      ),
                    ),
                  ],
          ),
              ),
        ],
      ),
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          _selectedTab = SelectedTab.left;
          _leftImagePageMargin = 0;
          _rightImagePageMargin = size!.width;
          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImagePageMargin = -size!.width;
          _rightImagePageMargin = 0;
          break;
      }
    });
  }
}

class SectionSwitch extends StatefulWidget {
  final String _title;
  final int Dday;
  final Color back_color;
  final Color text_color;
  final DateTime date;
  bool _checked = false;

  SectionSwitch(
    this._title, {
    Key? key,
    required this.Dday,
    required this.date,
    required this.back_color,
    required this.text_color,
  }) : super(key: key);

  @override
  _SectionSwitchState createState() => _SectionSwitchState();
}

class _SectionSwitchState extends State<SectionSwitch> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    String convertDateTimeDisplay(String date) {
      final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
      final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
      final DateTime displayDate = displayFormater.parse(date);
      final String formatted = serverFormater.format(displayDate);
      return formatted;
    }
    // var scheduleState = Provider.of<UniversityState>(context);
    // var univState = Provider.of<UniversityState>(context, listen: true);

    return ListTile(
      tileColor: widget.back_color,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => DetailSchedule()));
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget._title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: widget.text_color),
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    Text(
                      convertDateTimeDisplay(widget.date.toString()),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.text_color),
                    ),
                    Text(
                      'D - ${(widget.Dday).toString()}',
                      style: TextStyle(fontSize: 13, color: widget.text_color),
                    ),
                  ],
                ),
                SizedBox(
                  width: 3,
                ),
                CupertinoSwitch(
                  value: widget._checked,
                  onChanged: (onValue) {
                    setState(() {
                      widget._checked = onValue;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum SelectedTab { left, right }
