import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vienne_en_jeux/widget/connexion_button_widget.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChallengeMarche extends StatefulWidget {
  const ChallengeMarche({super.key});
  @override
  _ChallengeMarcheState createState() => _ChallengeMarcheState();
}

class _ChallengeMarcheState extends State<ChallengeMarche> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController codePrive = TextEditingController();

  var session = SessionManager();
  String id = "";
  String nom = "";
  String prenom = "";
  @override
  void initState(){
    super.initState();
    _getSession();
  }

  _getSession() async{
    var idUser = await session.get('userId');
    var nomUser = await session.get('nom');
    var prenomUser = await session.get('prenom');
    setState(() {
      id = idUser.toString();
      nom = nomUser.toString();
      prenom = prenomUser.toString();
    });
  }

  getDataChallengeEnCours() async {
    // String theUrl = "http://192.168.1.190/myApp/getDataChallengeEnCours.php";
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataChallengeEnCours.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getVerifChallengeCours() async {
    // String theUrl = "http://192.168.1.190/myApp/getVerifChallengeCours.php";
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getVerifChallengeCours.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataChallengeInscription(ligne) async {
    // String theUrl = "http://192.168.1.190/myApp/getDataChallengeInscription.php?iddefi=${ligne['id_defi_marche']}&iduser=$id";
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataChallengeInscription.php?iddefi=${ligne['id_defi_marche']}&iduser=$id";
    var res = await http.get(Uri.parse(theUrl), headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  setDataChallengeInscription(ligne) async {
    // String theUrl = "http://192.168.1.190/myApp/setDataChallengeInscription.php?iddefi=${ligne['id_defi_marche']}&iduser=$id";
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/setDataChallengeInscription.php?iddefi=${ligne['id_defi_marche']}&iduser=$id";
    await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
  }


  //récupère les données des challenges en statut 'Termine'
  getDataAncienChallenge() async {
    // String theUrl = "http://192.168.1.190/myApp/getDataAncienChallenge.php";
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataAncienChallenge.php";
    var res = await http.get(Uri.parse(theUrl), headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getVerifAncienChallenge() async {
    // String theUrl = "http://192.168.1.190/myApp/getVerifAncienChallenge.php";
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getVerifAncienChallenge.php";
    var res = await http.get(
        Uri.parse(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Challenge Marche'),
        elevation: 0,
          actions : <Widget>[
            ConnexionButtonWidget(),
          ]
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
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.white70,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.question_mark),
                  color: const Color(0xFF375E7E),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/Challenge_Aide',
                    );
                  },
                ),
              ),
            ),
          ),


          //CHALLENGE EN COURS
          FractionallySizedBox(
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
          FractionallySizedBox(
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
                     Align(
                      alignment: Alignment.centerLeft,
                      child: afficheAncienChallenges(),
                      ),
                  ],
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
                       Align(
                         alignment: Alignment.centerLeft,
                         child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
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
                      Container(
                        margin: const EdgeInsets.all(10),
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
                          // Container(
                          //   child: afficheInscription(snap[0]),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Pas de challenges en cours"),
                          ]
                      ),


                    ),
                  )

                ]
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
            return Container(
                decoration: BoxDecoration(
                color: const Color(0xFF375E7E),
                borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/Challenge_Interface',
                      arguments: [ligne['id_defi_marche'], id],
                    );
                  },
                  textColor: Colors.white,
                  child: Text("${ligne['nom_defi_marche']}"),
                )
            );
          }
          else{
            if(id != "null"){
              if(ligne['code_prive'] == null) {
                return Container(
                    decoration: BoxDecoration(
                    color: const Color(0xFF375E7E),
                    borderRadius: BorderRadius.circular(20),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        setDataChallengeInscription(ligne);
                        setState(() {
                          getDataChallengeEnCours();
                        });
                      },
                      child: Text("S'insrire à ${ligne['nom_defi_marche']}"),
                      textColor: Colors.white,
                    )
                );
              }
              else{
                return Form(
                  key: _formKey,
                    child:  FractionallySizedBox(
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
                              TextFormField(
                                controller: codePrive,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  // hintText: 'Code de challenge privé',
                                  // border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(width: 1, color: Colors.indigo),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(width: 1, color: Colors.grey),
                                  ),
                                  // fillColor: Colors.white,
                                  // filled: true,
                                  hintText: 'Code de challenge privé',
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Un code est nécessaire';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF375E7E),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if(codePrive.text == ligne['code_prive'].toString()){
                                          setDataChallengeInscription(ligne);
                                          setState(() {
                                            getDataChallengeEnCours();
                                          });
                                        }
                                        else{
                                          Fluttertoast.showToast(msg: "Le code est incorrect");
                                        }
                                      }
                                    },
                                    child: Text("S\'inscrire"),
                                    textColor: Colors.white,
                                  ),
                                ),
                              ),
                            ]
                          ),
                        )
                      )
                    );
              }
            }
            else{
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF375E7E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context,
                          '/Inscription'
                      );
                    },
                    child: Text("Créer un compte"),
                    textColor: Colors.white,
                  ),
              );

            }
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

  afficheBoutonAncienChallenge(ligne){
    return FutureBuilder(
      future: getDataAncienChallenge(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasError){
            return Center(
              child: Text("ERROR fetching data"),
            );
          }
          List snap = snapshot.data;
          return MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ClassementAncien',
                arguments: [ligne['id_defi_marche'], id],
              );
            },
            textColor: Colors.white,
            child: Text("${ligne['nom_defi_marche']}"),
          );

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

  afficheDateAncien(date){
    var dateFormat = date.split('-');
    return Text(
      "Fini le ${dateFormat[2]}/${dateFormat[1]}/${dateFormat[0]}",
      style: TextStyle(fontSize: 15),
    );
  }


  afficheAncienChallenges(){
    return FutureBuilder(
      future: getVerifAncienChallenge(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR fetching data"),
            );
          }
          List verif = snapshot.data;
          if (verif[0]['count'] != "0") {
            return FutureBuilder(
              future: getDataAncienChallenge(),
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
                                "Dernier challenge",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF375E7E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: afficheBoutonAncienChallenge(snap[0]),
                      ),
                      Container(
                        child: afficheDateAncien(snap[0]['date_fin_marche']),
                      ),
                    ]
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
              children: [
                Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dernier challenge",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    // Container(
                    //   child: afficheInscription(snap[0]),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
            child: Align(
            alignment: Alignment.center,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
        "Pas de challenges terminés "),
        ]
        ),


        ),
        )

    ]
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



}
