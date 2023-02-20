<?php
    require('connect.php');
    $makeQuery = "UPDATE marcher m SET m.nbre_pas=$_GET[nbpas] WHERE m.id_defi_marche=$_GET[iddefi] AND m.id_utilisateur=$_GET[iduser]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    
    $makeQuery = "SELECT * FROM marcher m WHERE m.id_defi_marche=$_GET[iddefi] AND m.id_utilisateur=$_GET[iduser]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "nbre_pas"=>utf8_encode($resultsFrom['nbre_pas']),
                "id_defi_marche"=>utf8_encode($resultsFrom['id_defi_marche']),
                "id_utilisateur"=>utf8_encode($resultsFrom['id_utilisateur']),
            )
        );
    }
    echo json_encode($myarray);
    
   ?>