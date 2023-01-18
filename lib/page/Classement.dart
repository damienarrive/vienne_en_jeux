import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final titleController = TextEditingController();
  //String text = "No Value Entered";
 test() {
  Map myMap = {
    'Les Jones': 123,
    'Fuck You': 6754,
    'On marche pas nous': 45678
  };
  myMap.forEach((key, value) {
    print('$key,$value');
  });

}

  Map<String, dynamic> myMap = {
    'Les Jones': 123,
    'Fuck You': 6754,
    'On marche pas nous': 45678
  };


  //void _setText() {
   // setState(() {
   //   text = titleController.text;
   // });
 // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Classement'),
        elevation: 0,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10.10),
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Ce classement est mis à jour toutes les heures                                 ",
                textAlign: TextAlign.center,

              ),


            ),
            Container(

              margin: const EdgeInsets.all(10.10),
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
          children: [
            Container(

    child:
    const Text(
    "Rank       ",
    textAlign: TextAlign.center,
    ),
            ),
            Container(
              child:
              const Text(
                "Nom     ",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child:
              const Text(
                "Score       ",
                textAlign: TextAlign.center,
              ),

            ),
              Container(
                child: test(),
              )
    ]
    )




              ),

]
            ),



      );

  }


  }




  //Widget build(BuildContext context) {
//  return Scaffold(
//    appBar: AppBar(
//     title: const Text('Classement'),
//     backgroundColor: Colors.green,
//    ),
//     body: Column(
//      children: [
//        Padding(
//          padding: const EdgeInsets.all(15),
//         child: TextField(
//           decoration: const InputDecoration(labelText: 'Title'),
//          controller: titleController,
//        ),
//      ),
//     const SizedBox(
//         height: 8,
//      ),
//     ElevatedButton(
//         onPressed: _setText,
//        style: ButtonStyle(
//            elevation: MaterialStateProperty.all(8),
//             backgroundColor: MaterialStateProperty.all(Colors.green)),
//         child: const Text('Submit')),


          // RaisedButton is deprecated and should not be used
          // Use ElevatedButton instead

          // RaisedButton(
          //   onPressed: _setText,
          //   child: Text('Submit'),
          //   elevation: 8,
          // ),
//       const SizedBox(
//       height: 20,
//    ),

//    Expanded(
//     child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//   Container(
//   margin: const EdgeInsets.all(50.0),
//   padding:
//  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//  decoration: BoxDecoration(
//   color: Colors.white,
//  borderRadius: BorderRadius.circular(20),
//   ),

//     child:
//      const Text(
//             "Le challenge de marche vous met au défi de réaliser le maximum de pas (marche ou course) sur une période donnée, seul ou en équipe. \nPour participer, il vous faut ouvrir un compte, vous connecter sur Vienne en Jeux, et vous inscrire au Challenge. \nPour fonctionner, Vienne en Jeux utilise les informations sur le nombre de pas récoltés par l'application Santé de votre téléphone. Vous devrez pour cela autoriser Vienne en Jeux à lire ces données dans l'application Santé.\n \nVienne en Jeux n'utilise aucune autre donnée personnelle de l'application Santé ou de toute autre application présente sur votre téléphone",
//           textAlign: TextAlign.justify,
// ),
//       ),
// ],
// ),


//  ),

//  ],
//   )
// );

//  }
//}