import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/page/challenge_interface.dart';
import 'package:vienne_en_jeux/page/challenge_marche_aide.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class ChallengeMarche extends StatefulWidget {
const ChallengeMarche({super.key});

@override
_ChallengeMarcheState createState() => _ChallengeMarcheState();
}

class _ChallengeMarcheState extends State<ChallengeMarche> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    drawer: NavigationDrawerWidget(),
    appBar: AppBar(
      title: const Text('Challenge Marche'),
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

        //BOUTON AIDE
        Container(
          alignment: Alignment.topRight,
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
                  icon: const Icon(Icons.question_mark),
                  color: const Color(0xFF375E7E),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChallengeMarcheAide()),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        //SAISIE CODE
        Container(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Code',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF375E7E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: MaterialButton(
                      onPressed: () { },
                      child: Text("Chercher"),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //CHALLENGE EN COURS
        Container(
            child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
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
                                const Text(
                                  "Challenge en cours",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                                const Text(
                                  "Inscrit ⓥ",
                                  style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold),
                                  //"Non inscrit ⓧ",
                                  // style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF375E7E),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ChallengeInterface()),
                              );
                            },
                            child: Text("Titre Challenge"),
                            textColor: Colors.white,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Fin le [dateFin]",
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                ),
            ),
        ),
        Container(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              margin: const EdgeInsets.all(10.0),
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
                      child: const Text(
                        "Dernier challenge",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF375E7E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: MaterialButton(
                      onPressed: () { },
                      child: Text("Titre Challenge"),
                      textColor: Colors.white,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Fini le [dateFin]",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );


}
}
