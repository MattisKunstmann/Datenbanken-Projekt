<!DOCTYPE HTML>
<html>
  <head>
     <title>Standardaktionen erfassen</title>
     <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>

  <body>
     <h2>Bitte hier Standardaktionen eintragen:</h2>
     <table>
         <form action="aktionen.php" method="GET">
            <tr>
                <td>Beschreibung:</td>
                <td><input type="text" name="eintrag" /></td>
            </tr>
            <tr>
                <td><input type="submit" name="Speichern" value="Datensatz speichern" /></td>
            </tr>
         </form>
         <form action="aktionen.php" method="GET">
            <tr>
                <td><input type="submit" name="Anzeige" value="Alle Eintr&auml;ge anzeigen..." /></td>
            </tr>
         </form>
            <tr></tr>
            <tr>
                <td><a href="index.php"/>zur&uumlck</td>
            </tr>
     </table>
  </body>
</html>

<?php

   if($_GET[Speichern])//Wurde der submit-Button des Formulars gedrueckt?
   {
         /* An Server anmelden und Datenbank aufrufen */
         $db_link = pg_connect("host=127.0.0.1 port=5432 dbname=ersteDB user=postgres password=Besiktas.76");

         if (!$db_link)//Ist ein Fehler bei der Verbindungsherstellung aufgetreten?
         {
           die ('...keine Verbindung zum DB-Server möglich: ');
           echo pg_last_error($db_link);
         }

         $sql = "INSERT INTO aktionen (aktion) VALUES ('$_GET[eintrag]')"; //Datensatz in die Tabelle schreiben!!!
         $result = pg_query($db_link, $sql); //Anfrage durchfuehren und Ergebnis in $result speichern

         if (!$result)//Ist ein Fehler bei der Einfuegeoperation aufgetreten?
         {
           die ('...Konnte Datensatz nicht speichern: ');
           echo pg_last_error($result);
         }

         pg_close(); //Schließen der Verbindung zur Datenbank
   }

   if($_GET[Anzeige])//Wurde der submit-Button des Formulars gedrueckt?
   {
         /* An Server anmelden und Datenbank aufrufen */
         $db_link = pg_connect("host=127.0.0.1 port=5432 dbname=ersteDB user=postgres password=Besiktas.76");

         if (!$db_link)//Ist ein Fehler bei der Verbindungsherstellung aufgetreten?
         {
           die ('...keine Verbindung zum DB-Server möglich: ');
           echo pg_last_error($db_link);
         }

         /* Ausgabe der kompletten Tabelle  */
         $result=pg_query($db_link, "SELECT * FROM aktionen"); //SQL-Anfrageergebnis im assoziatiuven Array $z speichern

         echo "<table>";
         while($row=pg_fetch_array($result)) //Array zeilenweise auslesen, so lange wie Daten vorhanden
         {
         echo "<tr>";
         echo "<td>$row[0]</td>";        //Ausgabe der Inhalte des gelesenen Datensatzes ueber Spaltenname
         echo "<td>$row[1]</td>";
         echo "</tr>";
         }
         echo "</table>";

         pg_close(); //Schließen der Verbindung zur Datenbank
   }
?>