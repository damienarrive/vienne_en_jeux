import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  NavigationDrawerWidget({super.key});

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}


class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  var session = SessionManager();
  String id = "";
  String nom = "";
  String prenom = "";
  String role="";
  @override
  void initState(){
    super.initState();
    _getSession();
  }

  _getSession() async{
    dynamic idUser = await session.get('userId');
    dynamic nomUser = await session.get('nom');
    dynamic prenomUser = await session.get('prenom');
    dynamic roleUser = await session.get('type_user');
    setState(() {
      id = idUser.toString();
      nom = nomUser.toString();
      prenom = prenomUser.toString();
      role = roleUser.toString();
    });
    // print(id.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 64.0,
              child: DrawerHeader(
                child: Text('Menu'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.house, color: Colors.black),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pushNamed(context, '/');
                //Corriger plus tard : peut-etre problemes pour fermer la page précédente ?
              },
            ),
            challenge(),
            deconnexion(),
            ExpansionTile(
              textColor: Colors.black,
              childrenPadding: const EdgeInsets.only(left: 30),
              title: Text("Informations légales"),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("Conditions d'utilisation"),
                  onTap: () {
                    Navigator.pushNamed(context, '/CGU');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("Politique de confidentialité"),
                  onTap: () {
                    Navigator.pushNamed(context, '/PolitiqueConf');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("Mentions légales"),
                  onTap: () {
                    Navigator.pushNamed(context, '/MentionsLegales');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  deconnexion(){
    return FutureBuilder(
        future: _getSession(),
        builder: (context, snapshot){
            if(id != "null"){
              return ExpansionTile(
                textColor: Colors.black,
                childrenPadding: EdgeInsets.only(left: 30),
                title: Text("Deconnexion"),
                children: <Widget>[
                  ListTile(
                    leading:
                    const Icon(Icons.directions_run, color: Colors.black),
                    title: const Text('Deconnexion'),
                    onTap: () {
                      session.destroy();
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ],
              );
            }
            else{
              return ExpansionTile(
                textColor: Colors.black,
                childrenPadding: EdgeInsets.only(left: 30),
                title: Text("Connexion"),
                children: <Widget>[
                  ListTile(
                    leading:
                    const Icon(Icons.directions_run, color: Colors.black),
                    title: const Text('Connexion'),
                    onTap: () {
                      Navigator.pushNamed(context, '/Connexion');
                    },
                  ),
                  ListTile(
                    leading:
                    const Icon(Icons.directions_run, color: Colors.black),
                    title: const Text('Inscription'),
                    onTap: () {
                      Navigator.pushNamed(context, '/Inscription');
                    },
                  ),
                ],
              );
            }
        }
    );
  }

  challenge() {
    return FutureBuilder(
        future: _getSession(),
        builder: (context, snapshot) {
          if (id != "null" && role == '4') {
            return ExpansionTile(
              textColor: Colors.black,
              childrenPadding: EdgeInsets.only(left: 30),
              title: Text("Challenges"),
              children: <Widget>[
                ListTile(
                  leading:
                  const Icon(Icons.directions_run, color: Colors.black),
                  title: const Text('Challenge de marche'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Challenges');
                  },
                ),
                ListTile(
                  leading:
                  const Icon(Icons.directions_run, color: Colors.black),
                  title: const Text('Gestion des challenges'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Gestion_Challenge');
                  },
                ),
                ListTile(
                  leading:
                  const Icon(Icons.directions_run, color: Colors.black),
                  title: const Text('Gestion des bonus'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Gestion_Bonus');
                  },
                ),
              ],
            );
          }
          else{
            return ExpansionTile(
              textColor: Colors.black,
              childrenPadding: EdgeInsets.only(left: 30),
              title: Text("Challenges"),
              children: <Widget>[
                ListTile(
                  leading:
                  const Icon(Icons.directions_run, color: Colors.black),
                  title: const Text('Challenge de marche'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Challenges');
                  },
                ),
              ],
            );
          }
        }
    );
  }
}
