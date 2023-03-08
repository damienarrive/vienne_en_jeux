<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "UPDATE marcher SET nbre_pas=$_GET[pas] WHERE id_defi_marche=$_GET[iddefi] AND id_utilisateur=$_GET[iduser]";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
   ?>