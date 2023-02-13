import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Podometer extends StatefulWidget {
  @override
  _PodometerState createState() => _PodometerState();
}

class _PodometerState extends State<Podometer> {



  int test = 44;

  String greeting = "";
  late Timer _timer;



//méthode pour update la ligne 'nbre_pas' de la table 'marcher'

  setDataPodometer() async {
    String theUrl = "http://127.0.0.1/myApp/setDataPodometer.php?nbpas=48745&iddefi=1&iduser=21";
    await http.get(Uri.parse(theUrl), headers: {"Accept": "application/json"});
    // var responseBody = json.decode(res.body);
    // return responseBody;
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?',
      _steps = '?';

  @override

  void initState() {
    super.initState();
//méthode qui permet d'update'les données toutes les 3 secondes
    Timer.periodic(Duration(seconds: 3), (timer) {

      setDataPodometer();
    });
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  boutonRecuperer() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF375E7E), // Background color
        foregroundColor: Colors.white, // Text Color (Foreground color)
      ),
      onPressed: () {

        print('CACACACA');

        setDataPodometer();
      }, child: const Text('Récupéré'),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Classement'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30, color: Colors.white),

            ),

            Text(
              _steps,
              style: TextStyle(fontSize: 60, color: Colors.white),
            ),
            Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                  ? Icons.accessibility_new
                  : Icons.error,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? TextStyle(fontSize: 30)
                    : TextStyle(fontSize: 20, color: Colors.red),
              ),

            ),
            Center(
              child: boutonRecuperer(),
            )
          ],

        ),

      ),

    );
  }

}
class Automatic extends StatefulWidget {
  @override
  _AutomaticState createState() => _AutomaticState();
}
class _AutomaticState extends State<Automatic> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      print("Yeah, this line is printed after 3 second");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Challenge Interface'),
          elevation: 0,
        ),
        body: Column(
            children: [

              //BANNIERE
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Image(
                      image: AssetImage('images/banniere_mobile.png'),
                    ),
                  ],
                ),
              )
            ]
        )
    );


  }
}
