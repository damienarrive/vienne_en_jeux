<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT * FROM defi_marche dm JOIN marcher ma USING(id_defi_marche) JOIN utilisateur ut ON ma.id_utilisateur=ut.id_user WHERE ma.id_utilisateur=$_GET[iduser] AND ma.id_defi_marche=$_GET[iddefi]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "nom_defi_marche"=>utf8_encode($resultsFrom['nom_defi_marche']),
                "date_debut_marche"=>utf8_encode($resultsFrom['date_debut_marche']),
                "date_fin_marche"=>utf8_encode($resultsFrom['date_fin_marche']),
                "nbre_pas"=>utf8_encode($resultsFrom['nbre_pas']),
                "id_equipe_marche"=>utf8_encode($resultsFrom['id_equipe_marche']),
                "login_user"=>utf8_encode($resultsFrom['login_user']),
                "bonus"=>utf8_encode($resultsFrom['bonus']),
                "score"=>utf8_encode($resultsFrom['score']),
            )
        );
    }
    echo json_encode($myarray);
   ?>