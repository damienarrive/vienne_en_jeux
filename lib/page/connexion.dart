import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
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
        title: const Text('Connexion'),
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
          const FormConnexion()
        ],
      ),
    );
  }
}



class FormConnexion extends StatefulWidget {
  const FormConnexion({super.key});

  @override
  FormConnexionState createState() {
    return FormConnexionState();
  }
}

class FormConnexionState extends State<FormConnexion> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  TextEditingController mailUser = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    var urlLogin = "http://192.168.1.190/myApp/login.php";
    var response = await http.post(Uri.parse(urlLogin), body: {
      "mail_user" : mailUser.text,
      "mdp_user" : password.text,
    });

    try {
      var data = JSON.jsonDecode(response.body);
      print(data);

      if (data['message'] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connexion')),
        );
      await SessionManager().set('userId', data['data'][0]['id']);
      await SessionManager().set('nom', data['data'][0]['nom']);
      await SessionManager().set('prenom', data['data'][0]['prenom']);
      await SessionManager().set('type_user', data['data'][0]['type_user']);
      Navigator.pushNamed(context, '/');
      }
      else if(data['message'] == "Veuillez verifier votre compte"){
        Fluttertoast.showToast(msg: "Veuillez verifier votre compte");
      }
      else { //if data == "error"
        Fluttertoast.showToast(msg: "Mauvaise combinaison mail/mdp");
      }
    }// end try
    catch(e){
      print(e);
    }
  }


  envoieMailMdpOublie(mail) async{
    //TODO envoie code?

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
                  TextFormField(
                    controller: mailUser,
                    decoration: const InputDecoration(
                      hintText: 'Adresse mail*',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre adresse mail';
                      }
                      else if(!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value)){
                        return 'Veuillez saisir une adresse mail valide';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: password,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      hintText: 'Mot de passe*',
                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                        },
                      ),
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
                          login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF375E7E), // Background color
                        foregroundColor: Colors.white, // Text Color (Foreground color)
                      ),
                      child: const Text('Se connecter'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/Inscription',
                        );
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
                        if(mailUser.text.isEmpty){
                          Fluttertoast.showToast(msg: "Veuillez saisir une adresse mail");
                        }
                        else if(!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(mailUser.text)){
                          Fluttertoast.showToast(msg: "Veuillez saisir une adresse mail valide");
                        }
                        else{
                          //TODO décider de quoi envoyer par mail -> code? changement de mdp uniquement si code juste
                          envoieMailMdpOublie(mailUser.text);
                          Navigator.pushNamed(
                            context,
                            '/MdpOublie',
                          );
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
                        Navigator.pushNamed(context, '/Verification');
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