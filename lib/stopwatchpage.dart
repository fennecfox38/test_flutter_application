import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchPage extends StatefulWidget {
  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  Timer _timer;

  int _time = 0;
  bool _isRunnig = false;
  List<LapTime> _lapTimes = [];

  @override void dispose(){ _timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(top: 40, right: 75, child: Text(strTime(_time), style: TextStyle(fontSize: 50.0),), ),
        Positioned(top: 130, child:  Container( width: MediaQuery.of(context).size.width, height: 450,
          child: ListView.builder(
            itemCount: _lapTimes.length,
            itemBuilder: (context, index) => _lapTimes[_lapTimes.length-index-1].getTile(),
            //reverse: true,
          ),
        ),),
        Positioned(left: 70, bottom: 30, child: RaisedButton(
          onPressed: () => setState((){
            _isRunnig = !_isRunnig;
            if(_isRunnig)
              _timer = Timer.periodic(Duration(milliseconds: 10), (timer) => setState(() {++_time;}));
            else _timer?.cancel();
          }),
          child: Text((_isRunnig?'Pause':(_time==0?'Start':'Continue'))),),),
        Positioned(right: 70, bottom: 30, child: RaisedButton(
          onPressed: () {
            if(_isRunnig) setState((){ _lapTimes.add(LapTime(_lapTimes.length+1,_time)); });
            else setState((){ _time = 0; _lapTimes.clear(); });
          },
          child: Text((_isRunnig?'LapTime':'Reset')),),),
      ],
    );
  }

}

class LapTime{
  int place, time;
  LapTime(this.place, this.time);
  ListTile getTile(){
    return ListTile(
      leading: Text('$place'.padLeft(2,'0')),
      title: Center(child: Text(strTime(time))),
    );
  }
}

String strTime(int _time){
  String result="";
  if(_time>=360000) result += '${_time ~/360000}'.padLeft(2,'0') + ':';
  result += '${_time %360000 ~/6000}'.padLeft(2,'0') + ':';
  result += '${_time %6000 ~/100}'.padLeft(2,'0') + '.';
  result += '${_time %100}'.padLeft(2,'0');
  return result;
}
