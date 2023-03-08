<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "UPDATE bonus_recuperation_marche SET recupere=true WHERE id_defi_marche=$_GET[iddefi] AND id_utilisateur=$_GET[iduser] AND id_bonus_marche=$_GET[idbonus]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
   ?>