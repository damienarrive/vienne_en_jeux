<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT bm.palier_pas, bm.bonus, brm.recupere, ma.nbre_pas FROM bonus_marche bm JOIN bonus_recuperation_marche brm USING(id_bonus_marche) JOIN marcher ma USING(id_utilisateur) WHERE ma.id_utilisateur=$_GET[iduser] AND ma.id_defi_marche=$_GET[iddefi]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "palier_pas"=>utf8_encode($resultsFrom['palier_pas']),
                "bonus"=>utf8_encode($resultsFrom['bonus']),
                "recupere"=>utf8_encode($resultsFrom['recupere']),
                "nbre_pas"=>utf8_encode($resultsFrom['nbre_pas']),
            )
        );
    }
    echo json_encode($myarray);
   ?>