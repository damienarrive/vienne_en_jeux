<?php

//   $db = "vienneencbprod"; //database name
//   $dbuser = "root"; //database username
//   $dbpassword = ""; //database password
//   $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["message"] = "";


  require('connect.php');


  $val = isset($_POST["mail_user"]) && isset($_POST["mdp_user"]);

//   $val = isset($_POST["nom_user"]) && isset($_POST["prenom_user"])
//          && isset($_POST["mail_user"]) && isset($_POST["login_user"]);



  if($val){
    $mail_user = $_POST["mail_user"];
    $password = $_POST["mdp_user"];
    $avant = 'FkbFgxdfHGf';
    $apres = 'ffHGbhgHHfvhgcV';
    $password = sha1($avant.$password.$apres);

    // requete sql pour l'inscription test
    // $sql = "INSERT INTO utilisateur SET
    //                     nom_user = '$nom_user',
    //                     prenom_user = '$prenom_user',
    //                     mail_user = '$mail_user',
    //                     login_user = '$login_user'";

    // requete sql pour voir si l'utilisateur existe deja
    $sql = "SELECT * FROM utilisateur WHERE mail_user = '".$mail_user."' AND mdp_user = '".$password."' ";

    $res = $connection -> query($sql);
    $res -> execute();


    $nbCol = $res->rowCount();

    if($nbCol == 1){
      $sql2 = "SELECT * FROM utilisateur WHERE mail_user = '".$mail_user."' AND mdp_user = '".$password."' AND valide=1 ";
      if($res2 = $connection->query($sql2)){
        $nbCol2 = $res2->rowCount();
        if($nbCol2 == 1){
          //write success
          $return["error"];
          $return["message"] = "success";
        }
        else{
          $return["error"] = true;
          $return["message"] = "Veuillez verrifier votre compte";
        }
      }
      else{
        $return["error"] = true;
        $return["message"] = "Requete 2 ne marche pas";
      }
    }else{
        $return["error"] = true;
        $return["message"] = "nope";
    }
  }else{
    $return["error"] = true;
    $return["message"] = 'Send all parameters.';
  }


  header('Content-Type: application/json');
  // tell browser that its a json data
  echo json_encode($return);
  //converting array to JSON string

?>