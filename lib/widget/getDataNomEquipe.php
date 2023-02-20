<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT nom_equipe FROM equipe_marche WHERE id_equipe_marche=$_GET[idequipe]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "nom_equipe"=>utf8_encode($resultsFrom['nom_equipe']),
            )
        );
    }
    echo json_encode($myarray);
   ?>