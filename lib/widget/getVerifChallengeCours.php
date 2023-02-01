<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT count(*) FROM defi_marche WHERE statut_marche = 'En cours' ";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "count"=>utf8_encode($resultsFrom['count(*)']),
            )
        );
    }
    echo json_encode($myarray);
   ?>