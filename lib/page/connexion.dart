import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Page de connexion'),
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
      /*    Expanded(
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
                    "Bonjour.",
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),*/
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

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    var url_login = "http://172.20.10.4/api_conn_vienneenjeux/login.php";
    var response = await http.post(url_login, body: {
      "mail_user" : username.text,
      "mdp_user" : password.text,
    });

    var data = json.decode(response.body);
    if(data == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion')),
      );
    }
    else { //if data == "error"
      Fluttertoast.showToast(msg: "Mauvaise combinaison mail/mdp");
    }
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
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

/*                Container(
                  margin: EdgeInsets.only(top:30),
                  padding: EdgeInsets.only(top:10),
                  child: error? errmsg(errormsg): Container()
                ),*/
                TextFormField(
                  controller: username,
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
                  controller: password,
                  obscureText: true,
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
                        /*ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Connexion')),
                        );*/
                        login();
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
      ),
    );
  }
}
