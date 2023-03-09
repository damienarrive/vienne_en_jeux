import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChallengeInterface extends StatefulWidget {
  const ChallengeInterface({super.key});

  @override
  _ChallengeInterfaceState createState() => _ChallengeInterfaceState();
}

  getDataChallengeInterface(iddefi, iduser)async{
    String theUrl = "http://172.20.10.7/my-app/getDataChallengeInterface.php?iddefi=$iddefi&iduser=$iduser";
    //String theUrl = "http://localhost/my-app/getData.php";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataChallengeInterface_Equipe(iddefi, iduser)async{
    String theUrl = "http://172.20.10.7/my-app/getDataChallengeInterface_Equipe.php?iddefi=$iddefi&iduser=$iduser";
    //String theUrl = "http://localhost/my-app/getData.php";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataNbParticipants(iddefi)async{
    String theUrl = "http://172.20.10.7/my-app/getDataNbParticipants.php?iddefi=$iddefi";
    //String theUrl = "http://localhost/my-app/getData.php";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

class _ChallengeInterfaceState extends State<ChallengeInterface> {
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as List;

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
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ),

        FutureBuilder(
          future: getDataChallengeInterface(args[0], args[1]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("ERROR fetching data"),
                );
              }
              List snap = snapshot.data;
              return
                Column(
                  children: [
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
                                  icon: const Icon(
                                      Icons.question_mark, size: 30),
                                  color: const Color(0xFF375E7E),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ),

                        Flexible(
                          child:  rechercheJoueur(snap[0], args[0], args[1]),
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
                                  icon: const Icon(
                                      Icons.card_giftcard, size: 30),
                                  color: const Color(0xFF375E7E),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/Bonus',
                                      arguments: [args[0], args[1]],
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
                                  icon: const Icon(
                                      Icons.people_outlined, size: 30),
                                  color: const Color(0xFF375E7E),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/Participants',
                                      arguments: [args[0], args[1]],
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
                                  onPressed: () {
                                    setState(() {
                                      getDataChallengeInterface(args[0], args[1]);
                                    });
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
                                  icon: const Icon(
                                      Icons.format_list_bulleted, size: 30),
                                  color: const Color(0xFF375E7E),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/Classement',
                                      arguments: [args[0], args[1]],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "${snap[0]['nom_defi_marche']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(5.0),
                                        child: afficheDate(snap[0]),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: affichagePoint(snap[0], args[0], args[1]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
        ),
      ],
      ),
    );
  }

  affichagePoint(ligne, iddefi, iduser) {
    if(ligne['id_equipe_marche'].length != 0){
      return FutureBuilder(
          future: getDataChallengeInterface_Equipe(iddefi, iduser),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("ERROR fetching data"),
                );
              }
              List snap = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(7.0),
                    child: const Text(
                      "VOTRE ÉQUIPE EST COMPLÈTE !",
                      style: TextStyle(color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(7.0),
                    child: Text(
                      "Équipe : ${snap[0]['score_equipe']} pts",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    child: Text(
                      "Vous (${ligne['login_user']}) avez fait ${ligne['nbre_pas']} pas.",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    child: Text(
                      "Bonus de l'équipe : ${snap[0]['bonus_equipe']} pts.",
                    ),
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment
            .start,
        children: [
          Container(
            margin: const EdgeInsets.all(7.0),
            child: const Text(
              "VOUS ÊTES INSCRIT DANS AUCUNE ÉQUIPE !",
              style: TextStyle(color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7.0),
            child: Text(
              "Votre score : ${ligne['score']} pts",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(3.0),
            child: Text(
              "Vous (${ligne['login_user']}) avez fait ${ligne['nbre_pas']} pas.",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(3.0),
            child: Text(
              "Votre bonus : ${ligne['bonus']} pts.",
            ),
          ),
        ],
      );
    }
  }

  afficheDate(ligne){
    var valDateDeb = ligne['date_debut_marche'].split('-');
    var valDateFin = ligne['date_fin_marche'].split('-');
    return Text(
      "Du ${valDateDeb[2]}/${valDateDeb[1]}/${valDateDeb[0]} au ${valDateFin[2]}/${valDateFin[1]}/${valDateFin[0]} inclus.",
      style: TextStyle(),
    );
  }

  rechercheJoueur(ligne, iddefi, iduser){
    if(ligne['id_equipe_marche'].length != 0){
      return FutureBuilder(
          future: getDataChallengeInterface_Equipe(iddefi, iduser),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
          return Center(
          child: Text("ERROR fetching data"),
          );
          }
          List snap = snapshot.data;
          return Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${snap[0]['nom_equipe']}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
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
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Flexible(
          child: const TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: 'Recherche joueur',
            ),
          ),
        ),
      );
        /*
        FutureBuilder(
        future: getDataNbParticipants(iddefi),
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
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Flexible(
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Recherche joueur',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        final result = snap[index];

                        return ListTile(
                          //TODO : https://www.google.com/search?q=flutter+search+bar+with+listview&rlz=1C1GCEA_enFR1006FR1006&oq=flutter+search+bar+wi&aqs=chrome.1.69i57j0i512l2j0i22i30i625l4j0i22i30j0i22i30i625j0i22i30.10228j0j7&sourceid=chrome&ie=UTF-8#kpvalbx=_7MX4Y7qjKrKVxc8Pt_-csA0_27
                        );
                      },
                    ),
                )
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
      */

    }
  }

}
