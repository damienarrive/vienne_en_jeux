import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:vienne_en_jeux/page/challenge_interface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class Classement extends StatefulWidget {
  const Classement({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ClassementState createState() => _ClassementState();
}

class _ClassementState extends State<Classement> {

  getData()async{
    String theUrl = "http://172.20.10.7/my-app/getData.php";
    //String theUrl = "http://localhost/my-app/getData.php";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            margin: const EdgeInsets.all(10.10),
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child:
                    const Text(
                      "Rank       ",
                      textAlign: TextAlign.center,
                    ),
                ),
                Container(
                  child:
                    const Text(
                    "Nom     ",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child:
                    const Text(
                    "Score       ",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError){
                  return Center(
                    child: Text("ERROR fetching data"),
                  );
                }
                List snap = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,

                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child:
                            Text("${snap[index]['id_athlete']}", textAlign: TextAlign.center),
                          ),
                          Container(
                            child:
                            Text("${snap[index]['prenom_athlete']}", textAlign: TextAlign.center),
                          ),
                        ],
                      );
                    },
                );

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

}