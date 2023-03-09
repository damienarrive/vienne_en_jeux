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
    String theUrl = "http://172.20.10.7/my-app/getDataBonusPalier.php?iduser=$iduser&iddefi=$iddefi";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  setDataRecupBonusPalier(ligne, iddefi, iduser)async{
    String theUrl = "http://172.20.10.7/my-app/setDataRecupBonus.php?true=true&iddefi=$iddefi&iduser=$iduser&idbonus=${ligne['id_bonus_marche']}";
    await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
  }

  getDataBonusConnexion(iddefi, iduser)async{
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String formattedDate = date.toString().replaceAll("00:00:00.000", "");
    String theUrl = "http://172.20.10.7/my-app/getDataBonusConnexion.php?iduser=$iduser&iddefi=$iddefi&date='$formattedDate'";
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  setDataRecupBonusConnexion(ligne, iddefi, iduser)async{
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String formattedDate = date.toString().replaceAll("00:00:00.000", "");
    String theUrl = "http://172.20.10.7/my-app/setDataRecupBonusConnexion.php?val=1&iddefi=$iddefi&iduser=$iduser&date='$formattedDate'";
    await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Bonus'),
        elevation: 0,
      ),
      body: Column(
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
                  image: AssetImage('images/banniere_avec_logos.png'),
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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: leBonus(snap[0], false, args[0], args[1]),
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

          Expanded(
            child: FutureBuilder(
              future: getDataBonusPalier(args[0], args[1]),
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
                      itemBuilder: (context,index){
                        return Container(
                          margin: const EdgeInsets.all(10.10),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: leBonus(snap[index], true, args[0], args[1]),
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
          ),
        ],
      ),
    );
  }

  leBonus(ligne, palier, iddefi, iduser) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: afficheBonus(ligne, palier, iddefi, iduser),
      ),
    );
  }

  afficheBonus(ligne, palier, iddefi, iduser){
    if(palier){
      return [
        Text(
          "Fais ${ligne['palier_pas']} pas",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          "Nombre de pas : ${ligne['nbre_pas']}/${ligne['palier_pas']}",
          textAlign: TextAlign.center,
        ),
        GFProgressBar(
          percentage: progressPercentage(ligne),
          padding: const EdgeInsets.all(7.0),
          radius: 100,
          backgroundColor: Colors.grey,
          progressBarColor: Color(0xFF375E7E),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: boutonRecuperer(ligne, palier, iddefi, iduser),
        ),
      ];
    }
    else{
      return [
        Text(
          "Connecte toi",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

        Text(
          "Connexion : ${ligne['recupere']}/1",
          textAlign: TextAlign.center,
        ),

        GFProgressBar(
          percentage: double.parse(ligne['recupere']),
          padding: const EdgeInsets.all(7.0),
          radius: 100,
          backgroundColor : Colors.grey,
          progressBarColor: Color(0xFF375E7E),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: boutonRecuperer(ligne, palier, iddefi, iduser),
        ),
      ];
    }
  }

  progressPercentage(ligne){
    var nbPas = double.parse(ligne['nbre_pas'] + '.0');
    var palierPas = double.parse(ligne['palier_pas'] + '.0');
    if(nbPas<palierPas){
      return nbPas/palierPas;
    }
    else{
      return 1.0;
    }
  }

  boutonRecuperer(ligne, palier, iddefi, iduser) {
    if (palier) {
      var nbPas = int.parse(ligne['nbre_pas']);
      var palierPas = int.parse(ligne['palier_pas']);
      if (ligne['recupere'] == '0' && nbPas >= palierPas) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF375E7E), // Background color
            foregroundColor: Colors.white, // Text Color (Foreground color)
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialog(context, ligne, palier, iddefi, iduser),
            );
          },
          child: const Text('Récupérer'),
        );
      }
      else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF375E7E), // Background color
            foregroundColor: Colors.white, // Text Color (Foreground color)
          ),
          onPressed: null,
          child: const Text('Récupérer'),
        );
      }
    }
    else{
      if (ligne['recupere'] == '0') {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF375E7E), // Background color
            foregroundColor: Colors.white, // Text Color (Foreground color)
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialog(context, ligne, palier, iddefi, iduser),
            );
          },
          child: const Text('Récupérer'),
        );
      }
      else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF375E7E), // Background color
            foregroundColor: Colors.white, // Text Color (Foreground color)
          ),
          onPressed: null,
          child: const Text('Récupéré'),
        );
      }
    }
  }

  Widget _buildPopupDialog(BuildContext context, ligne, palier, iddefi, iduser) {
    return AlertDialog(
      title: const Text('Succès !'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Le bonus a bien été récupéré."),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF375E7E), // Background color
            foregroundColor: Colors.white, // Text Color (Foreground color)
          ),
          onPressed: () {
            Navigator.of(context).pop();
            if(palier){
              setDataRecupBonusPalier(ligne, iddefi, iduser);
              setState(() {
                getDataBonusPalier(iddefi, iduser);
              });
            }
            else{
              setDataRecupBonusConnexion(ligne, iddefi, iduser);
              setState(() {
                getDataBonusConnexion(iddefi, iduser);
              });
            }
          },
          child: const Text('Récupérer'),
        ),
      ],
    );
  }

}
