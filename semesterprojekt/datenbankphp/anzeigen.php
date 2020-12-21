<?php
         echo'<html><head><meta http-equiv="content-type" content="text/html; charset=utf-8"></head></html>';

         /* An Server anmelden und Datenbank aufrufen */
         $db_link = pg_connect("host=127.0.0.1 port=5432 dbname=ersteDB user=postgres password=Besiktas.76");

         if (!$db_link)//Ist ein Fehler bei der Verbindungsherstellung aufgetreten?
         {
           die ('...keine Verbindung zum DB-Server möglich: ');
           echo pg_last_error($db_link);
         }

         /* Ausgabe der kompletten Tabelle */
         $result=pg_query($db_link, "SELECT * FROM aktivitaeten order by datum asc"); //SQL-Anfrageergebnis im assoziatiuven Array $z speichern

         echo "<table border = 2>";
         echo "<tr><td>ID</td><td>Datum</td><td>Art</td><td>Dauer</td></tr>"; //Überschriften
         while($row=pg_fetch_array($result)) //Array zeilenweise auslesen, so lange wie Daten vorhanden
         {
         echo "<tr>";
         echo "<td>$row[0]</td>";        //Ausgabe der Inhalte des gelesenen Datensatzes ueber Spaltenname
         echo "<td>$row[1]</td>";
         echo "<td>$row[2]</td>";
         echo "<td>$row[3]</td>";
         echo "</tr>";
         }
         echo "</table>";

         pg_close(); //Schließen der Verbindung zur Datenbank
?>

<html>
  <head>
     <title>Datens&auml;tze anzeigen</title>
     <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>

  <body>
     <table>
         <form action="bearbeiten.php" method="GET">
            <tr>
                <td>Zu &auml;ndernder Datensatz (ID):</td>
                <td><input type="text" size="2" name="update_id" /></td>
            </tr>
            <tr>
                <td><input type="submit" name="Speichern" value="&Auml;nderung beauftragen" /></td>
            </tr>
         </form>
     </table>
	 <a href='index.php'/>zur&uumlck
  </body>
</html>