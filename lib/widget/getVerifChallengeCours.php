<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT count(*) FROM defi_marche WHERE statut_marche = 'En cours' ";
    $statement = $connection->query($makeQuery);
    $statement->execute();
    $myarray = array();
    $resultsFrom = $statement ->fetch();
    // while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                // "count"=>utf8_encode($resultsFrom['count(*)']),
                "count"=> $resultsFrom['count(*)'],
            )
        );
    // }
    echo json_encode($myarray);
?>