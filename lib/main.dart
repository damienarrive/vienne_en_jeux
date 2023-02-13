import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/page/bonus.dart';
import 'package:vienne_en_jeux/page/challenge_marche.dart';
import 'package:vienne_en_jeux/page/inscription_prof.dart';
import 'package:vienne_en_jeux/page/inscription_user.dart';
import 'package:vienne_en_jeux/page/mentions_legales.dart';
import 'package:vienne_en_jeux/page/politique_confidentialite.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:vienne_en_jeux/page/condition_generales_utilisation.dart';
import 'package:vienne_en_jeux/page/connexion.dart';
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
        primarySwatch: white,
        scaffoldBackgroundColor: const Color(0xFF375E7E),
      ),
      routes: {
        '/': (context) => MainPage(),
        '/Challenges': (context) => ChallengeMarche(),
        '/Bonus' : (context) => Bonus(),
        '/Connexion': (context) => Connexion(),
        '/Inscription': (context) => Inscription(),
        '/InscriptionProf': (context) => InscriptionProf(),
        '/CGU': (context) => PageCGU(),
        '/PolitiqueConf': (context) => PagePolitiqueConf(),
        '/MentionsLegales': (context) => PageMentionsLegales(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Accueil'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "L'application Vienne en Jeux vous propose de participer à des challenges de marche / de course. Ces challenges se déroulent sur des périodes courtes. \nL'application comptabilise le nombre de pas grâce à un podomètre intégré. \n\nPour participer, créer un compte et rendez-vous dans l'onglet Challenges puis cliquez sur Challenge de marche.",
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
