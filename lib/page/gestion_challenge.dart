import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widget/navigation_drawer_widget.dart';

class GestionChallenge extends StatefulWidget {
  const GestionChallenge({super.key});
  @override
  _GestionChallengeState createState() => _GestionChallengeState();
}

class _GestionChallengeState extends State<GestionChallenge> {

  getDataChallenges() async{
    String theUrl = "http://192.168.1.190/myApp/getDataChallenges.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
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
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                          children: [
                            Row(
                              children : [
                                Text("Challenge ${item['statut_marche']}",
                                style: const TextStyle(
                                  fontWeight : FontWeight.bold,
                                  fontSize: 18
                                ),
                                ),
                              ]
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 5),
                              child : Text(item['nom_defi_marche'],
                                style: const TextStyle(
                                    fontSize: 22
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 5),
                                  child : Text("Début : ${item['date_debut_marche']}",
                                    style: const TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 5),
                                  child : Text("Fin : ${item['date_fin_marche']}",
                                      style: const TextStyle(
                                      fontSize: 16
                                  ),
                                ),
                                ),

                              ],
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 5),
                              child : Text("Taille maximum des équipes : ${item['taille_max_equipe']}",
                                style: const TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),

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
              listChallenges(),
            ]
          ),
          // child: listChallenges(),
        )
    );
  }
}