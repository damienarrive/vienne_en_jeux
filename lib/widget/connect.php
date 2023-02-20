<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    try{
        $connection = new PDO('mysql:host=localhost;dbname=vienneencbprod','root','');
        $connection ->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
        // echo "connected";
    }catch(PDOException $exc){
        // echo $exc ->getMessage();
        die("could not connect");
    }

?>