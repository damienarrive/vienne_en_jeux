import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/connexion_button_widget.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class ChallengeMarcheAide extends StatefulWidget {
  const ChallengeMarcheAide({super.key});

  @override
  _ChallengeMarcheAideState createState() => _ChallengeMarcheAideState();
}

class _ChallengeMarcheAideState extends State<ChallengeMarcheAide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Challenges de marche'),
          elevation: 0,
            actions : <Widget>[
              ConnexionButtonWidget(),
            ]
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(10.0),
              child: Material(
                color: const Color(0xFF375E7E),
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.white70,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back ),
                      color: const Color(0xFF375E7E),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
              ),
        ),
            Container(
              margin: const EdgeInsets.all(50.0),
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Le challenge de marche vous met au défi de réaliser le maximum de pas (marche ou course) sur une période donnée, seul ou en équipe. \nPour participer, il vous faut ouvrir un compte, vous connecter sur Vienne en Jeux, et vous inscrire au Challenge. \nPour fonctionner, Vienne en Jeux utilise les informations sur le nombre de pas récoltés par le podomètre de votre téléphone.",
                textAlign: TextAlign.justify,
              ),
            ),
]
              ),
            );

  }
}