import 'package:flutter/material.dart';
import 'package:univ_schedule/models/univ_state.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({
    Key? key,
    required this.univState, required this.title,
  }) : super(key: key);

  final UniversityState univState;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        minVerticalPadding: 0,
        title: ListTile(
          leading: Image.asset(
            'images/${univState.currentUnivEnName}.png',
            width: 30,
            height: 30,
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: univState.currentColor),
          ),
        ),
        dense: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}