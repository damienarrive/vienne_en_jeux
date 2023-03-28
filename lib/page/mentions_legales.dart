import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class PageMentionsLegales extends StatefulWidget {
  const PageMentionsLegales({super.key});

  @override
  _PageMentionsLegalesState createState() => _PageMentionsLegalesState();
}

class _PageMentionsLegalesState extends State<PageMentionsLegales> {
  final String _markdownData = """
  **A revoir pour mettre le texte à jour une fois l'appli finie !!!!!!**


  # **Mentions légales**

  ## 1. Présentation du site.
  
  En vertu de l'article 6 de la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l'économie numérique, il est précisé aux utilisateurs du site [https://vienneenjeux.fr/](https://vienneenjeux.fr/) l'identité des différents intervenants dans le cadre de sa réalisation et de son suivi :

  **Propriétaire** : CDOS 86 – Association – 6 allée Jean Monnet, 86000 POITIERS
  
  **Créateur** : [AWA SOLUTIONS](https://www.awa-solutions.fr)

  **Responsable publication** : Patrick GIRARD – [cdos86enjeux@gmail.com](mailto:cdos86enjeux@gmail.com)
  
  Le responsable publication est une personne physique ou une personne morale.

  **WebMaster** : Sébastien CHAUVET – [vienne@franceolympique.com](mailto:vienne@franceolympique.com)
  
  **Hébergeur** : OVH – 2 rue Kellermann, 59100 ROUBAIX

  **Crédits** : Développement web : étudiants du Génie Physiologique et Informatique de Poitiers supervisés par Quentin SIMON

  **Design web** : Gaëlle LECLERC

  Le modèle de mentions légales est offert par Subdelirium.com [Générateur de mentions légales](https://www.subdelirium.com/generateur-de-mentions-legales/)
  

  ## 2. Conditions générales d’utilisation du site et des services proposés.
  
  L’utilisation du site [https://www.vienneenjeux.fr](https://www.vienneenjeux.fr) implique l’acceptation pleine et entière des conditions générales d’utilisation ci-après décrites. Ces conditions d’utilisation sont susceptibles d’être modifiées ou complétées à tout moment, les utilisateurs du site [https://www.vienneenjeux.fr](https://www.vienneenjeux.fr) sont donc invités à les consulter de manière régulière.
  
  Ce site est normalement accessible à tout moment aux utilisateurs. Une interruption pour raison de maintenance technique peut être toutefois décidée par CDOS 86, qui s’efforcera alors de communiquer préalablement aux utilisateurs les dates et heures de l’intervention.

  Le site [https://www.vienneenjeux.fr](https://www.vienneenjeux.fr) est mis à jour régulièrement par Patrick GIRARD. De la même façon, les mentions légales peuvent être modifiées à tout moment : elles s’imposent néanmoins à l’utilisateur qui est invité à s’y référer le plus souvent possible afin d’en prendre connaissance.


  ## 3. Description des services fournis.

  Le site [https://www.vienneenjeux.fr](https://www.vienneenjeux.fr) a pour objet de fournir une information concernant l’ensemble des activités de la société.

  CDOS 86 s’efforce de fournir sur le site [https://www.vienneenjeux.fr](https://www.vienneenjeux.fr) des informations aussi précises que possible. Toutefois, il ne pourra être tenue responsable des omissions, des inexactitudes et des carences dans la mise à jour, qu’elles soient de son fait ou du fait des tiers partenaires qui lui fournissent ces informations.

  Tous les informations indiquées sur le site [https://www.vienneenjeux.fr](https://www.vienneenjeux.fr) sont données à titre indicatif, et sont susceptibles d’évoluer. Par ailleurs, les renseignements figurant sur le site [https://www.vienneenjeux.fr](https://www.vienneenjeux.fr) ne sont pas exhaustifs. Ils sont donnés sous réserve de modifications ayant été apportées depuis leur mise en ligne.


  ## 4. Limitations contractuelles sur les données techniques.
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Mentions légales'),
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
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Markdown(
                styleSheet: MarkdownStyleSheet(
                  textAlign: WrapAlignment.spaceBetween,
                ),
                data: _markdownData,
                onTapLink: (text, url, title) {
                  // launchUrlString(url!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
