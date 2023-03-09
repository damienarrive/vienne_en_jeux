import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ChallengeParticipants extends StatefulWidget {
  const ChallengeParticipants({super.key});

  @override
  _ChallengeParticipantsState createState() => _ChallengeParticipantsState();
}

  getDataNbParticipants(iddefi)async{
    String theUrl = "http://172.20.10.7/my-app/getDataNbParticipants.php?iddefi=$iddefi";
    //String theUrl = "http://localhost/my-app/getData.php";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataNomEquipe(idequipe)async{
    String theUrl = "http://172.20.10.7/my-app/getDataNomEquipe.php?idequipe=$idequipe";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

class _ChallengeParticipantsState extends State<ChallengeParticipants> {
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as List;

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
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ),

          //Audit M2
        FutureBuilder(
          future: getDataNbParticipants(args[0]),
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
                        Container(
                          child : Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snap[0]['nom_defi_marche']}",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "Nombre d'utilisateurs : ${snap[0]['tot']}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "Nombre d'utilisateurs en équipe : ${snap[0]['eq']}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),

                  Container(
                      child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10.10),
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ListView(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        children: [
                                          DataTable(columns: _createColumns(), rows: _createRows(snap))
                                        ],
                                      ),
                                    ),
                                  ]
                              )
                          )
                      )
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
        ),
        ]
      )
    );
  }

  List<DataColumn> _createColumns(){
    return [
      DataColumn(label: Text(
          'Participant', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      )),
      DataColumn(label: Text(
          'Equipe', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      )),
    ];
  }

  List<DataRow> _createRows(snap){
    List<DataRow> ligneTab = [];
    for(var i=0; i<snap.length; i++) {
      var ligne = DataRow(cells: [
        DataCell(
          SizedBox(
            width: 100,
            child: Text("${snap[i]['login_user']}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: afficheEquipe(snap[i]['id_equipe_marche']),
          ),
        ),
      ]);
      ligneTab.add(ligne);
    }
    return ligneTab;
  }

  afficheEquipe(idequipe){
    if(idequipe.length > 0) {
      return FutureBuilder(
        future: getDataNomEquipe(idequipe),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR fetching data"),
              );
            }
            List snap = snapshot.data;
            return Center(
              child: Text("${snap[0]['nom_equipe']}"),
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
      return Text("Aucune équie", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true);
    }
  }

}
