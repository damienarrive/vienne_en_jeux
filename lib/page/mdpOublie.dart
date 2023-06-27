import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailjet/mailjet.dart';
import 'package:vienne_en_jeux/widget/connexion_button_widget.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class MdpOublie extends StatefulWidget {
  const MdpOublie({super.key});

  @override
  _MdpOublieState createState() => _MdpOublieState();
}

class _MdpOublieState extends State<MdpOublie> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Mot de passe oublie'),
        elevation: 0,
          actions : <Widget>[
            ConnexionButtonWidget(),
          ]
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
          const MyCustomForm()
        ],
      ),
    )
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
  TextEditingController newMdp = TextEditingController();
  TextEditingController newMdp2 = TextEditingController();
  TextEditingController codeMDP = TextEditingController();
  TextEditingController mailUser = TextEditingController();
  bool hidePassword = true;

  setNewMdp(mailUser, code, password) async{
    var urlLogin = "https://dev.vienneenjeux.fr/PHP_files/updateMdp.php";
    var response = await http.post(Uri.parse(urlLogin), body: {
      "mailUser" : mailUser,
      "newMdp" : password,
      "code" : code,
    });
    try{
      var data = JSON.jsonDecode(response.body);
      print(data);
      if(data['message'] == "success"){
        Navigator.pushNamed(context, "/");
      }
      else if(data['message'] == "mail"){
        Fluttertoast.showToast(msg: "Adresse mail inconnue");
      }
      else if(data['message'] == "code"){
        Fluttertoast.showToast(msg: "Code incorrect");
      }
    }
    catch(e){
      print(e);
    }
  }

  Future findMail() async{
    String urlFind = "http://dev.vienneenjeux.fr/PHP_files/findMail.php";
    // String urlFind = "http://192.168.1.190/myApp/findMail.php";
    var response = await http.post(Uri.parse(urlFind),body: {
      "mail_user" : mailUser.text,
    }, headers: {"Accept": "application/json"});

    try{
      var data = JSON.jsonDecode(response.body);
      if(data.isNotEmpty){
          envoieMailMdpOublie(mailUser.text, data[0]['code_mdp'], data[0]['nom_user'], data[0]['prenom_user']);
          Fluttertoast.showToast(msg: "Mail envoyé");
      }
      else{
        Fluttertoast.showToast(msg: "Cette adresse mail n'est associée à aucun compte");
      }
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 600,
            height: 440,
            margin: const EdgeInsets.all(50.0),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF375E7E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Vous avez normalement reçu un mail contenant un code vous permettant de changer de mot de passe !",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ),
                TextFormField(
                  controller: mailUser,
                  decoration: const InputDecoration(
                    hintText: 'Adresse mail',
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
                  controller: codeMDP,
                  decoration: const InputDecoration(
                    hintText: 'Code',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir un code';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: newMdp,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Nouveau Mot de passe',
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
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre nouveau mot de passe';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: newMdp2,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Confirmation nouveau Mot de passe',
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
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir le même mot de passe';
                    }
                    if(value != newMdp.text){
                      return 'Mot de passe different';
                    }
                    return null;
                  },
                ),
                Container(
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                         children: [
                           Container(
                             padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                             child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF375E7E), // Background color
                                foregroundColor: Colors.white, // Text Color (Foreground color)
                                ),
                                child: const Text('Retour'),
                             ),

                           ),
                           Container(
                             width: 150,
                             padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                             child: ElevatedButton(
                               onPressed: () {
                                 if (_formKey.currentState!.validate()) {
                                   setNewMdp(mailUser.text, codeMDP.text, newMdp.text);
                                 }
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Color(0xFF375E7E), // Background color
                                 foregroundColor: Colors.white, // Text Color (Foreground color)
                               ),
                               child: const Text(
                                     textAlign: TextAlign.center,
                                     textDirection: TextDirection.ltr,
                                     maxLines: 2,
                                     'Changer de mot de passe'),
                               ),
                           ),
                        ],
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (mailUser.text.isNotEmpty || !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(mailUser.text)) {
                        // findMail();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF375E7E), // Background color
                      foregroundColor: Colors.white, // Text Color (Foreground color)
                    ),
                    child: const Text('Renvoyer un mail'),
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