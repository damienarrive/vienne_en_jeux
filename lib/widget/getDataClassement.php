<?php

//CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

$return["error"] = false;
$return["message"] = "";

require('connect.php');
$makeQuery = "SELECT * FROM equipe_marche ORDER BY classement ASC";
$statement = $connection->query($makeQuery);
$statement->execute();
$myarray = array();
$nbCol = $statement->rowCount();
if($nbCol > 0){
    while ($resultsFrom = $statement ->fetch()){
        array_push(
            $myarray,array(
                "id_equipe_marche"=>utf8_encode($resultsFrom['id_equipe_marche']),
                "nom_equipe"=>utf8_encode($resultsFrom['nom_equipe']),
                "nbre_pas_equipe"=>utf8_encode($resultsFrom['nbre_pas_equipe']),
                "bonus_equipe"=>utf8_encode($resultsFrom['bonus_equipe']),
                "score_equipe"=>utf8_encode($resultsFrom['score_equipe']),
                "classement"=>utf8_encode($resultsFrom['classement']),
            )
        );
    }
}
else{
    $return["error"] = true;
    $return["message"] = "aucune ligne";
}

header('Content-Type: application/json');

echo json_encode($myarray);
?>