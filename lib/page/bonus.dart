import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bonus extends StatefulWidget {
  const Bonus({super.key});

  @override
  _BonusState createState() => _BonusState();
}

class _BonusState extends State<Bonus> {

  getDataBonusPalier(iddefi, iduser)async{
    // String theUrl = "http://192.168.1.190/myApp/getDataBonusPalier.php?iduser=$iduser&iddefi=$iddefi";
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataBonusPalier.php?iduser=$iduser&iddefi=$iddefi";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  setDataRecupBonusPalier(idbonus, iddefi, iduser)async{
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/setDataRecupBonus.php?true=true&iddefi=$iddefi&iduser=$iduser&idbonus=$idbonus}";
    // String theUrl = "http://192.168.1.190/myApp/setDataRecupBonus.php?true=true&iddefi=$iddefi&iduser=$iduser&idbonus=${ligne['id_bonus_marche']}";
    await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
  }

  getDataBonusConnexion(iddefi, iduser)async{
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String formattedDate = date.toString().replaceAll("00:00:00.000", "");
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/getDataBonusConnexion.php?iduser=$iduser&iddefi=$iddefi&date='$formattedDate'";
    // String theUrl = "http://192.168.1.190/myApp/getDataBonusConnexion.php?iduser=$iduser&iddefi=$iddefi&date='$formattedDate'";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  setDataRecupBonusConnexion(iddefi, iduser)async{
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String formattedDate = date.toString().replaceAll("00:00:00.000", "");
    String theUrl = "http://dev.vienneenjeux.fr/PHP_files/setDataRecupBonusConnexion.php?val=1&iddefi=$iddefi&iduser=$iduser&date='$formattedDate'";
    // String theUrl = "http://192.168.1.190/myApp/setDataRecupBonusConnexion.php?val=1&iddefi=$iddefi&iduser=$iduser&date='$formattedDate'";
    await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Bonus'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
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
            //BOUTON RETOUR
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

            FutureBuilder(
              future: getDataBonusConnexion(args[0], args[1]),
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
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // child: leBonus(snap[0], false, args[0], args[1]),
                    child: Column(
                      children: [
                        Text("Bonus de connexion", textScaleFactor: 1.8,),
                        if(snap[0]['recupere'] == '0')...[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xFF375E7E),
                            ),
                            onPressed: () {
                              setDataRecupBonusConnexion(args[0], args[1]);
                              setState(() {
                                getDataBonusConnexion(args[0], args[1]);
                              });
                            },
                            child: const Text(
                              'Récupérer',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ]else...[
                          Container(
                            padding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF375E7E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text("Bonus récupéré", style: TextStyle(color: Colors.white )),
                          )
                        ]
                      ],
                    )
                  );
                }
                else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),

            FutureBuilder(
                future: getDataBonusPalier(args[0], args[1]),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text("ERROR fetching data"),
                      );
                    }
                    List listBonus = snapshot.data;
                    return Column(
                      children: listBonus.map((item) =>
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
                              children: [
                                Text('Bonus de palier', textScaleFactor: 1.5),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.black))
                              ),
                              child: Text("Palier à atteindre : ${item['palier_pas']}", textScaleFactor: 1.2),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.black))
                              ),
                              child: Text("Nombre de points reçus : ${item['bonus']}", textScaleFactor: 1.2),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if(item['recupere'] == '0')...[
                                  if(int.parse(item['nbre_pas']) >= int.parse(item['palier_pas']))...[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                              0xFF375E7E),
                                        ),
                                        onPressed: () {
                                          setDataRecupBonusPalier(item['id_bonus'], args[0], args[1]);
                                        },
                                        child: const Text(
                                          'Récupérer',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                  ]else...[
                                    Container(
                                      padding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: const Color(0xFF375E7E)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text("Palier non atteint", style: TextStyle(backgroundColor:  Colors.white, color: const Color(0xFF375E7E) )),
                                    )
                                  ]
                                ]else...[
                                  Container(
                                    padding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF375E7E),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text("Bonus récupéré", style: TextStyle(color: Colors.white )),
                                  )
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                      ).toList(),
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
      ),
    );
  }

  // leBonus(ligne, palier, iddefi, iduser) {
  //   return Container(
  //     margin: const EdgeInsets.all(0.0),
  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Column(
  //       children: afficheBonus(ligne, palier, iddefi, iduser),
  //     ),
  //   );
  // }

  // afficheBonus(ligne, palier, iddefi, iduser){
  //     return [
  //       Text(
  //         "Connecte toi",
  //         textAlign: TextAlign.left,
  //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  //       ),
  //
  //       Text(
  //         "Connexion : ${ligne['recupere']}/1",
  //         textAlign: TextAlign.center,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 10.0),
  //         child: boutonRecuperer(ligne, palier, iddefi, iduser),
  //       ),
  //     ];
  // }

  // boutonRecuperer(ligne, palier, iddefi, iduser) {
  //   if (palier) {
  //     var nbPas = int.parse(ligne['nbre_pas']);
  //     var palierPas = int.parse(ligne['palier_pas']);
  //     if (ligne['recupere'] == '0' && nbPas >= palierPas) {
  //       return ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Color(0xFF375E7E), // Background color
  //           foregroundColor: Colors.white, // Text Color (Foreground color)
  //         ),
  //         onPressed: () {
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) =>
  //                 _buildPopupDialog(context, ligne, palier, iddefi, iduser),
  //           );
  //         },
  //         child: const Text('Récupérer'),
  //       );
  //     }
  //     else {
  //       return ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Color(0xFF375E7E), // Background color
  //           foregroundColor: Colors.white, // Text Color (Foreground color)
  //         ),
  //         onPressed: null,
  //         child: const Text('Récupérer'),
  //       );
  //     }
  //   }
  //   else{
  //     if (ligne['recupere'] == '0') {
  //       return ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Color(0xFF375E7E), // Background color
  //           foregroundColor: Colors.white, // Text Color (Foreground color)
  //         ),
  //         onPressed: () {
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) =>
  //                 _buildPopupDialog(context, ligne, palier, iddefi, iduser),
  //           );
  //         },
  //         child: const Text('Récupérer'),
  //       );
  //     }
  //     else {
  //       return ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Color(0xFF375E7E), // Background color
  //           foregroundColor: Colors.white, // Text Color (Foreground color)
  //         ),
  //         onPressed: null,
  //         child: const Text('Récupéré'),
  //       );
  //     }
  //   }
  // }
  //
  // Widget _buildPopupDialog(BuildContext context, ligne, palier, iddefi, iduser) {
  //   return AlertDialog(
  //     title: const Text('Succès !'),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: const [
  //         Text("Le bonus a bien été récupéré."),
  //       ],
  //     ),
  //     actions: <Widget>[
  //       ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Color(0xFF375E7E), // Background color
  //           foregroundColor: Colors.white, // Text Color (Foreground color)
  //         ),
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //           if(palier){
  //             setDataRecupBonusPalier(ligne, iddefi, iduser);
  //             setState(() {
  //               getDataBonusPalier(iddefi, iduser);
  //             });
  //           }
  //           else{
  //             setDataRecupBonusConnexion(ligne, iddefi, iduser);
  //             setState(() {
  //               getDataBonusConnexion(iddefi, iduser);
  //             });
  //           }
  //         },
  //         child: const Text('Récupérer'),
  //       ),
  //     ],
  //   );
  // }

}
