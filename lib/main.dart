import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'dart:ui';

Timer _timer;
int _start = 0;
String lottie_asset = 'assets/load_aba.json';
String lottie_asset2 = 'assets/load_fail.json';
bool _visible = true;
bool _visible2 = false;
bool _time = true;
AnimationController _controller;
AnimationController _animationController;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    if (_time) {
      startTimer();
      _time = false;
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 500));
    }

    return Scaffold(
        body: Container(
      child: Center(
          child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              child: Visibility(
                  visible: _visible,
                  child: Lottie.asset(lottie_asset,
                      repeat: _visible, controller: _animationController))),
          Container(
              alignment: Alignment.center,
              child: Visibility(
                  visible: _visible2,
                  child: Lottie.asset(lottie_asset2,
                      repeat: _visible, controller: _animationController))),
          Container(
              alignment: Alignment.center,
              child: Visibility(
                visible: _visible,
                child: Text(_start.toString() + '%',
                    style: TextStyle(
                        fontFamily: 'AVENIRLTSTD-BOOK', fontSize: 40)),
              ))
        ],
      )),
    ));
  }

  void startTimer() {
    const oneSec = const Duration(microseconds: 100000);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        //_animationController.forward();
        if (_start == 100) {
          print("cero");
          setState(() {
            //lottie_asset = 'assets/load_ok.json';
            _visible = false;
            _visible2 = true;
            _animationController = _controller;
            timer.cancel();
          });
        } else {
          print(_start.toString());
          setState(() {
            _start++;
          });
        }
      },
    );
  }
}
