<?php
$db_link = pg_connect("host=127.0.0.1 port=5432 dbname=ersteDB user=postgres password=Besiktas.76");

         if (!$db_link)//Ist ein Fehler bei der Verbindungsherstellung aufgetreten?
         {
           die ('...keine Verbindung zum DB-Server möglich: ');
           echo pg_last_error($db_link);
         }

if (!$_GET[aendern])
{
  //Lesen der ID des zu ändernden Datensatzes aus dem Formular
  $id = $_GET[update_id]; 
  echo "Änderung an Datensatz: ".$id;
  
  //Lesen der Aktivitäts-ID im zu ändernden Datensatz
  $sql = "SELECT * FROM aktivitaeten WHERE id=$id"; 
  $res = pg_query($db_link,$sql);
  $zeile = pg_fetch_row($res);
  echo "<br>Aktuelle Aktivitaet: ".$zeile[2];
}

if ($_GET[aendern])
{
   //Datensatz in die Tabelle schreiben!!!
   $sql = "UPDATE aktivitaeten ";
   $sql .= "SET datum='$_GET[datum]', aktion='$_GET[aktion]', dauer='$_GET[dauer]' WHERE id='$_GET[id]'";

   $result = pg_query($db_link, $sql); //Anfrage durchfuehren und Ergebnis in $result speichern

   if (!$result)//Ist ein Fehler bei der Einfuegeoperation aufgetreten?
   {
      die ('...Konnte Datensatz nicht aendern: ');
      echo pg_last_error($result);
   }

   pg_close(); //Schließen der Verbindung zur Datenbank
   header ("Location: anzeigen.php");
}
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
     <title>Zeitmanagement</title>
     <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>

  <body>
<h2>&Auml;nderung des ausgew&auml;hlten Datensatzes:</h2>
     <table>
         <form action="bearbeiten.php" method="GET">
            <tr>
			<td><input type="hidden" name="id" value="<?php echo $id; ?>"/></td>
			</tr>
			<tr>
                <td>Datum:</td>
                <td><input type="text" name="datum" size="10" maxlength="10" value="<?php echo $zeile[1]; ?>" /></td>
            </tr>
            <tr>
                <td>Aktivitaet:</td>
                <td><select size="1" maxlength="20" name="aktion">
				
                <?php $sql = "SELECT * FROM aktionen WHERE a_id='$zeile[2]'";
                      $aktuell = pg_fetch_row(pg_query($db_link, $sql));
					  echo'<option value="'.$aktuell[0].'">'.$aktuell[1].'</option>';
					  $sql = "SELECT * FROM aktionen";
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
                <td><input type="text" name="dauer" value="<?php echo $zeile[3]; ?>" /></td>
            </tr>
            <tr>
                <td><input type="submit" name="aendern" value="Datensatz &auml;ndern und zur&uuml;ck" /></td>
            </tr>
         </form>
         <tr></tr>
         <tr>
                <td><a href="anzeigen.php"/>zur&uuml;ck</td>
         </tr>
     </table>

</body>
</html>

         