import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

  getDataClassement()async{
    String theUrl = "http://192.168.1.230/myApp/getDataClassement.php";
    //String theUrl = "http://192.168.1.230/my-app/getData.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  getDataMonClassement(iduser)async{
    String theUrl = "http://192.168.1.230/myApp/getDataMonClassement.php?id=$iduser";
    //String theUrl = "http://192.168.1.230/my-app/getData.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  //pour vérifier si utilisateur dans équipe
  getDataChallengeInterface(iddefi, iduser)async{
    String theUrl = "http://192.168.1.230/myApp/getDataChallengeInterface.php?iddefi=$iddefi&iduser=$iduser";
    //String theUrl = "http://192.168.1.230/my-app/getData.php";
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Container(
            margin: const EdgeInsets.all(10.10),
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Ce classement est mis à jour toutes les heures                                 ",
              textAlign: TextAlign.center,
            ),
          ),



          Expanded(
            child: FutureBuilder(
              future: getDataClassement(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.hasError){
                    print(snapshot.data);
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
            future: getDataChallengeInterface(args[0], args[1]),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError){
                  return Center(
                    child: Text("ERROR fetching data"),
                  );
                }
                List verif = snapshot.data;
                if(verif[0]['id_equipe_marche'] != 0) {
                  return FutureBuilder(
                    future: getDataMonClassement(args[1]),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasError){
                          return Center(
                            child: Text("ERROR fetching data"),
                          );
                        }
                        List snap = snapshot.data;
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.all(10.10),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10.10),
                                  child: const Text("Mon équipe", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text("${snap[0]['classement']}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true),
                                    ),

                                    SizedBox(
                                      width: 80,
                                      child: Text("${snap[0]['nom_equipe']}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: Text("${snap[0]['score_equipe']}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
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
                else{
                  return Container();
                }
              }
              else{
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

  List<DataColumn> _createColumns(){
    return [
      DataColumn(label: Text(
          'Rang', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      )),
      DataColumn(label: Text(
          'Nom', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      )),
      DataColumn(label: Text(
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
            width: 50,
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
            width: 50,
            child: Text("${snap[i]['score_equipe']}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true),
          ),
        ),
      ]);
      ligneTab.add(ligne);
    }
    return ligneTab;
  }


}