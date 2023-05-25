import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pedometer/pedometer.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';


class Podometre extends StatefulWidget {
  @override
  _PodometreState createState() => _PodometreState();
}

class _PodometreState extends State<Podometre> {


  late Stream<StepCount> _stepCountStream;
  String _steps = '0';
  int _stepLatest = 0, _stepsTot = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // void onStepCount(StepCount event) {
  //   print(event);
  //   setState(() {
  //     _steps = event.steps.toString();
  //   });
  // }
  //
  // void onStepCountError(error) {
  //   print('onStepCountError: $error');
  //   setState(() {
  //     _steps = 'Step Count not available';
  //   });
  // }

  void _onData(StepCount receivedData) {
    print('[Pedometer] Data received: $receivedData');

    int pas = int.parse(receivedData.steps.toString());
    if(_stepLatest == 0 || _stepLatest>pas){
      _stepLatest = pas;
    }

    // Check the difference from latest steps
    int stepsDiff = pas - _stepLatest;
    print(_stepLatest);

    // Sometimes they return the same values. We only want different values
    if(stepsDiff != 0) {
      _stepsTot = _stepsTot + stepsDiff;
      setState(() {
        _stepLatest = pas;
        _steps = _stepsTot.toString();
      });
    }

    //TODO fonction pour ajout _stepLatest dans bdd

  }

  void _onError(err) {
    print('[Pedometer] Error: $err');
  }

  void _onDone() {
    print('[Pedometer] Done');
  }

  Future<void> initPlatformState() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(
      _onData,
      onError: _onError,
      onDone: _onDone,
      cancelOnError: true,
    );

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Podometre'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),

            Text(
              _steps,
              style: TextStyle(fontSize: 60, color: Colors.white),
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    initPlatformState();
                  });
                },
                child: const Text('Rafraichir'))
          ],
        ),
      ),
    );

  }
}