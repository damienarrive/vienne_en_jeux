import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

import 'package:vienne_en_jeux/page/challenge_interface.dart';


class ChallengeParticipants extends StatefulWidget {
  const ChallengeParticipants({super.key});

  @override
  _ChallengeParticipantsState createState() => _ChallengeParticipantsState();
}

class _ChallengeParticipantsState extends State<ChallengeParticipants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Participants'),
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
                            MaterialPageRoute(builder: (context) => const ChallengeInterface()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              //Audit M2
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
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Audit M2",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ChallengeInterface()),
                              );
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                              Text("Nombre d'uilisateurs : "),


                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ChallengeInterface()),
                              );
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                              Text("Nombre d'uilisateurs en équipe : "),


                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),

              //Equipes et noms des gars
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

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [

                                        const Text(
                                          "Nom",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                        ),

                                        const Text(
                                          "Equipe",
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                          //"Non inscrit ⓧ",
                                          // style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ]
                          )
                      )
                  )
              )
            ]
        )
    );


  }
}