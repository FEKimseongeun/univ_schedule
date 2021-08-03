import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:univ_schedule/constants/common_size.dart';
import 'package:univ_schedule/constants/screen_size.dart';

class DetailSchedule extends StatefulWidget {
  const DetailSchedule({Key? key}) : super(key: key);

  @override
  _DetailScheduleState createState() => _DetailScheduleState();
}

class _DetailScheduleState extends State<DetailSchedule> with SingleTickerProviderStateMixin  {
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('개강', style: TextStyle(fontSize: 40),),
                      ],
                    )),
                    _tapButtons()
                  ]
                ),
              ),
              _imagePager(),
            ],
          )),
        ],
      ),
    );
  }


  SliverToBoxAdapter _imagePager() {
    // gridview는 남는 자리 다 차지한다 쓸데없이.. true로 놓으면 방지가능
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(_leftImagePageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(_rightImagePageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
        ],
      ),
    );
  }

  GridView _images() {
    return GridView.count(
      crossAxisCount: 3,
      physics: NeverScrollableScrollPhysics(),
      // customScrollView 안에 gridview가 있는데 스크롤 중복 방지해야한다. customscrollview의 scroll만 받는다.
      shrinkWrap: true,
      childAspectRatio: 1,
      children: List.generate(
          30,
              (index) => Text('left')),
    );
  }

  Row _tapButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              _tabSelected(SelectedTab.left);
            },
            icon: ImageIcon(
              AssetImage('images/seoul.png'),
              color: _selectedTab == SelectedTab.left
                  ? Colors.black
                  : Colors.black26,
            )),
        IconButton(
            onPressed: () {
              _tabSelected(SelectedTab.right);
            },
            icon: ImageIcon(
              AssetImage('images/seoul.png'),
              color: _selectedTab == SelectedTab.right
                  ? Colors.black
                  : Colors.black26,
            )),
      ],
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

enum SelectedTab { left, right }

