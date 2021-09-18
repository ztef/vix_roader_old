import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/time_logic.dart';
import 'package:vix_roader/repositories/app_repository.dart';

Widget tripHistoryWidget({required context}) {
  List tripHistory =
      RepositoryProvider.of<AppRepository>(context).getTripHistory();
  return Column(children: [
    Text('Viajes Realizados'),
    Container(
        height: 350.0,
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
                  itemCount: tripHistory.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item =
                        tripHistory.elementAt(tripHistory.length - 1 - index);
                    return Container(
                      width: 90,
                      height: 60,
                      decoration: BoxDecoration(
                        //color: const Color(0xff7c94b6),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: TripEntry(
                        id: item['tripId'],
                        stop: item['stopReason'],
                        data: item['tripData'],
                        onClicked: () {
                          print(item['tripId']);
                        },
                      ),
                    );
                  },
                )
              ],
            )))),
    const Divider(
      height: 20,
      thickness: 5,
      indent: 20,
      endIndent: 20,
    ),
    tripStatsWidget(tripHistory),
  ]);
}

class TripEntry extends StatelessWidget {
  final id;
  final VoidCallback onClicked;

  final stop;
  final data;

  TripEntry({
    Key? key,
    required this.id,
    required this.stop,
    required this.data,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: onClicked,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Viaje : $id'),
            Row(
              children: [
                //Icon(icon),

                (data != null) ? Text("${data['destiny']} : ") : Text(''),
                Text(stop),
              ],
            ),
          ]));
}

_showTrip(id) {
  print('Viaje Seleccionado $id');
}

Widget tripStatsWidget(tripHistory) {
  var tripStats = tripStatsCalc(tripHistory);

  return Container(
      decoration: BoxDecoration(
        //color: const Color(0xff7c94b6),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(children: [
        Text('Estadísticas  :'),
        Text('Viajes : ${tripStats['trips']} '),
        Text('Tiempos :'),
        Text('Viaje      : ${timeFormat(tripStats['tripTime'])} '),
        Text('Conducción : ${timeFormat(tripStats['driveTime'])} '),
        Text('Pausa      : ${timeFormat(tripStats['pauseTime'])} '),
      ]));
}
