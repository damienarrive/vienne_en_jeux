import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

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
      return ElevatedButton(
          onPressed: (){
            Navigator.pushNamed(context, '/Connexion');
          },
          child: const Text("Connexion")
      );
    }
    else{
      return ElevatedButton(
          onPressed: (){
            session.destroy();
            Navigator.pushNamed(context, '/');
          },
          child: const Text("Deconnexion")
      );
    }
  }
}