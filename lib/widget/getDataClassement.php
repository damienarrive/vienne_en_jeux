<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT * FROM equipe_marche";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "id_equipe_marche"=>utf8_encode($resultsFrom['id_equipe_marche']),
                "nom_equipe"=>utf8_encode($resultsFrom['nom_equipe']),
                "nbre_pas_equipe"=>utf8_encode($resultsFrom['nbre_pas_equipe']),
                "bonus_equipe"=>utf8_encode($resultsFrom['bonus_equipe']),
                "score_equipe"=>utf8_encode($resultsFrom['score_equipe']),
                "classement"=>utf8_encode($resultsFrom['classement']),
            )
        );
    }
    echo json_encode($myarray);
   ?>