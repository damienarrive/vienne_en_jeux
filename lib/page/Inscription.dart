import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  TextEditingController login_user = TextEditingController();
  TextEditingController nom_user = TextEditingController();
  TextEditingController prenom_user = TextEditingController();
  TextEditingController mail_user = TextEditingController();
  TextEditingController mdp_user = TextEditingController();
  TextEditingController conf_mdp_user = TextEditingController();
  // TextEditingController age_user = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  late bool error, sending, success;
  late String msg;



  @override
  void iniState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {

    if(mdp_user.text == conf_mdp_user.text) {
      var phpurl = "http://172.20.10.7/my-app/Inscription.php";
      var res = await http.post(Uri.parse(phpurl), body: {
        "login_user": login_user.text,
        "nom_user": nom_user.text,
        "prenom_user": prenom_user.text,
        "mail_user": mail_user.text,
        "mdp_user": mdp_user.text,
        // "age_user": age_user,
      });

      try{
        var data = JSON.jsonDecode(res.body);
        // print(data);
        if (data["error"]) {
          setState(() {
            sending = false;
            error = true;
            msg = data["message"];
            Fluttertoast.showToast(msg: "Mauvais message");
          });
        }
        else {
          login_user.text = "";
          nom_user.text = "";
          prenom_user.text = "";
          mail_user.text = "";
          mdp_user.text = "";
          conf_mdp_user.text = "";
          Fluttertoast.showToast(msg: "Connexion reussie");

          setState(() {
            sending = false;
            success = true;
          });
        }
      }
      catch(e){
        print(e);
      }
    }
    else{
      Fluttertoast.showToast(msg: "mots de passe discordant");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //     width: 300,
          //     height: 174,
          //     margin: const EdgeInsets.all(10.0),
          //     padding:
          //     const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //
          //     child: Column(
          //         children: [
          //           Text(
          //             " Cette inscription n'est pas destinée aux professeurs. Si vous souhaitez vous inscrire en tant que professeur, cliquez sur le bouton ci-dessous.",
          //             textAlign: TextAlign.justify,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 16.0),
          //             child: ElevatedButton(
          //               onPressed: () {
          //                 if (_formKey.currentState!.validate()) {
          //                   ScaffoldMessenger.of(context).showSnackBar(
          //                     const SnackBar(content: Text('Processing Data')),
          //                   );
          //                 }
          //               },
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: Color(0xFF375E7E), // Background color
          //                 foregroundColor: Colors.white, // Text Color (Foreground color)
          //               ),
          //               child: const Text('Accès inscription professeur'),
          //             ),
          //           ),
          //         ]
          //     )
          // ),
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
                    return null;
                  },
                ),
                TextFormField(
                  controller: mdp_user,
                  autovalidateMode: AutovalidateMode.disabled,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Mot de passe*',
                    constraints: BoxConstraints.tight(Size.fromHeight(60)),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirmation du Mot de passe*',
                    constraints: BoxConstraints.tight(Size.fromHeight(60)),
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
                    if(value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_èéàëïöüêîôû0-9]'))){
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
                    if(value.contains(RegExp(r'[!@#$%^&*(),.?":{}|_<>èéàëïöüêîôû0-9]'))){
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
                    if(value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_èéàëïöüêîôû]'))){
                      return 'Votre login ne doit pas contenir de caractère spéciaux';
                    }
                    return null;
                  },
                ),
                // TextFormField(
                //   controller: age_user,
                //   keyboardType: TextInputType.numberWithOptions(decimal: false),
                //   inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                //   autovalidateMode: AutovalidateMode.disabled,
                //   decoration: const InputDecoration(
                //     hintText: 'Age*',
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Veuillez saisir votre âge';
                //     }
                //     return null;
                //   },
                // ),
                Text('* sont des champs obligatoires'),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
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
                                      child: Container(
                                        child: Ink(
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