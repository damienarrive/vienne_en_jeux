import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:vienne_en_jeux/main.dart';

class ConnexionButtonWidget extends StatefulWidget {
  ConnexionButtonWidget({super.key});

  @override
  _ConnexionButtonWidgetState createState() => _ConnexionButtonWidgetState();
}


class _ConnexionButtonWidgetState extends State<ConnexionButtonWidget> {
  var session = SessionManager();
  String id = "";

  @override
  void initState() {
    super.initState();
    _getSession();
  }

  _getSession() async {
    dynamic idUser = await session.get('userId');
    setState(() {
      id = idUser.toString();
    });
    // print(id.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    if(id == "null"){
      return Padding(
          padding : const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      return const Color(0xFF375E7E);
                    }
                )
            ),
            onPressed: (){
              Navigator.pushNamed(context, '/Connexion');
            },
            child: const Text("Connexion", style: TextStyle(color: Colors.white),)
        )
      );

    }
    else{
      return Padding(
        padding : const EdgeInsets.all(10),
        child : ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      return const Color(0xFF375E7E);
                    }
                )
            ),
            onPressed: (){
              session.destroy();
              Navigator.pushNamed(context, '/');
            },
            child: const Text("Déconnexion",style: TextStyle(color: Colors.white),)
        )
      );
    }
  }
}