import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

//Version du formulaire avec le frontend de vienne en jeux


class InscriptionProf extends StatefulWidget {
  const InscriptionProf({super.key});

  @override
  _InscriptionProfState createState() => _InscriptionProfState();
}

class _InscriptionProfState extends State<InscriptionProf> {

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
  TextEditingController num_tel = TextEditingController();
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
      var phpurl = "http://192.168.1.230/myApp/inscriptionProf.php";
      var res = await http.post(Uri.parse(phpurl), body: {
        "login_user": login_user.text,
        "nom_user": nom_user.text,
        "prenom_user": prenom_user.text,
        "mail_user": mail_user.text,
        "mdp_user": mdp_user.text,
        "num_tel": num_tel.text.toString(),
      });

      try{
        var data = JSON.jsonDecode(res.body);
        print(data);
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
          Container(
              width: 350,
              height: 150,
              margin: const EdgeInsets.all(10.0),
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                  children: [
                    const Text(
                      "Cette inscription s'adresse aux professeurs uniquement.",
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Inscription');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF375E7E), // Background color
                          foregroundColor: Colors.white, // Text Color (Foreground color)
                        ),
                        child: const Text('Accès inscription lambda'),
                      ),
                    ),
                  ]
              )
          ),
          Container(
            width: 350,
            height: 700,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Adresse mail académique*',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre adresse mail';
                    }
                    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                      return "Ceci n'est pas une adresse mail correcte";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: mdp_user,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Mot de passe*',
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirmation du Mot de passe*',
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Prénom*',
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Nom*',
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Identifiant*',
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
                TextFormField(
                  controller: num_tel,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                  decoration: InputDecoration(
                    hintText: 'Numero de téléphone',
                    constraints: BoxConstraints.tight(Size.fromHeight(80)),
                  ),
                  // The validator receives the text that the user has entered.
                  validator : (value){
                    if(value == null || value.isEmpty) {
                      return null;
                    }
                    else{
                      if (value.length != 10) {
                        return "Ce numéro de téléphone n'est pas correct";
                      }
                    }
                    return null;
                  }
                ),
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
                                title: Text('* sont des champs obligatoire'),
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

                        // pas compris cette partie
                        // Container(
                        //   margin: const EdgeInsets.all(20.0),
                        //   padding:
                        //   const EdgeInsets.symmetric(
                        //       horizontal: 0, vertical: 0),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        //         child: ElevatedButton(
                        //           onPressed: () {
                        //             if (_formKey.currentState!.validate()) {
                        //               ScaffoldMessenger.of(context)
                        //                   .showSnackBar(
                        //                 const SnackBar(
                        //                     content: Text('Processing Data')),
                        //               );
                        //             }
                        //           },
                        //           style: ElevatedButton.styleFrom(
                        //             backgroundColor: Color(0xFF375E7E),
                        //             // Background color
                        //             foregroundColor: Colors
                        //                 .white, // Text Color (Foreground color)
                        //           ),
                        //           child: const Text('retour'),
                        //         ),
                        //
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //         child: ElevatedButton(
                        //           onPressed: () {
                        //             if (_formKey.currentState!.validate()) {
                        //               ScaffoldMessenger.of(context)
                        //                   .showSnackBar(
                        //                 const SnackBar(
                        //                     content: Text('Processing Data')),
                        //               );
                        //             }
                        //           },
                        //           style: ElevatedButton.styleFrom(
                        //             backgroundColor: Color(0xFF375E7E),
                        //             // Background color
                        //             foregroundColor: Colors
                        //                 .white, // Text Color (Foreground color)
                        //           ),
                        //           child: const Text('Changer de mot de passe'),
                        //         ),
                        //
                        //       )
                        //     ],
                        //   ),
                        // );


                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

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