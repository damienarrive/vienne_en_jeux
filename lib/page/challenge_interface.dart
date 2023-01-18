import 'package:flutter/material.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class ChallengeInterface extends StatefulWidget {
  const ChallengeInterface({super.key});

  @override
  _ChallengeInterfaceState createState() => _ChallengeInterfaceState();
}

class _ChallengeInterfaceState extends State<ChallengeInterface> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Challenge Interface'),
        elevation: 0,
      ),
      body: Column(
        children: [

          //BANNIERE
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.abc_rounded),
                        color: const Color(0xFF375E7E),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),

              Flexible(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Flexible(
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recherche joueur',
                      ),
                    ),
                  ),
                ),
              ),

              //BOUTON AIDE
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.mail),
                        color: const Color(0xFF375E7E),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),

          ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.abc_rounded),
                        color: const Color(0xFF375E7E),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),

              //BOUTON AIDE
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.mail),
                        color: const Color(0xFF375E7E),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  color: const Color(0xFF375E7E),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.abc_rounded),
                        color: const Color(0xFF375E7E),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),


        ],
      ),
    );


  }
}
