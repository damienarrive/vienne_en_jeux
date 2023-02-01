import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:vienne_en_jeux/page/challenge_interface.dart';
import 'package:vienne_en_jeux/page/challenge_marche_aide.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChallengeMarche extends StatefulWidget {
  const ChallengeMarche({super.key});
  @override
  _ChallengeMarcheState createState() => _ChallengeMarcheState();
}
class _ChallengeMarcheState extends State<ChallengeMarche> {

  getDataChallengeEnCours() async {
    String theUrl = "http://172.20.10.7/my-app/getDataChallengeEncours.php";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getVerifChallengeCours() async {
    String theUrl = "http://172.20.10.7/my-app/getVerifChallengeCours.php";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataChallengeInscription(ligne) async {
    String theUrl = "http://172.20.10.7/my-app/getDataChallengeInscription.php?iddefi=${ligne['id_defi_marche']}&iduser=19";
    var res = await http.get(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  setDataChallengeInscription(ligne) async {
    String theUrl = "http://172.20.10.7/my-app/setDataChallengeInscription.php?iddefi=${ligne['id_defi_marche']}&iduser=19";
    //String theUrl = "http://172.20.10.7/my-app/setDataChallengeInscription.php";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
  }

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
                        labelText: 'Code de challenge privé',
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
                      child: afficheChallengeEnCours(),
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

  afficheChallengeEnCours(){
    return FutureBuilder(
      future: getVerifChallengeCours(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR fetching data"),
            );
          }
          List verif = snapshot.data;
          if (verif[0]['count'] == "1") {
            return FutureBuilder(
              future: getDataChallengeEnCours(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR fetching data"),
                    );
                  }
                  List snap = snapshot.data;
                  return Column(
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Challenge en cours",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Container(
                                child: afficheInscription(snap[0]),
                              ),
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
                        child: afficheBoutonChallengeEnCours(snap[0]),
                      ),
                      Container(
                        child: afficheDate(snap[0]['date_fin_marche']),
                      ),
                    ],
                  );
                }
                else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
          else{
            return Container(
              child: const Text("caca"),
            );
          }
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
);

  }

  afficheInscription(ligne) {
    return FutureBuilder(
      future: getDataChallengeInscription(ligne),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasError){
            return Center(
              child: Text("ERROR fetching data"),
            );
          }
          List snap = snapshot.data;
          if(snap[0]['count'] == "1") {
            return const Text(
              "Inscrit ⓥ",
              style: TextStyle(color: Colors.green,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            );
          }
          else{
            return const Text(
              "Non inscrit ⓧ",
              style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            );
          }
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  afficheBoutonChallengeEnCours(ligne){
    return FutureBuilder(
      future: getDataChallengeInscription(ligne),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasError){
            return Center(
              child: Text("ERROR fetching data"),
            );
          }
          List snap = snapshot.data;
          if(snap[0]['count'] == "1") {
            return MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (
                      context) => const ChallengeInterface()),
                );
              },
              child: Text("${ligne['nom_defi_marche']}"),
              textColor: Colors.white,
            );
          }
          else{
            return MaterialButton(
              onPressed: () {
                setDataChallengeInscription(ligne);
                setState(() {
                  getDataChallengeEnCours();
                });
              },
              child: Text("S'insrire à ${ligne['nom_defi_marche']}"),
              textColor: Colors.white,
            );
          }
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  afficheDate(date){
    var dateFormat = date.split('-');
    return Text(
      "Fin le ${dateFormat[2]}/${dateFormat[1]}/${dateFormat[0]}",
      style: TextStyle(fontSize: 15),
    );
  }

}
