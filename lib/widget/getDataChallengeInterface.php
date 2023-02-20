<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    $return["error"] = false;
    $return["message"] = "";

    require('connect.php');


    //defi marche en cours pas par rapport a un id
    $makeQuery = "SELECT * FROM defi_marche dm JOIN marcher ma USING(id_defi_marche) JOIN utilisateur ut ON ma.id_utilisateur=ut.id_user WHERE ma.id_utilisateur='".$_GET['iduser']."' AND ma.id_defi_marche='".$_GET['iddefi']."'";
    $statement = $connection->query($makeQuery);
    $statement->execute();
    $myarray = array();
    $nbCol = $statement->rowCount();
    if($nbCol > 0 ){
        // while ($resultsFrom = $statement ->fetch()){
            array_push($myarray, $statement->fetch()
                // $myarray,array(
                //     "nom_defi_marche"=>mb_convert_encoding($resultsFrom['nom_defi_marche'], 'UTF-8', 'ISO-8859-1'),
                //     "date_debut_marche"=>mb_convert_encoding($resultsFrom['date_debut_marche'], 'UTF-8', 'ISO-8859-1'),
                //     "date_fin_marche"=>mb_convert_encoding($resultsFrom['date_fin_marche'], 'UTF-8', 'ISO-8859-1'),
                //     "nbre_pas"=>mb_convert_encoding($resultsFrom['nbre_pas'], 'UTF-8', 'ISO-8859-1'),
                //     "id_equipe_marche"=>mb_convert_encoding($resultsFrom['id_equipe_marche'], 'UTF-8', 'ISO-8859-1'),
                //     "login_user"=>mb_convert_encoding($resultsFrom['login_user'], 'UTF-8', 'ISO-8859-1'),
                //     "bonus"=>mb_convert_encoding($resultsFrom['bonus'], 'UTF-8', 'ISO-8859-1'),
                //     "score"=>mb_convert_encoding($resultsFrom['score'], 'UTF-8', 'ISO-8859-1'),
                // )
            );
        // }
    }   
    else{
        $return["error"] = true;
        $return["message"] = "aucune ligne";
    }
    
    $tab = json_encode($myarray);
    header('Content-Type: application/json');
    
    echo $tab;
   ?>