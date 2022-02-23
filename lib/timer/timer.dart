import 'dart:async';
import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'package:flutter/widgets.dart';

class TimerApp extends StatefulWidget {
  const TimerApp({Key? key}) : super(key: key);

  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;
  void startTimer({bool reset = true}) {
    if(reset){
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1),(_){
      if(seconds > 0) {
        setState(() => seconds--);
      } else{
        stopTimer(reset: false);
      }
    });
  }
  void resetTimer() => setState(() => seconds = maxSeconds);

  void stopTimer( {bool reset = true}){
    if(reset){
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

          appBar: AppBar(title: Text("TimerApp"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTime(),
                const SizedBox(height: 80),
                buildButtons(),
              ],
            ),
          )
      ),
    );
  }
  Widget buildButtons(){
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;
    return isRunning || !isCompleted
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
          text: isRunning? 'Pause' : 'Resume',
          onClicked: () {
            if(isRunning) {
              stopTimer(reset: false);
            } else{
              startTimer(reset: false);
            }
          },
        ),
        const SizedBox(width: 12),
        ButtonWidget(
          text: 'Cancel',
          onClicked: stopTimer,
        )
      ],
    )
        : ButtonWidget(
      text:  'Start Timer',
      color: Colors.black,
      backgroundColor: Colors.white,
      onClicked: () {
        startTimer();
      },
    );
  }

  Widget buildTime(){
    return Text(
      '$seconds',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 80,
      ),
    );
  }



}

