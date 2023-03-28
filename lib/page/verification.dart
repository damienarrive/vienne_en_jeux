import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Vérification'),
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

  TextEditingController mailUser = TextEditingController();
  TextEditingController code_user = TextEditingController();

  Future verif() async {
    String urlVerif = "http://192.168.1.190/myApp/verification.php";
    var response = await http.post(Uri.parse(urlVerif), body: {
      "mail_user" : mailUser.text,
      "code_user" : code_user.text,
    }, headers: {"Accept": "application/json"});

    try {
      var data = json.decode(response.body);

      if (data["message"] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vérification réussie')),
        );
        Navigator.pushNamed(context, '/');
      }
      else { //if data == "error"
        Fluttertoast.showToast(msg: "Mauvais code");
      }
    }// end try
    catch(e){
      print(e);
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
                  TextFormField(
                    controller: mailUser,
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
                    controller: code_user,
                    decoration: const InputDecoration(
                      hintText: 'code de vérification*',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir le code de vérification';
                      }
                      return null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          verif();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF375E7E), // Background color
                        foregroundColor: Colors.white, // Text Color (Foreground color)
                      ),
                      child: const Text('Valider'),
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