import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
// import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

void main() {
  runApp(const MyApp());
}

const MaterialColor white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accueil',
      theme: ThemeData(
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.black, displayColor: Colors.black),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: white,
        scaffoldBackgroundColor: const Color(0xFF375E7E),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accueil',
      theme: ThemeData(
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.black, displayColor: Colors.black),
        // This is the theme of your application.
        primarySwatch: white,
        scaffoldBackgroundColor: const Color(0xFF375E7E),
      ),
      home: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Accueil'),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              // mainAxisAlignment: MainAxisAlignment.start,
              // children: const [
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Image(
                    image: AssetImage('images/banniere_avec_logos.png'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(50.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // Text('Vienne en jeux', textAlign: TextAlign.left),
                    child: const Text(
                      """L'application Vienne en Jeux vous propose de participer ?? des challenges de marche / de course. Ces challenges se d??roulent sur des p??riodes courtes. \nL'application comptabilise le nombre de pas gr??ce ?? l'application HealthKit. \n\nPour participer, cr??er un compte et rendez-vous dans l'onglet Challenges puis cliquez sur Challenge de marche.""",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
