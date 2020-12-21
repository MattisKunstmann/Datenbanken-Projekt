<?php
$db_link = pg_connect("host=127.0.0.1 port=5432 dbname=arztpraxenanalysetool user=postgres password=Besiktas.76");

         if (!$db_link)//Ist ein Fehler bei der Verbindungsherstellung aufgetreten?
         {
           die ('...keine Verbindung zum DB-Server möglich: ');
           echo pg_last_error($db_link);
         }
		 



?>