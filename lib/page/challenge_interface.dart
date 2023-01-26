import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/page/bonus.dart';
import 'package:vienne_en_jeux/page/Classement.dart';
import 'package:vienne_en_jeux/page/Participants.dart';
import 'package:vienne_en_jeux/page/challenge_marche.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class ChallengeInterface extends StatefulWidget {
  const ChallengeInterface({super.key});

  @override
  _ChallengeInterfaceState createState() => _ChallengeInterfaceState();
}

class _ChallengeInterfaceState extends State<ChallengeInterface> {
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
          ),

          //BOUTON RETOUR
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.all(10.0),
            child: Material(
              color: const Color(0xFF375E7E),
              child: Container(
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.white70,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back ),
                    color: const Color(0xFF375E7E),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChallengeMarche()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          Container(
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      child : Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              child: const Text(
                                "[Titre Challenge]",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              child: const Text(
                                "Du [Date début] au [Date fin] inclus.",
                                style: TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      child : Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(7.0),
                              child: const Text(
                                "VOTRE ÉQUIPE EST COMPLÈTE !",
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(7.0),
                              child: const Text(
                                "Équipe : [Nb points] pts",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(3.0),
                              child: const Text(
                                "Vous ([Nom user]) avez fait [Nb points] pts.",
                                style: TextStyle(),
                              ),
                            ),
                            //BOUCLER POUR CHAQUE ÉQUIPIER
                            Container(
                              margin: const EdgeInsets.all(3.0),
                              child: const Text(
                                "[Nom user équipier] a fait [Nb points] pts.",
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(3.0),
                              child: const Text(
                                "Bonus de l'équipe : [Nb points] pts.",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.question_mark, size: 30),
                        color: const Color(0xFF375E7E),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),

              Flexible(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Flexible(
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recherche joueur',
                      ),
                    ),
                  ),
                ),
              ),

              //BOUTON AIDE
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.card_giftcard, size: 30),
                        color: const Color(0xFF375E7E),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Bonus()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.people_outlined, size: 30),
                        color: const Color(0xFF375E7E),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChallengeParticipants()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              //BOUTON AIDE
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.refresh, size: 30),
                        color: const Color(0xFF375E7E),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.format_list_bulleted, size: 30),
                        color: const Color(0xFF375E7E),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Classement()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    );


  }
}