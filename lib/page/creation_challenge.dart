import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../widget/navigation_drawer_widget.dart';

class CreationChallenge extends StatefulWidget {
  const CreationChallenge({super.key});
  @override
  _CreationChallengeState createState() => _CreationChallengeState();
}

class _CreationChallengeState extends State<CreationChallenge> {

  @override
  Widget build(BuildContext context) {
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
                  child: const FormCreateChallenge(),
                ),
                // const FormChallenge(),
              ]
          ),
          // child: listChallenges(),
        )
    );
  }
}

class FormCreateChallenge extends StatefulWidget {
  const FormCreateChallenge({super.key});

  @override
  FormCreateChallengeState createState() {
    return FormCreateChallengeState();
  }
}

class FormCreateChallengeState extends State<FormCreateChallenge> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nomChall = TextEditingController();
  TextEditingController dateDebut = TextEditingController();
  TextEditingController dateFin = TextEditingController();
  TextEditingController tailleMaxEquipe = TextEditingController();
  TextEditingController codePrive = TextEditingController();

  @override
  void initState() {
    // var res = getDateLastChallenge()[0];
    // DateTime dateLastChall = res[0]['date_fin_marche'];
    dateDebut.text = ""; //set the initial value of text field
    dateFin.text = "";
    super.initState();
  }

  getDateLastChallenge() async{
    String theUrl = "http://192.168.1.190/myApp/getDateLastChallenge.php";
    var res = await http.get(Uri.parse(theUrl),headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }

  datepicker(date, jour, mois, annee) async{
    DateTime? pickedDate = await showDatePicker(
      context: context, //context of current state
      locale : const Locale("fr","FR"),
      initialDate: DateTime(annee, mois, jour),
      firstDate: DateTime(annee, mois, jour), //DateTime.now() - not to allow to choose before today.
      // firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if(pickedDate != null ){
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        date.text = formattedDate; //set output date to TextField value.
      });
    }
  }


  Future<void> addChallenge() async{
    DateTime date1 = DateFormat('dd/MM/yyyy').parse(dateDebut.text);
    DateTime date2 = DateFormat('dd/MM/yyyy').parse(dateFin.text);

    if(date1.compareTo(date2) < 0){
      var phpurl = "http://192.168.1.190/myApp/addChallenge.php";
      var res = await http.post(Uri.parse(phpurl), body: {
        "nom_defi_marche": nomChall.text,
        "date_debut_marche": date1,
        "date_fin_marche": date2,
        "taille_max_equipe": tailleMaxEquipe.text,
        "code_prive": codePrive.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDateLastChallenge(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("ERROR fetching data"),
            );
          }
          var snap = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nomChall,
                          decoration: InputDecoration(
                            hintText: 'Nom du challenge*',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width : 140,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                  controller: dateDebut,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.blue
                                      ), //icon of text field
                                      labelText: "Date de début" //label text of field
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    datepicker(dateDebut, int.parse(snap[0]['jour']), int.parse(snap[0]['mois']), int.parse(snap[0]['annee']));
                                  }
                              ),
                            ),
                            Container(
                              width: 140,
                              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: TextFormField(
                                controller: dateFin,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.blue
                                    ), //icon of text field
                                    labelText: "Date de fin" //label text of field
                                ),
                                readOnly: true,
                                onTap: () async {
                                  datepicker(dateFin,  int.parse(snap[0]['jour']), int.parse(snap[0]['mois']), int.parse(snap[0]['annee']));
                                }
                            ),
                            ),

                          ],
                        ),
                        TextFormField(
                          controller: tailleMaxEquipe,
                          decoration: const InputDecoration(
                            hintText: 'Nombre de membre par équipe*',
                          ),
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
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF375E7E),
                            ),
                            onPressed: (){
                              addChallenge();
                            },
                            child: const Text(
                              'Ajouter',
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
}