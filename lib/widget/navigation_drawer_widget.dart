import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  NavigationDrawerWidget({super.key});
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
            ExpansionTile(
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
            ),
            ExpansionTile(
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
              ],
            ),
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
            )
          ],
        ),
      ),
    );
  }
}
