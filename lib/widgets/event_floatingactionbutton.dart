// import 'package:flutter/material.dart';
// import 'package:univ_schedule/event.dart';
//
// FloatingActionButton buildFloatingActionButton(BuildContext context, TextEditingController _eventController, DateTime selectedDay, Map<DateTime, List<Event>>? selectedEvents) {
//   return FloatingActionButton.extended(
//     onPressed: () => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Add Event"),
//         content: TextFormField(
//           controller: _eventController,
//         ),
//         actions: [
//           TextButton(
//             child: Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           TextButton(
//             child: Text("Ok"),
//             onPressed: () {
//               if (_eventController.text.isEmpty) {
//
//               } else {
//                 if (selectedEvents![selectedDay] != null) {
//                   selectedEvents![selectedDay]!.add(
//                     Event(title: _eventController.text),
//                   );
//                 } else {
//                   selectedEvents![selectedDay] = [
//                     Event(title: _eventController.text)
//                   ];
//                 }
//
//               }
//               Navigator.pop(context);
//               _eventController.clear();
//               setState((){});
//               return;
//             },
//           ),
//         ],
//       ),
//     ),
//     label: Text("Add Event"),
//     icon: Icon(Icons.add),
//   );
// }