<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "SELECT (SELECT count(*) FROM marcher WHERE id_defi_marche=$_GET[iddefi]) tot, (SELECT count(*) FROM marcher WHERE id_defi_marche=$_GET[iddefi] AND id_equipe_marche is not null) eq, nom_defi_marche, login_user, id_equipe_marche FROM marcher ma JOIN defi_marche USING (id_defi_marche) JOIN utilisateur ut on ut.id_user=ma.id_utilisateur";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
    $myarray = array();
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "tot"=>utf8_encode($resultsFrom['tot']),
                "eq"=>utf8_encode($resultsFrom['eq']),
                "nom_defi_marche"=>utf8_encode($resultsFrom['nom_defi_marche']),
                "id_equipe_marche"=>utf8_encode($resultsFrom['id_equipe_marche']),
                "login_user"=>utf8_encode($resultsFrom['login_user']),
            )
        );
    }
    echo json_encode($myarray);
   ?>