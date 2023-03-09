<?php
    // /!\ CE FICHIER NE DOIT PAS COMMENCER PAR UNE MAJUSCULE
    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT recupere FROM bonus_connection_marche WHERE id_utilisateur=$_GET[iduser] AND id_defi_marche=$_GET[iddefi] AND date=$_GET[date]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "recupere"=>utf8_encode($resultsFrom['recupere']),
            )
        );
    }
    echo json_encode($myarray);
   ?>