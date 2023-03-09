<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT nom_equipe, classement, score_equipe FROM equipe_marche JOIN marcher USING(id_equipe_marche) WHERE id_utilisateur=$_GET[id]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "nom_equipe"=>utf8_encode($resultsFrom['nom_equipe']),
                "classement"=>utf8_encode($resultsFrom['classement']),
                "score_equipe"=>utf8_encode($resultsFrom['score_equipe']),
            )
        );
    }
    echo json_encode($myarray);
   ?>