import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vienne_en_jeux/widget/connexion_button_widget.dart';
import '../widget/navigation_drawer_widget.dart';

class GestionChallenge extends StatefulWidget {
  const GestionChallenge({super.key});
  @override
  _GestionChallengeState createState() => _GestionChallengeState();
}

class _GestionChallengeState extends State<GestionChallenge> {

  getDataChallenges() async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataChallenges.php";
    // String theUrl = "http://192.168.1.190/myApp/getDataChallenges.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  supprDataChallenge(iddefi) async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/supprDataChallenge.php?iddefi=$iddefi";
    // String theUrl = "http://192.168.1.190/myApp/supprDataChallenge.php?iddefi=$iddefi";
    await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
  }

  listChallenges(){
    return FutureBuilder(
      future: getDataChallenges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("ERROR fetching data"),
            );
          }

          List listChall = snapshot.data;
          return Column(
              children: listChall.map((item) =>
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          children: [
                            Row(
                              children : [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 10),
                                  child: Text("Challenge ${item['statut_marche']}",
                                    style: const TextStyle(
                                        fontWeight : FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                              ]
                            ),

                            Container(
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 10),
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1.0, color: Colors.black))
                              ),
                              child : Text(item['nom_defi_marche'],
                                style: const TextStyle(
                                    fontSize: 22
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 10),
                                  child : Text("Début : ${item['date_debut_marche']}",
                                    style: const TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 10),
                                  child : Text("Fin : ${item['date_fin_marche']}",
                                      style: const TextStyle(
                                      fontSize: 16
                                      ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 10),
                                  child : Text("Taille maximum d'équipe : ${item['taille_max_equipe']}",
                                    style: const TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if(item['statut_marche'] == 'En cours')...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal : 15),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/Modif_Challenge', arguments: [item]);
                                        },
                                        textColor: Colors.white,
                                        color: const Color(0xFF375E7E),
                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                                        child: const Text('Modifier'),
                                      )
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal : 15),
                                      child: MaterialButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                    content: Text("Souhaitez vous réellement supprimer le challenge ${item['nom_defi_marche']}."),
                                                    actions: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.all(10.0),
                                                            child: Material(
                                                              color: Colors.white70,
                                                              child:  Ink(
                                                                decoration: const ShapeDecoration(
                                                                  color: Color(0xFF375E7E),
                                                                  shape: CircleBorder(),
                                                                ),
                                                                child: IconButton(
                                                                  icon: const Icon(Icons.arrow_back),
                                                                  // color: const Color(0xFF375E7E),
                                                                  color: Colors.white,
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
                                                              child: MaterialButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                  supprDataChallenge(item['id_defi_marche']);
                                                                  setState(() {
                                                                    getDataChallenges();
                                                                  });
                                                                },
                                                                textColor: Colors.white,
                                                                color: Colors.red,
                                                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                                                                child: const Text('Supprimer'),
                                                              )
                                                          )

                                                        ],
                                                      )

                                                    ]
                                                  )
                                          );
                                        },
                                        textColor: Colors.white,
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0)),
                                        child: const Text('Supprimer'),
                                      )
                                  ),
                                ],
                              )
                            ]
                          ]
                      )
                  )
              ).toList());
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Gestion Challenges'),
          elevation: 0,
            actions : <Widget>[
              ConnexionButtonWidget(),
            ]
        ),
        body: SingleChildScrollView(
          child : Column(
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
                      image: AssetImage('images/banniere_mobile.png'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF375E7E),
                        ),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, '/Creation_Challenge');
                        },
                        label : const Text(
                          'Créer un challenge',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ),
              ),
              listChallenges(),
            ]
          ),
          // child: listChallenges(),
        )
    );
  }
}