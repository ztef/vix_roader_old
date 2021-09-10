import 'package:flutter/material.dart';

Widget boxContainer(Widget w) {
  return Container(
    margin: const EdgeInsets.all(30.0),
    padding: const EdgeInsets.all(10.0),
    decoration: myBoxDecoration(), //       <--- BoxDecoration here
    child: w,
  );
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 3.0,
      color: Colors.blue,
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(10.0) //         <--- border radius here
        ),
  );
}
