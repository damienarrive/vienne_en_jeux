<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "UPDATE bonus_connection_marche bcm SET bcm.recupere=true WHERE bcm.id_defi_marche=$_GET[iddefi] AND bcm.id_utilisateur=$_GET[iduser] AND bcm.date=$_GET[date]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
   ?>