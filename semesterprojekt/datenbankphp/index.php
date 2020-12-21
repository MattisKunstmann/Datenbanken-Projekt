<?php

   $db_link = pg_connect("host=127.0.0.1 port=5432 dbname=ersteDB user=postgres password=Besiktas.76");

         if (!$db_link)//Ist ein Fehler bei der Verbindungsherstellung aufgetreten?
         {
           die ('...keine Verbindung zum DB-Server möglich: ');
           echo pg_last_error($db_link);
         }
?>

<!DOCTYPE HTML>
<html>
  <head>
     <title>Zetmanagement</title>
     <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>

  <body>
     <h2>Erfassung einer neuen Aktivitaet:</h2>
     <table>
         <form action="index.php" method="GET">
            <tr>
                <td>Datum (Tag / Monat / Jahr):</td>
                <td><input type="text" name="tag" size="1" maxlength="2" />
                    <input type="text" name="monat" size="1" maxlength="2" />
                    <input type="text" name="jahr" size="2" maxlength="4" />
                </td>
            </tr>
            <tr>
                <td>Aktivitaet:</td>
                <td><select size="1" maxlength="20" name="aktion">
                <?php $sql = "SELECT * FROM aktionen";
                      $result = pg_query($db_link, $sql);
                      while($row = pg_fetch_array($result))
                      {
                         echo '<option value="'.$row[0].'">'.$row[1].'</option>';
                      } ?>
                </select>
                </td>
            </tr>
            <tr>
                <td>Zeitbedarf:</td>
                <td><input type="text" name="dauer" value="0.00" /></td>
            </tr>
            <tr>
                <td><input type="submit" name="Speichern" value="Datensatz speichern" /></td>
            </tr>
         </form>
         <tr></tr>
         <tr>
                <td><a href="aktionen.php"/>neue Standardaktion erfassen</td>
         </tr>
         <tr>
                <td><a href="anzeigen.php"/>Alle Eintraege anzeigen</td>
         </tr>
     </table>
  </body>
</html>

<?php
   if($_GET[Speichern])//Wurde der submit-Button des Formulars gedrueckt?
   {
         //Datum zusammenfügen
         $tag = $_GET[tag];
         $monat = $_GET[monat];
         $jahr = $_GET[jahr];
         $datum = $jahr."-".$monat."-".$tag;

         //Datensatz in die Tabelle schreiben!!!
         $sql = "INSERT INTO aktivitaeten ";
         $sql .= "(datum, aktion, dauer) ";
         $sql .= "VALUES ('$datum', '$_GET[aktion]', '$_GET[dauer]')";

         $result = pg_query($db_link, $sql); //Anfrage durchfuehren und Ergebnis in $result speichern

         if (!$result)//Ist ein Fehler bei der Einfuegeoperation aufgetreten?
         {
           die ('...Konnte Datensatz nicht speichern: ');
           echo pg_last_error($result);
         }

         pg_close(); //Schließen der Verbindung zur Datenbank
   }
?>