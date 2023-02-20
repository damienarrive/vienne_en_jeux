<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

//  $db = "vienneencbprod"; //database name
//  $dbuser = "root"; //database username
//  $dbpassword = ""; //database password
//  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["message"] = "";

  require('connect.php');

  $val = isset($_POST["mail_user"]) && isset($_POST["mdp_user"]) && isset($_POST["login_user"]) && isset($_POST["nom_user"]) && isset($_POST["prenom_user"]);
  
  //on verifie qu'on a bien des valeurs
  if($val){
    $mail_user = $_POST["mail_user"];
    $login_user = $_POST["login_user"];
    $prenom_user = $_POST["prenom_user"];
    $nom_user = $_POST["nom_user"];
    $password = $_POST["mdp_user"];
    // cryptage du mot de passe
    $avant = 'FkbFgxdfHGf';
    $apres = 'ffHGbhgHHfvhgcV';
    $password = sha1($avant.$password.$apres);

    // on verifie qu'un utilisateur du meme nom n'existe pas
    $sql = "SELECT * FROM utilisateur WHERE mail_user = '".$mail_user."'";
    $res = $connection -> query($sql);
    $res -> execute();
    $nbCol = $res->rowCount();

    //si c'est bon on inscrit
    if($nbCol == 0){
      $makeQuery = "INSERT INTO utilisateur (login_user, prenom_user, nom_user, mail_user, mdp_user, type_user) VALUES ('".$login_user."', '".$prenom_user."', '".$nom_user."', '".$mail_user."', '".$password."', 1)";
      $statement = $connection->prepare($makeQuery);
      $statement->execute();
      // $myarray = array();
      // while ($resultsFrom = $statement ->fetch()){
      //   array_push(
      //     $myarray,array(
      //       "id_user"=>utf8_encode($resultsFrom['id_user']),
      //       "nom_user"=>utf8_encode($resultsFrom['nom_user']),
      //       "prenom_user"=>utf8_encode($resultsFrom['prenom_user']),
      //       "mail_user"=>utf8_encode($resultsFrom['mail_user']),
      //       "mdp_user"=>utf8_encode($resultsFrom['mdp_user']),
      //     )
      //   );
      // }
    }
    else{// si deja inscrit on retourne l'erreur
      $return["error"] = true;
      $return["message"] = "Cette adresse mail est deja utilisee";
    }
  }
  else{
    $return["error"] = true;
    $return["message"] = 'Send all parameters.';
  }

  
    // mysqli_close($link); //close mysqli
    header('Content-Type: application/json');
    // echo json_encode($myarray);
    // $return["message"] = $_POST;
    echo json_encode($return);

  // String phpurl = "http://127.0.0.1/myApp/Inscription.php";

   ?>
