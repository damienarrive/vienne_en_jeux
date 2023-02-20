<?php

    //CE FICHIER EST A METTRE DANS UWAMP/www/myApp/

    try{
        $connection = new PDO('mysql:host=192.168.1.230;dbname=vienneencbprod','root','root');
        $connection ->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
        //echo "connected";
    }catch(PDOException $exc){
        echo $exc ->getMessage();
        die("could not connect");
    }

?>