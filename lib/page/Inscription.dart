import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  //getData()async{
    //String theUrl = "http://127.0.0.1/my-app/getData.php";
    //String theUrl = "http://localhost/my-app/getData.php";
  //var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
  //var responseBody = json.decode(res.body);
  //return responseBody;
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Inscription'),
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
                  image: AssetImage('images/banniere_mobile.png'),
                ),
              ],
            ),
          ),
          const MyCustomForm()
        ],
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
   return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 300,
              height: 150,
            margin: const EdgeInsets.all(5),
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

              child: Column(
               children: [
                 Text(
                " Cette inscription n'est pas destinée aux professeurs. Si vous souhaitez vous inscrire en tant que professeur, cliquez sur le bouton ci-dessous.",
                textAlign: TextAlign.justify,
              ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF375E7E), // Background color
                          foregroundColor: Colors.white, // Text Color (Foreground color)
                        ),
                        child: const Text('Accés inscription professeur'),
                      ),
                  ),
            ]
          )
          ),
          Container(
            width: 900,
            height: 800,
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
            children: [
              TextFormField(
              decoration: const InputDecoration(
              hintText: 'Adresse mail',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
              if (value == null || value.isEmpty) {
              return 'Veuillez saisir votre adresse mail';
              }
              return null;
              },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Mot de passe',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre mot de passe';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Confirmation du Mot de passe',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le même mot de passe';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Prenom',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre prenom';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nom',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre Nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Identifiant',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre Identifiant';
                  }
                  return null;
                },
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('* sont des champs obligatoire'),
                          content: Text(
                              "En cliquant sur créer un compte ci-dessous, vous acceptez les conditions génèrales d'utilisation et la politique de confidentialité."
                          ),
                          actions: [
                            TextButton(
                              child: Text('Retour',
                              style: TextStyle(color: Colors.blue,)
                    ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                                child: Text('Créer un compte',
                                    style: TextStyle(color: Colors.blue,)
                                ),
                            onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                    );
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF375E7E), // Background color
                                foregroundColor: Colors.white, // Text Color (Foreground color)
                              ),
                              child: const Text('retour'),
                            ),

                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF375E7E), // Background color
                                foregroundColor: Colors.white, // Text Color (Foreground color)
                              ),
                              child: const Text('Changer de mot de passe'),
                            ),

                          )
                        ],
                      ),
                    );

                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Sauvegarder'),

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