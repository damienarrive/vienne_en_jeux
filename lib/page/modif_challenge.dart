import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../widget/navigation_drawer_widget.dart';
import 'dart:convert' as JSON;

class ModifChallenge extends StatefulWidget {
  const ModifChallenge({super.key});
  @override
  _ModifChallengeState createState() => _ModifChallengeState();
}

class _ModifChallengeState extends State<ModifChallenge> {
  final _formKey = GlobalKey<FormState>();
  dynamic enAttente;

  TextEditingController nomChall = TextEditingController();
  TextEditingController dateDebut = TextEditingController();
  TextEditingController dateFin = TextEditingController();
  TextEditingController tailleMaxEquipe = TextEditingController();
  TextEditingController codePrive = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _predicate(DateTime day) {
    print(enAttente);
    for (var i in enAttente) {
      if ((day.compareTo(DateTime(int.parse(i['anneeD']), int.parse(i['moisD']),
          int.parse(i['jourD']))) == 0 ||
          day.compareTo(DateTime(int.parse(i['anneeF']), int.parse(i['moisF']),
              int.parse(i['jourF']))) == 0 ||
          day.isAfter(DateTime(int.parse(i['anneeD']), int.parse(i['moisD']),
              int.parse(i['jourD']))) &&
              day.isBefore(DateTime(
                  int.parse(i['anneeF']), int.parse(i['moisF']),
                  int.parse(i['jourF']))))) {
        return false;
      }
    }
    return true;
  }

  bool _verifDatesValid() {
    for (var i in enAttente) {
      if ((DateTime(
          int.parse(i['anneeD']), int.parse(i['moisD']), int.parse(i['jourD']))
          .isAfter(DateFormat('dd/MM/yyyy').parse(dateDebut.text)) &&
          DateTime(int.parse(i['anneeD']), int.parse(i['moisD']),
              int.parse(i['jourD'])).isBefore(
              DateFormat('dd/MM/yyyy').parse(dateFin.text))) ||
          (DateTime(int.parse(i['anneeF']), int.parse(i['moisF']),
              int.parse(i['jourF'])).isAfter(
              DateFormat('dd/MM/yyyy').parse(dateDebut.text)) &&
              DateTime(int.parse(i['anneeF']), int.parse(i['moisF']),
                  int.parse(i['jourF'])).isBefore(
                  DateFormat('dd/MM/yyyy').parse(dateFin.text)))
      ) {
        return false;
      }
    }
    return true;
  }

  getDateChallengesEnAttente(dateDebutChall, dateFinChall) async {
    dateDebutChall = DateFormat('dd/MM/yyyy').parse(dateDebutChall).toString().replaceAll(" 00:00:00.000", "");
    dateFinChall = DateFormat('dd/MM/yyyy').parse(dateFinChall).toString().replaceAll(" 00:00:00.000", "");
    String theUrl = "http://192.168.1.190/myApp/getDateChallengesEnAttenteModif.php?dateD=$dateDebutChall&dateF=$dateFinChall";
    var res = await http.get(
        Uri.parse(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.encode(json.decode(res.body));
    return responseBody;
  }


  getDateChallengeEnCours() async {
    String theUrl = "http://192.168.1.190/myApp/getDateChallengeEnCours.php";
    var res = await http.get(
        Uri.parse(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  datepicker(date, jour, mois, annee) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: const Locale("fr", "FR"),
      initialDate: DateTime(int.parse(enAttente.last['anneeF']),
          int.parse(enAttente.last['moisF']),
          int.parse(enAttente.last['jourF']) + 1),
      firstDate: DateTime(annee, mois, jour + 1),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101),
      selectableDayPredicate: _predicate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        date.text = formattedDate; //set output date to TextField value.
      });
    }
  }


  Future<void> updateChallenge(id) async {
    DateTime date1 = DateFormat('dd/MM/yyyy').parse(dateDebut.text);
    DateTime date2 = DateFormat('dd/MM/yyyy').parse(dateFin.text);

    if (date1.compareTo(date2) < 0) {
      var phpurl = "http://192.168.1.190/myApp/updateDataChallengeModif.php";
      var res = await http.post(Uri.parse(phpurl), body: {
        "id_defi_marche": id.toString(),
        "nom_defi_marche": nomChall.text,
        "date_debut_marche": DateFormat('yyyy-MM-dd').format(date1),
        "date_fin_marche": DateFormat('yyyy-MM-dd').format(date2),
        "taille_max_equipe": tailleMaxEquipe.text,
        "code_prive": codePrive.text,
      });

      try {
        var data = JSON.jsonDecode(res.body);

        if (data["error"]) {
          Fluttertoast.showToast(msg: data["message"]);
        }
        else {
          Fluttertoast.showToast(msg: "Challenge créé");
          Navigator.pushNamed(context, '/Gestion_Challenge');
        }
      }
      catch (e) {
        print(e);
      }
    }
    else {
      print("mauvaises dates (antérieur)");
    }
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as List;

    setState(() {
      nomChall.text = args[0]['nom_defi_marche'];
      dateDebut.text = args[0]['date_debut_marche'];
      dateFin.text = args[0]['date_fin_marche'];
      tailleMaxEquipe.text = args[0]['taille_max_equipe'].toString();
      print(args[0]['code_prive']);
      if(args[0]['code_prive'] == null){
        codePrive.text = "";
      }
      else{
        codePrive.text = args[0]['code_prive'].toString();
      }

    });

    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Création de Challenge'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child : Column(
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
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: formModifChallenge(args),
                ),
              ]
          ),
        )
    );
  }


formModifChallenge(args) {
    return FutureBuilder(
        future: getDateChallengeEnCours(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("ERROR fetching data"),
              );
            }
            var snap = snapshot.data;
            return FutureBuilder(
                future: getDateChallengesEnAttente(args[0]['date_debut_marche'], args[0]['date_fin_marche']),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("ERROR fetching data"),
                      );
                    }
                    enAttente = JSON.jsonDecode(snapshot.data);
                    // print(enAttente);
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.all(10.0),
                            child: Material(
                              color: Colors.white,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back, size: 40),
                                color: const Color(0xFF375E7E),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),

                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: nomChall,
                                    decoration: InputDecoration(
                                      hintText: 'Nom du challenge*',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Veuillez entrer un nom de challenge";
                                      }
                                      return null;
                                    },
                                  ),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: TextFormField(
                                      controller: dateDebut,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                            Icons.calendar_today,
                                            color: Colors.blue
                                        ), //icon of text field
                                        labelText: "Date de début",
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        if (snap.isEmpty) {
                                          datepicker(dateDebut, DateTime
                                              .now()
                                              .day, DateTime
                                              .now()
                                              .month, DateTime
                                              .now()
                                              .year);
                                        }
                                        else {
                                          datepicker(dateDebut,
                                              int.parse(snap[0]['jour']),
                                              int.parse(snap[0]['mois']),
                                              int.parse(snap[0]['annee']));
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Veuillez entrer une date";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    child: TextFormField(
                                      controller: dateFin,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                          icon: Icon(
                                              Icons.calendar_today,
                                              color: Colors.blue
                                          ), //icon of text field
                                          labelText: "Date de fin" //label text of field
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        if (snap.isEmpty) {
                                          datepicker(dateDebut, DateTime
                                              .now()
                                              .day, DateTime
                                              .now()
                                              .month, DateTime
                                              .now()
                                              .year);
                                        }
                                        else {
                                          datepicker(dateFin,
                                              int.parse(snap[0]['jour']),
                                              int.parse(snap[0]['mois']),
                                              int.parse(snap[0]['annee']));
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Veuillez entrer une date";
                                        }
                                        else if (DateFormat('dd/MM/yyyy').parse(
                                            value).compareTo(
                                            DateFormat('dd/MM/yyyy').parse(
                                                dateDebut.text)) < 0) {
                                          return "Dates imcompatibles";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  TextFormField(
                                    controller: tailleMaxEquipe,
                                    decoration: const InputDecoration(
                                      hintText: 'Nombre de membre par équipe*',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Veuillez entrer un nombre";
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: codePrive,
                                    decoration: const InputDecoration(
                                      hintText: 'Code privé',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 30),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF375E7E),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (_verifDatesValid()) {
                                              updateChallenge(args[0]['id_defi_marche']);
                                            }
                                            else {
                                              Fluttertoast.showToast(
                                                  msg: "Dates non disponibles");
                                            }
                                          }
                                          else {
                                            Fluttertoast.showToast(
                                                msg: "Veuillez remplir tous les champs correctement");
                                          }
                                        },
                                        child: const Text(
                                          'Modifier',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                }

            );
          }
          return Container();
        }
    );
  }
}
