import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:vienne_en_jeux/page/challenge_interface.dart';

class Bonus extends StatefulWidget {
  const Bonus({super.key});

  @override
  _BonusState createState() => _BonusState();
}

class _BonusState extends State<Bonus> {
  @override
  Widget build(BuildContext context) {
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

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(50.0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                    child: Column(
                      children:  [
                        Text(
                        "Connecte-toi",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),

                      Text(
                        "connexion : 1/1",
                        textAlign: TextAlign.center,
                      ),

                        Divider(
                            color: Color(0xFF375E7E)
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF375E7E), // Background color
                              foregroundColor: Colors.white, // Text Color (Foreground color)
                            ),
                            onPressed: () {  },
                            child: const Text('Récupérer'),
                          ),
                        ),


                  ],
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*class MyBonus extends StatefulWidget {
  const MyBonus({super.key});

  @override
  MyBonusState createState() => MyBonusState();
}

class MyBonusState extends State<MyBonus> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Accueil'),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(50.0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "L'application Vienne en Jeux vous propose de participer à des challenges de marche / de course. Ces challenges se déroulent sur des périodes courtes. \nL'application comptabilise le nombre de pas grâce à un podomètre intégré. \n\nPour participer, créer un compte et rendez-vous dans l'onglet Challenges puis cliquez sur Challenge de marche.",
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/

    /*  child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(50.0),
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Adresse mail*',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre adresse mail';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Mot de passe*',

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre mot de passe';
                      }
                      return null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Connexion')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF375E7E), // Background color
                        foregroundColor: Colors.white, // Text Color (Foreground color)
                      ),
                      child: const Text('Connexion'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF375E7E), // Background color
                        foregroundColor: Colors.white, // Text Color (Foreground color)
                      ),
                      child: const Text('M\'inscrire'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF375E7E), // Background color
                        foregroundColor: Colors.white, // Text Color (Foreground color)
                      ),
                      child: const Text('Mot de passe oublié ?'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF375E7E), // Background color
                        foregroundColor: Colors.white, // Text Color (Foreground color)
                      ),
                      child: const Text('Valider mon compte'),
                    ),
                  ),
                ],
              )
          )
        ],
      ),*/
