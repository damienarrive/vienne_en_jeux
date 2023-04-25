import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailjet/mailjet.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

//Version du formulaire avec le frontend de vienne en jeux


class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Inscription'),
          elevation: 0,
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
              const FormInscription()
            ],
          ),
        )
    );
  }
}

class FormInscription extends StatefulWidget {
  const FormInscription({super.key});

  @override
  FormInscriptionState createState() {
    return FormInscriptionState();
  }
}

class FormInscriptionState extends State<FormInscription> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController login_user = TextEditingController();
  TextEditingController nom_user = TextEditingController();
  TextEditingController prenom_user = TextEditingController();
  TextEditingController mail_user = TextEditingController();
  TextEditingController mdp_user = TextEditingController();
  TextEditingController conf_mdp_user = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  bool hidePassword = true;
  late bool error, sending, success;
  late String msg;



  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {

    if(mdp_user.text == conf_mdp_user.text) {
      var theUrl = "http://192.168.1.190/myApp/inscription.php";
      var res = await http.post(Uri.parse(theUrl), body: {
        "login_user": login_user.text,
        "nom_user": nom_user.text,
        "prenom_user": prenom_user.text,
        "mail_user": mail_user.text,
        "mdp_user": mdp_user.text,
      });

      try{
        var data = JSON.jsonDecode(res.body);
        if (data["error"]) {
          setState(() {
            error = true;
            msg = data["message"];
            Fluttertoast.showToast(msg: "Mauvais message");
          });
        }
        else {
          sendMail(mail_user.text, nom_user.text, prenom_user.text, data['code']);
          login_user.text = "";
          nom_user.text = "";
          prenom_user.text = "";
          mail_user.text = "";
          mdp_user.text = "";
          conf_mdp_user.text = "";
          Fluttertoast.showToast(msg: "Compte créé");



          setState(() {
            success = true;
          });
          Navigator.pushNamed(context, '/');
        }
      }
      catch(e){
        print(e);
      }
    }
    else{
      Fluttertoast.showToast(msg: "Mots de passe discordant");
    }
  }

  sendMail(mail,nom, prenom, code) async{
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
        name: "$nom $prenom",
      ),
      reciepients: [
        Recipient(
          email: mail,
          name: "$nom $prenom",
        ),
      ],
      htmlEmail: "<h3>Voici votre code : $code !</h3><br />Merci de votre inscription!",
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
            width: 350,
            height: 650,
            margin: const EdgeInsets.all(10.0),
            padding: EdgeInsets.fromLTRB(20, 0, 30, 60),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: mail_user,
                  autovalidateMode: AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    hintText: 'Adresse mail*',
                    constraints: BoxConstraints.tight(Size.fromHeight(60)),
                  ),
                  // The validator receives the text that the user has entered.
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
                  controller: mdp_user,
                  autovalidateMode: AutovalidateMode.disabled,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Mot de passe*',
                    constraints: BoxConstraints.tight(Size.fromHeight(60)),
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
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: conf_mdp_user,
                  autovalidateMode: AutovalidateMode.disabled,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Confirmation du Mot de passe*',
                    constraints: BoxConstraints.tight(Size.fromHeight(60)),
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
                    if(value != mdp_user.text){
                      return 'Mot de passe different';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: prenom_user,
                  autovalidateMode: AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    hintText: 'Prenom*',
                    constraints: BoxConstraints.tight(Size.fromHeight(60)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre prenom';
                    }
                    if(value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_0-9]'))){
                      return 'Votre prenom ne doit pas contenir de caractère spéciaux';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nom_user,
                  autovalidateMode: AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    hintText: 'Nom*',
                    constraints: BoxConstraints.tight(Size.fromHeight(60)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre Nom';
                    }
                    if(value.contains(RegExp(r'[!@#$%^&*(),.?":{}|_<>0-9]'))){
                      return 'Votre nom ne doit pas contenir de caractère spéciaux';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: login_user,
                  autovalidateMode: AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    hintText: 'Identifiant*',
                    constraints: BoxConstraints.tight(Size.fromHeight(80)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre Identifiant';
                    }
                    if(value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_]'))){
                      return 'Votre login ne doit pas contenir de caractère spéciaux';
                    }
                    return null;
                  },
                ),
                const Text('* sont des champs obligatoires'),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF375E7E), // Background color
                      foregroundColor: Colors.white, // Text Color (Foreground color)
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                content: Text(
                                    "En cliquant sur créer un compte ci-dessous, "
                                        "vous acceptez les conditions génèrales d'utilisation et la politique de confidentialité."
                                ),
                                actions: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.all(10.0),
                                    child: Material(
                                      color: Colors.white70,
                                      child:  Ink(
                                          decoration: const ShapeDecoration(
                                            color: Colors.white70,
                                            shape: CircleBorder(),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(Icons.arrow_back),
                                            color: const Color(0xFF375E7E),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                  TextButton(
                                    child: Text('Créer un compte',
                                        style: TextStyle(color: Colors.blue,)
                                    ),
                                    // onPressed: () => Navigator.pop(context),
                                    onPressed: () {
                                      setState(() {
                                        sending = true;
                                      });
                                      sendData();
                                    },
                                  ),
                                ],
                              ),
                        );
                        Container(
                          margin: const EdgeInsets.all(20.0),
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF375E7E),
                                    // Background color
                                    foregroundColor: Colors
                                        .white, // Text Color (Foreground color)
                                  ),
                                  child: const Text('retour'),
                                ),

                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF375E7E),
                                    // Background color
                                    foregroundColor: Colors
                                        .white, // Text Color (Foreground color)
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
                      }},
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