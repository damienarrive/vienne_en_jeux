import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:vienne_en_jeux/widget/connexion_button_widget.dart';
import 'package:vienne_en_jeux/widget/navigation_drawer_widget.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class PagePolitiqueConf extends StatefulWidget {
  const PagePolitiqueConf({super.key});

  @override
  _PagePolitiqueConfState createState() => _PagePolitiqueConfState();
}

class _PagePolitiqueConfState extends State<PagePolitiqueConf> {
  final String _markdownData = """
  # **Politique de confidentialité**

  ## 1. Introduction

  La protection de vos données personnelles est importante pour nous. Nous nous engageons à ne collecter que les données dont nous avons besoin pour vous assurer un service optimal, à en assurer la confidentialité et la sécurité et à faciliter l’exercice de vos droits sur vos données.
  
  Nous respectons ainsi l’ensemble des dispositions applicables en matière de protection de la vie privée et des données à caractère personnel, notamment la loi du 6 janvier 1978 modifiée relative à l’informatique, aux fichiers et aux libertés ainsi que le Règlement UE 2016/679 du 27 avril 2016 relatif à la protection des personnes physiques à l’égard du traitement des données à caractère personnel et à la libre circulation de ces données.

  La présente politique de confidentialité décrit les données personnelles que nous recueillons, comment elles sont utilisées et vos droits à cet égard. Elle s’applique à tout utilisateur qui accède à l’application (web ou mobile) et qui utilise les services proposés sur l’application.

  Nous nous réservons le droit de modifier la présente politique de confidentialité à tout moment. La version la plus actuelle de la présente politique régit notre utilisation de vos informations et sera toujours disponible sur l’application ou sur demande auprès du CDOS du département de la Vienne.

  Si nous devions apporter une modification substantielle à cette politique de confidentialité, nous nous engageons à vous la notifier via votre adresse email.


  ## 2. Responsable de traitement des données

  CDOS de la Vienne\n
  Organisme à but non lucratif\n
  6 Allée Jean Monnet, 86000 Poitiers


  ## 3. Données que nous collectons

  Dans le cadre de l’utilisation de nos services et de votre navigation sur notre application, le CDOS de la Vienne collecte plusieurs catégories de données dont vous trouverez le détail ci-dessous. Ces données proviennent :

  - Dans le cadre de l’utilisation de nos services et de votre navigation sur notre application, le CDOS de la Vienne collecte plusieurs catégories de données dont vous trouverez le détail ci-dessous. Ces données proviennent :
    * Des données permettant votre identification (nom, prénom, email, mot de passe)
  - Des informations nécessaires pour participer à certains challenges proposées par l’application. Ces informations sont :
    * L’identifiant de connexion Google si vous vous connectez via votre compte Google
    * Des données de localisation
    * Des données concernant le nombre de pas que vous avez effectuées et la distance que vous avez parcouru si vous donnez votre autorisation

  Nous vous demandons l’autorisation pour collecter sur notre application les données précises de localisation de votre mobile via le système d’autorisation que le système d’exploitation de votre mobile utilise. Si vous autorisez la collecte de ces données, vous pouvez revenir ultérieurement sur votre choix en changeant les paramètres de localisation de votre téléphone portable. Cependant, cela limitera votre capacité à utiliser certaines fonctionnalités de nos services.

  Nous ne collectons ni ne traitons aucune donnée particulière (données sensibles) telles que les données énumérées à l’article 9 du RGPD qui révèlent l’origine ethnique, les opinions politiques, les convictions religieuses ou philosophiques ou l’appartenance syndicale, des données génétiques, des données biométriques, des données concernant la santé ou des données concernant la vie sexuelle ou l’orientation sexuelle des personnes.


  ## 4. Finalités

  Le CDOS de la Vienne procède au traitement de vos données à caractère personnel pour des finalités déterminées, explicites et légitimes.

  En particulier, ces données sont destinées à :

  * la création et la gestion de votre compte;
  * l’utilisation de nos services;
  * sécuriser le site ainsi que les données et échanges intervenant sur le site;
  * communiquer avec vous;


  ## 5. Base juridique des traitements

  Le CDOS de la Vienne traite la plupart de vos données personnelles dans le cadre du contrat que vous avez conclu lors de votre inscription sur l’application via l’acceptation de nos conditions générales d’utilisation. Toutefois, nous sommes susceptibles de traiter certaines données vous concernant sur la base de votre consentement, en raison d’obligations légales ou pour répondre à notre intérêt légitime à les traiter.


  ## 6. Destinataires ou catégories de destinataires

  Le CDOS de la Vienne est destinataire des données à caractère personnelle recueillies.

  Nous pourrions également être susceptibles de partager certaines informations pour des raisons juridiques ou en cas de litige.

  Enfin, nous ne communiquons vos données personnelles à des entreprises ou des personnes tierces que dans les circonstances suivantes :

  * Lorsque cela est nécessaire pour des besoins de traitement externe, et uniquement dans ce cas, nous transmettons ces données à nos prestataires de confiance qui les traitent pour notre compte, selon nos instructions ou selon un accord contractuel, conformément à la présente politique de confidentialité et dans le respect de toute autre mesure appropriée de sécurité et de confidentialité. Nous sommes susceptibles de leur transmettre vos données personnelles uniquement pour les finalités énoncées ci-dessous. Ainsi, nous faisons notamment appel à nos prestataires chargés d’assurer l’hébergement et la sécurité de nos systèmes d’information et de notre site (notamment OVH)
  
  La liste de nos sous-traitants peut vous être communiquée en adressant votre demande à cdos86enjeux@gmail.com.

  * Nous conservons ou divulguons vos informations si nous estimons que cela est raisonnablement nécessaire pour satisfaire à toute obligation légale ou réglementaire, toute procédure juridique ou demande administrative, pour protéger la sécurité d’une personne, pour traiter tout problème de nature frauduleuse, sécuritaire ou technique, ou pour protéger les droits ou les biens de nos utilisateurs.

  Le CDOS de la Vienne ne revend pas vos données et ne transmettra jamais vos données personnelles à aucun tiers susceptible de les utiliser à ses propres fins et notamment à des fins commerciales et/ou de publicité directe, sans votre consentement exprès. Par conséquent, le CDOS de la Vienne ne divulgue pas d’informations personnelles en dehors des situations décrites dans la présente politique de confidentialité.


  ## 7. Transfert des données hors UE

  Tous nos serveurs sur lesquels vos données sont conservées et ceux des prestataires utilisés pour échanger et stocker ces données sont localisés en Europe.

  Dans l’hypothèse où le CDOS de la Vienne aurait recours à des sous-traitants situés en dehors de l’Union européenne, elle s’engage à s’assurer que ses sous-traitants présentent des mesures de protection reconnues comme suffisantes au sens du RGPD. Il peut notamment s’agir de sous-traitants situés dans tout autre pays reconnu par l’Union européenne comme assurant un niveau de protection adéquat des données à caractère personnel (« Décision d’adéquation »), faisant l’objet d'un accord de transfert de données conforme aux clauses contractuelles types adoptées par la Commission Européenne ou, tout autre mesure de protection reconnue comme suffisante par la Commission Européenne.


  ## 8. Durée de conservation des données

  Le CDOS de la Vienne conserve vos informations tant que votre compte reste actif, à moins que vous ne demandiez leur suppression ou celle de votre compte. Dans certains cas, nous pouvons conserver des informations vous concernant en raison de la loi ou à d’autres fins, même si vous supprimez votre compte.

  Ainsi, les données utilisées à des fins de prospection commerciale peuvent être conservées pendant un délai de cinq ans à compter de la suppression de votre compte, sauf si vous avez décidé de faire jouer votre droit d’opposition dans les conditions prévues à l’article 10.

  Par ailleurs, les données permettant d’établir la preuve d’un droit ou d’un contrat, ou conservées au titre du respect d’une obligation légale, peuvent faire l’objet d’une politique d’archivage intermédiaire pour une période correspondant aux durée de prescription légale (et notamment le délai de droit commun de cinq ans).


  ## 9. Sécurité des données

  Le CDOS de la Vienne met en œuvre les mesures techniques et organisationnelles appropriées afin de garantir la sécurité, la confidentialité, l’intégrité et la disponibilité des services et protéger les données contre la destruction, la perte, l’altération, la divulgation non autorisée de données à caractère personnel transmises, conservées ou traitées d’une autre manière, ou l’accès non autorisé à de telles données.

  Le CDOS de la Vienne s’engage à mettre en œuvre tous les moyens disponibles pour assurer la sécurité et la confidentialité de ces données, en particulier :

  * Nous chiffrons la plupart de nos services à l’aide de la technologie https ;
  * L’accès à votre compte se fait au moyen d’un identifiant et d’un mot de passe sécurisé ;
  * L’accès aux données personnelles est strictement réservé aux salariés et prestataires du CDOS de la Vienne qui ont besoin d’y accéder afin de les traiter en notre nom. Ces personnes sont soumises à de strictes obligations de confidentialité.


  ## 10. Vos droits

  Conformément à la réglementation sur les données personnelles, vous disposez d’un droit :

  * d’accès (article 15 du RGPD),
  * de rectification (article 16 du RGPD),
  * d’effacement (article 17 du RGPD),
  * de limitation du traitement (article 18 du RGPD),
  * de portabilité (article 20 du RGPD),
  * d’opposition (article 21 et 22 du RGPD),


  ### **Droits d’accès**

  Vous avez la possibilité d’obtenir du CDOS de la Vienne la confirmation que les données vous concernant sont ou ne sont pas traitées et, lorsqu’elles le sont, l’accès auxdites données ainsi que les informations suivantes :

  * les finalités du traitement ;
  * les catégories de données ;
  * les destinataires ou catégories de destinataires auxquels les données ont été ou seront communiquées ;
  * lorsque cela est possible, la durée de conservation des données envisagée ou, lorsque ce n’est pas possible, les critères utilisés pour déterminer cette durée ;
  * l’existence du droit de demander au CDOS de la Vienne la rectification ou l’effacement de données, ou une limitation du traitement de vos données, ou du droit de s’opposer à ce traitement ;
  * le droit d’introduire une réclamation auprès de la CNIL ;
  * lorsque les données ne sont pas collectées auprès de vous, toute information disponible quant à leur source ; l’existence d’une prise de décision automatisée, y compris un profilage, et, au moins en pareils cas, des informations utiles concernant la logique sous-jacente, ainsi que l’importance et les conséquences prévues de ce traitement pour vous.

  Lorsque les données sont transférées vers un pays tiers ou à une organisation internationale, vous avez le droit d’être informé des garanties appropriées, en ce qui concerne ce transfert.

  Votre droit d’obtenir une copie de vos données ne doit pas porter pas atteinte aux droits et libertés d’autrui.

  Notez que vous n'avez pas besoin de payer des frais pour accéder à vos données personnelles ou exercer vos droits. Cependant, nous pourrions exiger des frais raisonnables si votre demande était manifestement infondée, répétitive ou excessive


  ### **Droits de rectification**
 
  Vous avez la possibilité d’obtenir du CDOS de la Vienne, dans les meilleurs délais, la rectification des données vous concernant qui sont inexactes. Vous avez également la possibilité d’obtenir que les données incomplètes soient complétées, y compris en fournissant une déclaration complémentaire.

  Afin de vous permettre d’exercer le plus facilement possible ce droit, nous vous invitons à procéder directement à ces modifications et compléments sur votre compte. Si vous estimez que d’autres données vous concernant doivent être modifiées ou complétées et que vous ne parvenez pas à effectuer ce changement par vous-même, nous vous invitons à en faire la demande directement auprès de nous en nous contactant.


  ### **Droits à l’effacement**

  Vous avez la possibilité d’obtenir du CDOS de la Vienne l’effacement, dans les meilleurs délais, de données vous concernant lorsque l’un des motifs suivants s’applique :

  * les données ne sont plus nécessaires au regard des finalités pour lesquelles elles ont été collectées ou traitées d’une autre manière par le CDOS de la Vienne ;
  * vous avez retiré votre consentement pour le traitement de ces données et il n’existe pas d’autre fondement juridique au traitement ;
  * vous exercez votre droit d’opposition dans les conditions rappelées ci-après et il n’existe pas de motif légitime impérieux pour le traitement ;
  * les données ont fait l’objet d’un traitement illicite ;
  * les données doivent être effacées pour respecter une obligation légale ;
  * les données ont été collectées auprès d’un enfant.


  ### **Droits à la limitation**

  Vous avez la possibilité d’obtenir du CDOS la limitation du traitement de vos données lorsque l’un des motifs suivants s’applique :

  * le CDOS de la Vienne vérifie l’exactitude des données suite à votre contestation de l’exactitude des données ;
  * le traitement est illicite et vous vous opposez à l’effacement des données et exigez à la place la limitation de leur utilisation ;
  * le CDOS de la Vienne n’a plus besoin des données aux fins du traitement mais celles-ci vous sont encore nécessaires pour la constatation, l’exercice ou la défense de droits en justice ;
  * vous vous êtes opposés au traitement dans les conditions rappelées ci-après et le CDOS de la Vienne vérifie si les motifs légitimes poursuivis prévalent sur vos motifs allégués.


  ### **Droit à la portabilité des données**

  Vous avez la possibilité de recevoir du CDOS de la Vienne les données vous concernant, dans un format structuré, couramment utilisé et lisible par machine.

  Lorsque vous exercez votre droit à la portabilité vous avez le droit d’obtenir que les données soient transmises directement par le CDOS de la Vienne à un responsable de traitement que vous désignerez lorsque cela est techniquement possible.

  Votre droit à la portabilité de vos données ne doit pas porter atteinte aux droits et libertés d’autrui.


  ### **Droit d’opposition**

  Vous avez le droit de vous opposer à tout moment, pour des raisons tenant à votre situation particulière, à un traitement des données vous concernant fondé sur l’intérêt légitime du CDOS de la Vienne. Le CDOS de la Vienne ne traitera alors plus les données, à moins qu’elle ne démontre qu’il existe des motifs légitimes et impérieux pour le traitement qui prévalent sur vos intérêts et vos droits et libertés, ou pourra les conserver pour la constatation, l’exercice ou la défense de droits en justice.

  Vous pouvez vous opposer à l’envoi de communications. Nous mettons à cette fin à votre disposition plusieurs liens de désinscription sur tous les courriels que nous vous adressons.

  Nous pouvons par ailleurs être amenés à vous contacter pour vous demander des informations complémentaires par rapport à votre demande afin de vous répondre. Toute réponse vous sera d’ailleurs apportée dans un délai d’un mois. Exceptionnellement, il serait possible que nous excédions ce délai d’un mois si votre demande était particulièrement complexe.


  ## 13. Droit d'introduire un recours auprès d'une autorité de contrôle

  L’autorité de contrôle compétente pour connaître de toute demande nous concernant, est la Commission Nationale de l’Informatique et des Libertés (CNIL).Si souhaitez saisir la CNIL de toute demande, vous trouverez ci-dessous les coordonnées:

  CNIL (COMMISSION NATIONALE DE L’INFORMATIQUE ET DES LIBERTÉS)\n
  3 Place de Fontenoy – TSA 80715 – 75334 PARIS CEDEX 07\n
  Tél. : 01 53 73 22 22\n
  (du lundi au jeudi de 9h à 18h30 / le vendredi de 9h à 18h)\n
  Fax : 01 53 73 22 00\n
  Si vous souhaitez déposer une plainte auprès de la CNIL, vous pouvez renseigner le formulaire de dépôt de plainte en ligne disponible à l’adresse suivante : [https://www.cnil.fr/fr/plaintes](https://www.cnil.fr/fr/plaintes).

  Si vous avez une question sur vos droits informatique et libertés, vous pouvez consulter le site de la CNIL : [www.cnil.fr](https://www.cnil.fr/).
  """;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Politique de Confidentialité'),
        elevation: 0,
          actions : <Widget>[
            ConnexionButtonWidget(),
          ]
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
