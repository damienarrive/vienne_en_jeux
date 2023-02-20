<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    require('connect.php');
    $makeQuery = "INSERT INTO marcher values ($_GET[iddefi], $_GET[iduser], 'ok', 0, 0, 0, null)";
    $statement = $connection->prepare($makeQuery);
    $statement->execute();
?>