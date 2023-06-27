import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vienne_en_jeux/widget/connexion_button_widget.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Classement extends StatefulWidget {
  const Classement({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ClassementState createState() => _ClassementState();
}

class _ClassementState extends State<Classement> {

  getDataClassement(iddefi)async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataClassement.php?iddefi=$iddefi";
    // String theUrl = "http://192.168.1.190/myApp/getDataClassement.php?iddefi=$iddefi";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataMonClassement(iduser, iddefi)async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataMonClassement.php?iduser=$iduser&iddefi=$iddefi";
    // String theUrl = "http://192.168.1.190/myApp/getDataMonClassement.php?iduser=$iduser&iddefi=$iddefi";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  //pour vérifier si utilisateur dans équipe
  getDataChallengeInterface(iddefi, iduser)async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataChallengeInterface.php?iddefi=$iddefi&iduser=$iduser";
    // String theUrl = "http://192.168.1.190/myApp/getDataChallengeInterface.php?iddefi=$iddefi&iduser=$iduser";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Classement'),
        elevation: 0,
          actions : <Widget>[
            ConnexionButtonWidget(),
          ]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.all(10.0),
            child: Material(
              color: const Color(0xFF375E7E),
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



        Expanded(
            child: FutureBuilder(
            future: getDataClassement(args[0]),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError){
                  return Center(
                    child: Text("ERROR fetching data"),
                  );
                }
                List snap = snapshot.data;
                return Container(
                      margin: const EdgeInsets.all(10.10),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                    );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),

          FutureBuilder(
            future: getDataMonClassement(args[1], args[0]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR fetching data"),
                  );
                }
                List snap = snapshot.data;
                if(snap.isNotEmpty) {
                  return Align(
                    alignment: Alignment.bottomCenter,

                    child: Container(
                      margin: const EdgeInsets.all(10.10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.10),
                            child: const Text("Mon équipe",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              SizedBox(
                                width: 35,
                                child: Text(
                                    "${snap[0]['classement']}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true),
                              ),
                               SizedBox(
                                  width: 80,
                                  child: Text(
                                      "${snap[0]['nom_equipe']}",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true),
                               ),

                              SizedBox(
                                width: 35,
                                child: Text(
                                    "${snap[0]['score_equipe']}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
                else{
                  return Container(
                    margin: const EdgeInsets.all(10.10),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Vous n'avez pas d'équipe",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },

          )
        ],
      ),
    );
  }


  List<DataColumn> _createColumns(){
    return [
      const DataColumn(label: Text(
          'Rang', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      )),
      const DataColumn(label: Expanded(
          child : Text(
          'Nom', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      ))),
      const DataColumn(label: Text(
          'Score', textAlign: TextAlign.center,
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
              width: 35,
              child: Text("${snap[i]['classement']}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true),
            ),
          ),
          DataCell(
              SizedBox(
                width: 80,
                child: Text("${snap[i]['nom_equipe']}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true),
              ),
          ),
          DataCell(
              SizedBox(
                width: 35,
                child: Text("${snap[i]['score_equipe']}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true),
              ),
          ),
        ]);
        ligneTab.add(ligne);
      }
      return ligneTab;
  }


}