<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT count(*) FROM marcher WHERE id_defi_marche = '".$_GET['iddefi']."' AND id_utilisateur = '".$_GET['iduser']."'";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    $resultsFrom = $statement ->fetch();
    // while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "count"=>utf8_encode($resultsFrom['count(*)']),
            )
        );
    // }
    echo json_encode($myarray);
?>