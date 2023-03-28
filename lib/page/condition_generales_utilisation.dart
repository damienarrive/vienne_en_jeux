import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:url_launcher/url_launcher_string.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';

class PageCGU extends StatefulWidget {
  const PageCGU({super.key});

  @override
  _PageCGUState createState() => _PageCGUState();
}

class _PageCGUState extends State<PageCGU> {
  final String _markdownData = """
  # **Conditions Générales d'Utilisations**

  ## 1 - Acceptation

  Les présentes Conditions Générales d’Utilisation déterminent les règles d’accès à l’Application web et mobile du CDOS de la Vienne (CDOS) [https://www.vienneenjeux.fr](https://www.vienneenjeux.fr) ainsi que ses modalités d’utilisation.
  
  L’utilisateur accepte lesdites Conditions sans réserve du seul fait de sa connexion à l’application et s’engage à les respecter.


  ## 2 - Contenu de l'application

  On entend par Contenu de l’Application : la structure générale de l’Application, la charte graphique, l'ensemble des contenus diffusés sur cette Application (images, articles, photos, logos, marques, vidéos, interviews, sons, textes, bases de données, informations fédérales, résultats, classements, calendriers, etc).
  
  Dans le cas particulier des pseudos choisis par les utilisateurs et potentiellement visibles par les autres, le CDOS se réserve néanmoins la faculté de modérer tout contenu contraire à ses valeurs éthiques ou tout contenu à caractère illicite qui serait porté à sa connaissance.
  
  Ce Contenu est protégé par la législation en vigueur en France notamment en matière de propriété intellectuelle et notamment le droit d'auteur, les droits voisins, le droit des marques, le droit à l'image, et par la législation communautaire et internationale.
  
  Toute représentation, reproduction, exploitation, intégrale ou partielle, par quelque procédé que ce soit et à quelque titre que ce soit, sans l'autorisation préalable et expresse du CDOS, est interdite et constituerait une contrefaçon sanctionnée notamment par les articles L335-2 et suivants du Code de la Propriété intellectuelle, et/ou un acte de concurrence déloyale et/ou un acte de parasitisme susceptible d'engager la responsabilité des personnes qui s'y sont livrées.


  ## 3 - Licence d'utilisation du contenu de l’application

  Du seul fait de sa connexion à l’Application, l'utilisateur reconnaît accepter du CDOS une licence d'usage du Contenu de l’Application strictement limitée aux conditions impératives suivantes :

  * La présente licence accordée n’est pas transmissible ni cessible.
  * Le droit d'usage conféré à l'utilisateur est personnel et privé : c'est-à-dire que toute reproduction de tout ou partie du Contenu de l’Application sur un quelconque support pour un usage collectif ou professionnel, est prohibée sans autorisation préalable et expresse du CDOS. Il en est de même pour toute communication de ce Contenu par voie électronique, même diffusée en intranet ou en extranet d'entreprise.
  * Cet usage comprend seulement l'autorisation de reproduire pour stockage aux fins de représentation sur écran monoposte et de reproduction en un exemplaire, pour copie de sauvegarde et tirage papier.
  * Tout autre usage est soumis à l'autorisation préalable et expresse du CDOS. La violation de ces dispositions soumet le contrevenant et toutes personnes responsables aux peines pénales et civiles prévues par la loi française.
  
  
  ## 4 - Collecte des données personnelles

  Le responsable du traitement des informations collectées est le CDOS. Pour cette raison, le seul destinataire des données à caractère personnel est le CDOS.
  
  Le CDOS a un intérêt légitime à la collecte de ces données afin de permettre au grand public de se connecter et participer aux différents challenges proposés.
  
  Ces données sont conservées durant 18 mois.

  Nous ne fournissons pas vos données personnelles à des tiers, à moins qu'il ne soit nécessaire de compléter le service que vous avez contracté, notamment auprès de nos éventuels sous-traitants techniques.

  Nous ne fournissons pas vos données personnelles à des tiers, à moins qu'il ne soit nécessaire de compléter le service que vous avez contracté, notamment auprès de nos éventuels sous-traitants techniques.

  Vos données personnelles ne font l’objet d’aucun usage commercial auprès de tiers.

  Même une fois collectées, vous bénéficiez d'un droit d'accès, de rectification, d’effacement et d’opposition, à la limitation du traitement, ou encore à la portabilité de vos données. Vous pouvez également, pour des motifs légitimes, vous opposer au traitement des données vous concernant. Votre demande devra alors être effectuée par courrier électronique à cdos86enjeux@gmail.com.


  ## 5 - Liens hypertextes

  Les liens hypertextes mis en place dans le cadre de la présente Application en direction de sites présents sur le réseau Internet, ne sauraient engager la responsabilité du CDOS.


  ## 6 - Demande d'autorisation de reproduction de tout ou partie du contenu de l’application

  Pour toute reproduction totale ou partielle du Contenu (images, articles, photos, logos, marques, vidéos, interviews, sons, textes, bases de données, newsletters…) sur support électronique (Web, intranet, CD-ROM...) ou sur support papier, une demande doit être adressée par courrier à :

  CDOS 86
  Maison des Sports – 6 allée Jean Monnet
  86000 Poitiers

  Cette demande doit a minima préciser : le contexte, la durée d’autorisation souhaitée, la nature du support, la présentation envisagée, l'identité de la personne qui en fait la demande, de l'association ou l'entreprise qu'elle représente, l'adresse URL du site concerné (s’il s’agit d’un site), ainsi que ses coordonnées incluant son e-mail.


  ## 7 - Virus, piratage et autres infractions

  Le CDOS ne répondra d'aucune perte ni d'aucun dommage de quelque nature que ce soit causés par une attaque par saturation, par des virus ou par d'autres éléments technologiquement nuisibles qui pourraient infecter le matériel informatique de l'utilisateur, ses programmes d'ordinateur, ses données ou autres éléments dus à l'utilisation de l’Application ou au téléchargement de tout document affiché sur celui-ci ou sur tout site web qui lui est relié.


  ## 8 - Accès personnalisé, sécurité

  L'accès à certaines sections de l’Application nécessite l'utilisation d'un identifiant ou login et d'un mot de passe personnels et confidentiels pour chaque utilisateur. Tout usage de ses éléments d'identification par l'utilisateur est fait sous son entière responsabilité. En conséquence, le titulaire s'engage à conserver secrets les éléments constitutifs de son identification (notamment nom d'utilisateur ou login, mot de passe) et à ne pas les divulguer sous quelque forme que ce soit. Il s’engage également à ne pas masquer sa véritable identité, et à ne pas usurper l’identité d’autrui.

  Le CDOS a mis en œuvre des mesures et solutions techniques et organisationnelles destinées à protéger les renseignements personnels des utilisateurs contre une perte accidentelle, un accès et une utilisation non autorisés, l'altération ou la divulgation. Toutefois, Internet étant un système ouvert, le CDOS ne peut garantir que des tiers non autorisés ne soient jamais capables de neutraliser ces mesures ou d'utiliser ces renseignements personnels à des fins illicites. Le cas échéant, la responsabilité du CDOS ne pourra être engagée.

  Il est rappelé que l’accès frauduleux ou le maintien frauduleux dans un système informatique, la falsification, la modification, la suppression et l’introduction d’informations sont considérés comme des délits et relèvent de sanctions pénales.


  ## 9 - Médias

  Les informations du CDOS sont libres de tout droit.

  Les informations figurant sur l’application Vienne en Jeux peuvent être reprises par les médias, sous réserve de citation de la source.


  ## 10 - Responsabilité

  Dans la mesure de ce que la loi permet et des engagements expressément pris par le CDOS, sur l’Application, ni le CDOS ni aucun de ses organismes affiliés, ni ses dirigeants, employés ou autres représentants, ne peuvent être tenus responsables des dommages et l’acceptation des présentes, emporte renonciation à recours. Par dommage on entend toute perte de données, de revenu, de chance ou de profit, ainsi que toute demande émanant de tiers résultant de ou en rapport avec l'utilisation de l’Application, l'information, le contenu, les éléments ou produits présentés sur ladite Application.
  """;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('CGU'),
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
