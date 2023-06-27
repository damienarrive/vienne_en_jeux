import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mailjet/mailjet.dart';
import 'package:pedometer/pedometer.dart';
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
      resizeToAvoidBottomInset: false,
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
  late Stream<StepCount> _stepCountStream;
  String _steps = "";
  String _lastSteps = "";

  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  TextEditingController mailUser = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSteps();
  }

  Future login() async {
    // var urlLogin = "http://192.168.1.190/myApp/login.php";
    var urlLogin = "https://dev.vienneenjeux.fr/PHP_files/login.php";
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
      await getSteps();
      await SessionManager().set('userId', data['data'][0]['id']);
      await SessionManager().set('nom', data['data'][0]['nom']);
      await SessionManager().set('prenom', data['data'][0]['prenom']);
      await SessionManager().set('type_user', data['data'][0]['type_user']);


      modifLastSteps();

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


  //PODOMETRE
  void _onData(StepCount receivedData) async{
    print("receivedData : $receivedData");
    _steps = receivedData.steps.toString();
    print("steps : $_steps");
  }

  //PODOMETRE
  void _onError(err) {
    print('[Pedometer] Error: $err');
  }

  //PODOMETRE
  void _onDone() {
    print('[Pedometer] Done');
  }

  //PODOMETRE
  getSteps(){
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(
        _onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: true
    );
  }

  compteurPas(nbPas, idUser) async{
    var urlLogin = "https://dev.vienneenjeux.fr/PHP_files/updateStepsMarche.php";
    var response = await http.post(Uri.parse(urlLogin), body: {
      "pas" : nbPas.toString(),
      "idUser" : idUser.toString(),
    });
    try{
      var data = JSON.jsonDecode(response.body);
      print(data);
    }
    catch(e){
      print(e);
    }
  }

  modifLastSteps() async{
    dynamic user = await SessionManager().get('userId');
    var urlLogin = "https://dev.vienneenjeux.fr/PHP_files/modifLastSteps.php";
    var response = await http.post(Uri.parse(urlLogin), body: {
      "idUser" : user.toString(),
      "steps" : _steps,
    });
    try{
      var data = JSON.jsonDecode(response.body);
      print(data);

      if(data['message'] == "success pas"){
        // on vérifie si l'ancien nb de pas enregistré est null ou nn
        if(data['ancien_pas'] != "NULL"){// si nn on vérifie que l'ancien nb est inférieur au nouveau
          _lastSteps = data['ancien_pas'];
          if(int.parse(_lastSteps) < int.parse(_steps)){// si oui on compte le nombre de pas
            int nbPas = int.parse(_steps) - int.parse(_lastSteps);
            compteurPas(nbPas, user);
          }
        }

      }
    }
    catch(e){
      print(e);
    }
  }

  genererCode(mailUser) async{
    var urlLogin = "https://dev.vienneenjeux.fr/PHP_files/genererCode.php";
    var response = await http.post(Uri.parse(urlLogin), body: {
      "mailUser" : mailUser,
    });
    try{
      var data = JSON.jsonDecode(response.body);
      print(data);
      envoieMailMdpOublie(mailUser, data['code'], data['nom'], data['prenom']);
    }
    catch(e){
      print(e);
    }
  }

  envoieMailMdpOublie(mail, code, nom, prenom) async{
    String apiKey = "58152266460866e00be5762ff6757a4b";
    String secretKey = "60d36681bbb300c4f674ddb9e9d602b6";

    //TODO mettre l'adresse du CDOS pour le prod
    String myEmail = 'vianney.souday@awa-solutions.fr';

    MailJet mailJet = MailJet(
      apiKey: apiKey,
      secretKey: secretKey,
    );

    await mailJet.sendEmail(
      subject: "Vérification de compte",
      sender: Sender(
        email: myEmail,
        name: "NePasRepondre",
      ),
      reciepients: [
        Recipient(
          email: mail,
          name: "$nom $prenom",
        ),
      ],
      htmlEmail: "<h3>Voici votre code pour changer de mot de passe : $code !</h3>",
    );
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
                          genererCode(mailUser.text);
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