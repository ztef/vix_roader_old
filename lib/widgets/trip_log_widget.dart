import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vix_roader/domain/pause_options.dart';
import 'package:vix_roader/domain/trip_states.dart';
import 'package:vix_roader/repositories/app_repository.dart';
import 'package:vix_roader/widgets/box_container_widget.dart';
import 'package:vix_roader/states/op_states.dart';

Widget tripLogWidget({required context}) {
  List tripLog = RepositoryProvider.of<AppRepository>(context).getTripLog();
  return Column(children: [
    Text('Bitácora'),
    Container(
        height: 200.0,
        width: 300.0,
        decoration: BoxDecoration(
          //color: const Color(0xff7c94b6),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tripLog.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = tripLog.elementAt(tripLog.length - 1 - index);
                    return Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        //color: const Color(0xff7c94b6),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: LogEntry(
                          action: item['data']['action'],
                          data: item['data'],
                          text: TripState.texto[item['data']['action']],
                          icon: TripState.icono[item['data']['action']],
                          timeStamp:
                              DateFormat('kk:mm').format(item['timeStamp']),
                          onClicked: () => {
                                //setState(
                                //    () => {selectedEndOption = key})
                              }),
                    );
                  },
                )
              ],
            ))))
  ]);
}

class LogEntry extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final icon;
  final timeStamp;
  final action;
  final data;

  LogEntry({
    Key? key,
    required this.text,
    required this.icon,
    required this.timeStamp,
    required this.onClicked,
    required this.action,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          //Icon(icon),
          Text(timeStamp),
          Text(' : '),
          Text("$text : "),
          action == 'PauseTrip'
              ? (Text(PauseOptions.opciones[data['pauseReason']]))
              : Container(),
          Text(" "),
          action == 'PauseTrip'
              ? (Icon(PauseOptions.iconos[data['pauseReason']]))
              : Container(),
        ],
      );
}
