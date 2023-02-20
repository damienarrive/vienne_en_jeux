<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT id_defi_marche, nom_defi_marche, date_fin_marche FROM defi_marche WHERE statut_marche = 'En cours' ";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    // while ($resultsFrom = $statement ->fetch()){
        array_push($myarray, $statement ->fetch()
            // $myarray,array(
            //     "id_defi_marche"=>utf8_encode($resultsFrom['id_defi_marche']),
            //     "nom_defi_marche"=>utf8_encode($resultsFrom['nom_defi_marche']),
            //     "date_fin_marche"=>utf8_encode($resultsFrom['date_fin_marche']),
            // )
        );
    // }
    echo json_encode($myarray);
?>