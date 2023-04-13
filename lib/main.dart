import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:vienne_en_jeux/page/challenge_marche.dart';
import 'package:vienne_en_jeux/page/classementAncien.dart';
import 'package:vienne_en_jeux/page/creation_challenge.dart';
import 'package:vienne_en_jeux/page/gestion_challenge.dart';
import 'package:vienne_en_jeux/page/mentions_legales.dart';
import 'package:vienne_en_jeux/page/modif_challenge.dart';
import 'package:vienne_en_jeux/page/politique_confidentialite.dart';
import 'package:vienne_en_jeux/page/verification.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:vienne_en_jeux/page/condition_generales_utilisation.dart';
import 'package:vienne_en_jeux/page/connexion.dart';
import 'package:vienne_en_jeux/page/challenge_interface.dart';
import 'package:vienne_en_jeux/page/bonus.dart';
import 'package:vienne_en_jeux/page/classement.dart';
import 'package:vienne_en_jeux/page/participants.dart';
import 'package:vienne_en_jeux/page/challenge_marche_aide.dart';
import 'package:vienne_en_jeux/page/inscription.dart';
import 'package:vienne_en_jeux/page/mdpOublie.dart';
import 'package:vienne_en_jeux/page/pedometer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('fr')
      ],
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
        '/Connexion': (context) => Connexion(),
        '/Inscription': (context) => Inscription(),
        '/Verification': (context) => Verification(),
        '/CGU': (context) => PageCGU(),
        '/PolitiqueConf': (context) => PagePolitiqueConf(),
        '/MentionsLegales': (context) => PageMentionsLegales(),
        '/Challenge_Aide': (context) => ChallengeMarcheAide(),
        '/Challenge_Interface': (context) => ChallengeInterface(),
        '/Gestion_Challenge': (context) => GestionChallenge(),
        '/Creation_Challenge': (context) => CreationChallenge(),
        '/Modif_Challenge' : (context) => ModifChallenge(),
        '/Bonus': (context) => Bonus(),
        '/Classement': (context) => Classement(),
        '/ClassementAncien': (context) => ClassementAncien(),
        '/Participants': (context) => ChallengeParticipants(),
        '/MdpOublie': (context) => MdpOublie(),
        '/Podometre': (context) => Podometre(),
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
  String text = "";
  @override
  void initState(){
    super.initState();
    _getSession();
  }

  _getSession() async{
    dynamic user = await SessionManager().get('userId');
    setState(() {
      text = user.toString();
    });
  }

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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "L'application Vienne en Jeux vous propose de participer à des challenges de marche / de course. Ces challenges se déroulent sur des périodes courtes. \nL'application comptabilise le nombre de pas grâce à un podomètre intégré. \n\nPour participer, créer un compte et rendez-vous dans l'onglet Challenges puis cliquez sur Challenge de marche.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                  Text(text),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
