import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class MdpOublie extends StatefulWidget {
  const MdpOublie({super.key});

  @override
  _MdpOublieState createState() => _MdpOublieState();
}

class _MdpOublieState extends State<MdpOublie> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Mot de passe oublie'),
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
            width: 600,
            height: 300,
            margin: const EdgeInsets.all(40.0),
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                    hintText: 'Nouveau Mot de passe',
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
                  decoration: const InputDecoration(
                    hintText: 'Confirmation du nouveau Mot de passe',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir le même mot de passe';
                    }
                    return null;
                  },
                ),
                Container(
                    margin: const EdgeInsets.all(0.0),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    ),
                          child: Row(
                               children: [
                                 Container(
                                   padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
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
                                   padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                          )
                  ],
                ),
                ),
              ],
            ),
          );
  }
}