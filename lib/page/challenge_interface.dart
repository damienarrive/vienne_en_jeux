import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:searchfield/searchfield.dart';
import 'package:vienne_en_jeux/widget/connexion_button_widget.dart';
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
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataChallengeInterface.php?iddefi=$iddefi&iduser=$iduser";
    // String theUrl = "http://192.168.1.190/myApp/getDataChallengeInterface.php?iddefi=$iddefi&iduser=$iduser";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataChallengeInterfaceEquipe(iddefi, iduser)async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataChallengeInterface_Equipe.php?iddefi=$iddefi&iduser=$iduser";
    // String theUrl = "http://192.168.1.190/myApp/getDataChallengeInterface_Equipe.php?iddefi=$iddefi&iduser=$iduser";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataNbParticipants(iddefi)async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataNbParticipants.php?iddefi=$iddefi";
    // String theUrl = "http://192.168.1.190/myApp/getDataNbParticipants.php?iddefi=$iddefi";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

class _ChallengeInterfaceState extends State<ChallengeInterface> {
  String searchValue = '';
  final _formKey = GlobalKey<FormState>();
  final _formNom = GlobalKey<FormState>();

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nomEquipe = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as List;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Challenge Interface'),
        elevation: 0,
          actions : <Widget>[
            ConnexionButtonWidget(),
          ]
      ),
      body: SingleChildScrollView(
      child : Column(
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //BOUTON RETOUR
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
                        icon: const Icon(Icons.arrow_back),
                        color: const Color(0xFF375E7E),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.white70,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(
                          Icons.question_mark, size: 30),
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
            ],
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(
                            width : 300,
                            child : rechercheJoueur(snap[0], args[0], args[1]),
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

                          //BOUTON AIDE
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.all(10.0),
                            child: Material(
                              color: const Color(0xFF375E7E),
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
                                      getDataChallengeInterface(
                                          args[0], args[1]);
                                    });
                                  },
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
                          //BOUTON Bonus
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.all(10.0),
                            child: Material(
                              color: const Color(0xFF375E7E),
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
                        ],
                      ),
                      FractionallySizedBox(
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
                              Align(
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
                            ],
                          ),
                        ),
                      ),

                      FractionallySizedBox(
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: affichagePoint(
                                    snap[0], args[0], args[1]),
                              ),
                            ],
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
      ),
    );
  }



  affichagePoint(ligne, iddefi, iduser) {
    if (ligne['id_equipe_marche'] != null) {
      return FutureBuilder(
        future: getDataChallengeInterfaceEquipe(iddefi, iduser),
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
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment
            .start,
        children: [
          Container(
            margin: const EdgeInsets.all(7.0),
            child: const Text(
              "VOUS N'ÊTES INSCRIT DANS AUCUNE ÉQUIPE !",
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

  afficheDate(ligne) {
    var valDateDeb = ligne['date_debut_marche'].split('-');
    var valDateFin = ligne['date_fin_marche'].split('-');
    return Text(
      "Du ${valDateDeb[2]}/${valDateDeb[1]}/${valDateDeb[0]} au ${valDateFin[2]}/${valDateFin[1]}/${valDateFin[0]} inclus.",
    );
  }


  getDataEquipe(idequipe) async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataEquipe.php?idequipe=$idequipe";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataSearch(iddefi, iduser) async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataSearch.php?iddefi=$iddefi&iduser=$iduser";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  addTeammate(idequipe, login, iduser, iddefi) async{
    idequipe = idequipe.toString();
    print(login);
    print(iduser);
    print(iddefi);
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/addTeammates.php";
    var res = await http.post(Uri.parse(theUrl),headers: {"Accept":"application/json"}, body: {
      "idequipe" : idequipe,
      "iduser": iduser,
      "iddefi": iddefi,
      "login": login
    });
    try{
      var responseBody = json.decode(res.body);
      if(responseBody['message'] == 'Success'){
        setState(() {
          getDataChallengeInterface(iddefi, iduser);
        });
      }
      print(responseBody);
    }
    catch(e){
      print(e);
    }

  }

  modifNomEquipe(idequipe, nomequipe) async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/setNomEquipe.php?idequipe=$idequipe&nomequipe=$nomequipe";
    await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
  }

  rechercheJoueur(ligne, iddefi, iduser) {
    return FutureBuilder(
        future : getDataEquipe(ligne['id_equipe_marche']),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR fetching data"),
              );
            }
            List infoEquipe = snapshot.data;
            //Si on a une équipe mais complète
            if (ligne['id_equipe_marche'] != null && int.parse(infoEquipe[0]['nbEquipier']) >= int.parse(ligne['taille_max'])) {
              return FutureBuilder(
                future: getDataChallengeInterfaceEquipe(iddefi, iduser),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
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
                      child: Column(
                        children: [
                          Row(
                          children: [
                              IconButton(
                                  color: Colors.blue,
                                  onPressed: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: const Text('Modification du nom d\'équipe'),
                                            content: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Form(
                                                key: _formNom,
                                                child: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      controller : _nomEquipe,
                                                      decoration: InputDecoration(
                                                        labelText: 'Nouveau nom',
                                                      ),
                                                      validator: (value){
                                                        if(value == null || value.isEmpty){
                                                          return "Veuillez entrer un nom";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: const Color(0xFF375E7E),
                                                      ),
                                                      child: Text("Modifier",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        if(_formNom.currentState!.validate()) {
                                                          modifNomEquipe(ligne['id_equipe_marche'], _nomEquipe.text);
                                                          Navigator.pop(context);
                                                          setState(() {
                                                            getDataChallengeInterfaceEquipe(iddefi, iduser);
                                                          });
                                                        }
                                                      })
                                                ],
                                              )

                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.edit)
                              ),
                              const Text(
                                "Equipe :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${snap[0]['nom_equipe']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ],
                          )

                        ],
                      ),

                    );
                  }
                  else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }
            else {
              return FutureBuilder(
                future: getDataSearch(iddefi, iduser),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("ERROR fetching data"),
                      );
                    }
                    List resultSearch = snapshot.data;
                    List<String> str = resultSearch.map((e) => e.toString()).toList();
                    return Form(
                        key: _formKey,
                        child: Row(
                          children : [
                            Container(
                              width: 170,
                              decoration : const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                              ),
                              child : SearchField(
                              controller: _searchController,
                              suggestions: str
                                  .map((e) => SearchFieldListItem(e))
                                  .toList(),
                              suggestionState: Suggestion.expand,
                              textInputAction: TextInputAction.next,
                              hint: 'Chercher un joueur',
                              searchStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              validator: (value) {
                                if (!str.contains(value) || value!.isEmpty) {
                                  return 'Le nom doit etre complet';
                                }
                                return null;
                              },
                              suggestionsDecoration: SuggestionDecoration(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                              ),
                              searchInputDecoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                ),
                              ),
                              maxSuggestionsInViewPort: 6,
                              itemHeight: 40,
                              // onTap: (x) {},
                            ),
                            ),
                            Container(
                              width: 80,
                              height: 60,
                              decoration : BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                              ),
                              child :ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                                      )
                                ),
                                onPressed: () {
                                  //TODO fonction addTeammates()
                                  if(_formKey.currentState!.validate()){
                                    if(_searchController.text != "null"){
                                      addTeammate(ligne['id_equipe_marche'], _searchController.text, iduser, iddefi);
                                    }
                                  }
                                  else{
                                    Fluttertoast.showToast(msg: "Veuillez remplir tous les champs correctement");
                                  }
                                },
                                child: Text('Ajouter')
                              ),
                            ),

                        ]
                        )
                    );
                  }
                  else {
                    return Text('Votre équipe est complète');
                  }
                }
                );
            }
          }
          else {
            return Text('Equipe complète');
          }
        }
        );
  }
}
