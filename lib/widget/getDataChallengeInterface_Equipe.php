<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT nom_equipe, score_equipe, bonus_equipe FROM defi_marche dm JOIN marcher ma USING(id_defi_marche) JOIN equipe_marche using(id_equipe_marche) WHERE ma.id_utilisateur='".$_GET['iduser']."' AND ma.id_defi_marche='".$_GET['iddefi']."'";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    array_push($myarray, $statement ->fetch());
    // while ($resultsFrom = $statement ->fetch()){
    //     array_push(
    //         $myarray,array(
    //             "nom_equipe"=>utf8_encode($resultsFrom['nom_equipe']),
    //             "score_equipe"=>utf8_encode($resultsFrom['score_equipe']),
    //             "bonus_equipe"=>utf8_encode($resultsFrom['bonus_equipe']),
    //         )
    //     );
    // }
    echo json_encode($myarray);
?>