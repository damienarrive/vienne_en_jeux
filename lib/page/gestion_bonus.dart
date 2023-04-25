import 'dart:convert' as JSON;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../widget/navigation_drawer_widget.dart';

class GestionBonus extends StatefulWidget {
  const GestionBonus({super.key});
  @override
  _GestionBonusState createState() => _GestionBonusState();
}

class _GestionBonusState extends State<GestionBonus> {

  final _formAddPalier = GlobalKey<FormState>();
  final _formConnexion = GlobalKey<FormState>();
  final _formModifPalier = GlobalKey<FormState>();

  TextEditingController palierBonus = TextEditingController();
  TextEditingController nbBonus = TextEditingController();
  TextEditingController points = TextEditingController();
  TextEditingController pointsPalier = TextEditingController();
  TextEditingController pointsBonus = TextEditingController();


  getBonusConnexion() async{
    String theUrl = "http://192.168.1.190/myApp/getBonusConnexion.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = JSON.jsonDecode(res.body);
    return responseBody;
  }

  getBonusPalier() async{
    String theUrl = "http://192.168.1.190/myApp/getBonusPalier.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = JSON.jsonDecode(res.body);
    return responseBody;
  }

  addBonusPalier() async{
    String theUrl = "http://192.168.1.190/myApp/addBonusPalier.php";
    var res = await http.post(Uri.parse(theUrl), body: {
      "palier_pas": palierBonus.text,
      "bonus": nbBonus.text,
    });
    try {
      var data = JSON.jsonDecode(JSON.jsonEncode(res.body));
      print(data);
    }
    catch(e){
      print(e);
    }
  }

  setBonusConnexion() async{
    String theUrl = "http://192.168.1.190/myApp/setBonusConnexion.php";
    await http.post(Uri.parse(theUrl), body: {
      "bonus": points.text,
    });
  }

  setBonusPalier(id) async{
    String theUrl = "http://192.168.1.190/myApp/setBonusPalier.php";
    var res = await http.post(Uri.parse(theUrl), body: {
      "id_bonus": id.toString(),
      "palier": pointsPalier.text,
      "bonus": pointsBonus.text,
    });
    try {
      var data = JSON.jsonDecode(JSON.jsonEncode(res.body));
      print(data);

    }// end try
    catch(e){
      print(e);
    }
  }

  deleteBonus(idbonus) async{
    String theUrl = "http://192.168.1.190/myApp/deleteBonus.php?idbonus=$idbonus";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    try {
      var data = JSON.jsonDecode(res.body);
      print(data);
      Fluttertoast.showToast(msg: "${data['reason']}");
    }
    catch(e){
      print(e);
    }
  }

  bonusConnexion(){
    return FutureBuilder(
      future: getBonusConnexion(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("ERROR fetching data"),
            );
          }
          var bonusCo = snapshot.data;
          return Column(
            children: [
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
                        Text('Bonus de connexion', textScaleFactor: 1.5),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1.0, color: Colors.black))
                      ),
                      child: Text("Nombre de points reçus : ${bonusCo[0]['bonus']}", textScaleFactor: 1.2),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF375E7E),
                      ),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: const Text('Modification du bonus de connexion'),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _formConnexion,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: points,
                                          decoration: InputDecoration(
                                            labelText: 'Nombre de points',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              return "Veuillez entrer une valeur";
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
                                            if(_formConnexion.currentState!.validate()){
                                              setBonusConnexion();
                                              //TODO modif des bonus récupérable par les utilisateurs du challenge en cours
                                              Navigator.pop(context);
                                              setState(() {
                                                getBonusConnexion();
                                              });
                                            }
                                          })
                                    ],
                                  )

                                ],
                              );
                            });
                      },
                      child: Text(
                        'Modifier',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return Container();
      }
    );
  }

  bonusPalier(){
    return FutureBuilder(
        future: getBonusPalier(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF375E7E),
                            ),
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: const Text(
                                        'Modification d\'un bonus de palier'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        key: _formModifPalier,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              controller: pointsPalier,
                                              decoration: InputDecoration(
                                                labelText: 'Palier',
                                              ),
                                              keyboardType: TextInputType
                                                  .number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value){
                                                if(value == null || value.isEmpty){
                                                  return "Veuillez entrer une valeur";
                                                }
                                                return null;
                                              },
                                            ),
                                            TextFormField(
                                              controller: pointsBonus,
                                              decoration: InputDecoration(
                                                labelText: 'Bonus',
                                              ),
                                              keyboardType: TextInputType
                                                  .number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value){
                                                if(value == null || value.isEmpty){
                                                  return "Veuillez entrer une valeur";
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
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                    0xFF375E7E),
                                              ),
                                              child: Text("Modifier",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                if (_formModifPalier.currentState!.validate()) {
                                                  setBonusPalier(item['id_bonus']);
                                                  //TODO modif des bonus récupérable par les utilisateurs du challenge en cours
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    getBonusPalier();
                                                  });
                                                }
                                              })
                                        ],
                                      )

                                    ],
                                  );
                                });
                            },
                            child: const Text(
                              'Modifier',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF375E7E),
                              ),
                              onPressed: (){
                                deleteBonus(item['id_bonus']);
                                setState(() {
                                  getBonusPalier();
                                });
                              },
                              child: const Text(
                                'Supprimer',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ).toList(),
            );
          }
          return Container();
        }
        );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Gestion Bonus'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child : Column(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF375E7E),
                            ),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label : const Text(
                              'Créer un bonus de palier',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: const Text('Nouveau bonus de palier'),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                          key: _formAddPalier,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                controller : palierBonus,
                                                decoration: InputDecoration(
                                                  labelText: 'Palier',
                                                ),
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                validator: (value){
                                                  if(value == null || value.isEmpty){
                                                    return "Veuillez entrer une valeur";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: nbBonus,
                                                decoration: InputDecoration(
                                                  labelText: 'Bonus',
                                                ),
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                validator: (value){
                                                  if(value == null || value.isEmpty){
                                                    return "Veuillez entrer une valeur";
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
                                                child: Text("Ajouter",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  if(_formAddPalier.currentState!.validate()) {
                                                    addBonusPalier();
                                                    //TODO modif des bonus récupérable par les utilisateurs du challenge en cours
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      getBonusPalier();
                                                    });
                                                  }
                                                })
                                          ],
                                        )

                                      ],
                                    );
                                  });
                            },
                          ),
                        ],
                      )
                  ),
                ),
                bonusConnexion(),
                bonusPalier(),
              ]
          ),
          // child: listChallenges(),
        )
    );
  }
}