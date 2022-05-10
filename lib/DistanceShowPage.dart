import 'package:flutter/material.dart';
import 'package:yuwaku_proto/Distance_twoPosition.dart';
import 'some_top_page.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';



class DistanceShowPage extends StatefulWidget {
  const DistanceShowPage({
    Key? key,
  }) : super(key: key);

  @override
  _DistanceShowPage createState() => _DistanceShowPage();
}

class _DistanceShowPage extends State<DistanceShowPage>{

  Position? _position;
  late StreamSubscription<Position> positionStream;

  final distanceItem = <Distance>[
    Distance(36.48346516395541, 136.75701193508996),
    Distance(36.48584951599308, 136.75738876226737),
    Distance(36.485425901995455, 136.75758738535384),
    Distance(36.48582537854954, 136.7574341842218),
    Distance(36.49050881078798, 136.75404574490975),
  ];




  @override
  void initState() {
    super.initState();
    Geolocator _geolocator = Geolocator();

    positionStream = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.best,
        intervalDuration: Duration(seconds: 5)
    ).listen((Position position) {
          _position = position;
        });
  }


  void updateLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(new Duration(seconds: 5));

      setState(() {
        _position = newPosition;
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return Container(
              margin: EdgeInsets.all(5),
              child: Column(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        child: Text('目的地まで',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left)),
                    Text('Latitude: ${_position != null ? _position!.latitude.toString() : '0'},'
                        ' Longitude: ${_position != null ? _position!.longitude.toString() : '0'}',
                      style: TextStyle(fontSize: 25),
                    ),
                  ]
              )
        );
      }
    );
  }
}