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

  final distanceItem = <Distance>[
    Distance(36.48346516395541, 136.75701193508996),
    Distance(36.48584951599308, 136.75738876226737),
    Distance(36.485425901995455, 136.75758738535384),
    Distance(36.48582537854954, 136.7574341842218),
    Distance(36.49050881078798, 136.75404574490975),
  ];
  double? distance;

  void setDistance(Position position) {
    this.distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, this.distanceItem.first, this.longitude);
  }


  Position? _position;
  late StreamSubscription<Position> positionStream;


  Future<void> count() async{
    var counterStream = Stream<int>.periodic(
        const Duration(seconds: 2),

    );
    await for(int n in counterStream){
      print(n);
    }
  }


  @override
  void initState() {
    super.initState();

  }
/*
  positionStream = Geolocator.getPositionStream(
  desiredAccuracy: LocationAccuracy.best,
  intervalDuration: Duration(seconds: 5)
  ).listen((Position position) {
  _position = position;
  });*/


  Stream<Position> updateLocation() async* {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(new Duration(seconds: 5));
      setState(() {
        _position = newPosition;
      });
      yield* newPosition;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      child: _buildStreamBuilder(),
    );
  }
  Widget _buildStreamBuilder(){
    return Center(
      child: StreamBuilder<void>(
        stream: updateLocation(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.active)
            return  Column(
              children: <Widget>[
                Text(
                  'Latitude: ${_position!.latitude}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                    'Longitude: ${_position!.longitude}',
                  style: TextStyle(fontSize: 20),
                )
              ]
            );
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }




}