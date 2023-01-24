<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT * FROM athlete";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "id_athlete"=>utf8_encode($resultsFrom['id_athlete']),
                "prenom_athlete"=>utf8_encode($resultsFrom['prenom_athlete']),
            )
        );
    }
    echo json_encode($myarray);
   ?>