
<!DOCTYPE HTML>
<html>
	<head>
     <title>Insert Patient</title>
     <meta http-equiv="content-type" content="text/html; charset=utf-8">
	</head>

	<body>
     <h2>Neue Patientakte :</h2>
     <table>
			<form action="index.php" method="GET">
				<tr>
					<td>Patient_ID:</td>
					<td><select size="1" maxlength="5" name="Patient_ID">
			//<?php $sql = "SELECT Patient_ID FROM PATIENT";
                      $result = pg_query($db_link, $sql);
                      while($row = pg_fetch_array($result))
                      {
                         echo '<option value="'.$row[0].'">'.$row[1].'</option>';
                      } ?>
						</select>
					</td>
				</tr>
				<tr>
				<td>Erkrankung_ID:</td>
					<td><select size="1" maxlength="20" name="Erkrankung_ID">
			<?php $sql = "SELECT ERKRANKUNG_ID FROM ERKRANKUNG";
                      $result = pg_query($db_link, $sql);
                      while($row = pg_fetch_array($result))
                      {
                         echo '<option value="'.$row[0].'">'.$row[1].'</option>';
                      } ?>
						</select>
					</td>
					</tr>
					<tr>
                <td>Krankheithistorie:</td>
                <td><textarea name="krankheit" cols="25" rows="5"/></td>
            </tr>
				<tr>
                <td>Krankschreiben:</td>
                <td><select size="1" maxlength="3" name="Krankschreiben"></td>
            </tr>
			<tr>
				<td>Krankenkasse_ID:</td>
					<td><select size="1" maxlength="20" name="Krankenkasse_ID">
			<?php $sql = "SELECT KÜRZEL FROM KRANKENKASSE";
                      $result = pg_query($db_link, $sql);
                      while($row = pg_fetch_array($result))
                      {
                         echo '<option value="'.$row[0].'">'.$row[1].'</option>';
                      } ?>
						</select>
					</td>
					</tr>
					<tr>
				<td>Arzt_ID:</td>
					<td><select size="1" maxlength="20" name="Arzt_ID">
			<?php $sql = "SELECT ARZT_ID FROM ARZT";
                      $result = pg_query($db_link, $sql);
                      while($row = pg_fetch_array($result))
                      {
                         echo '<option value="'.$row[0].'">'.$row[1].'</option>';
                      } ?>
						</select>
					</td>
					</tr>
					<tr>
                <td>Datum (Tag / Monat / Jahr):</td>
                <td><input type="text" name="tag" size="1" maxlength="2" />
                    <input type="text" name="monat" size="1" maxlength="2" />
                    <input type="text" name="jahr" size="2" maxlength="4" />
                </td>
            </tr>
			<tr>
                <td>Uhrzeit:</td>
                <td><input type="text" name="dauer" value="00.00" /></td>
            </tr>
			<tr>
                <td><input type="submit" name="Speichern" value="Datensatz speichern" /></td>
            </tr>
			
			
				
			</form>
			
			
				
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
         $sql = "INSERT INTO PATIENAKTE ";
         $sql .= "(Patient_ID,Erkankung_ID,krankheit,Krankschreiben,Krankenkasse_ID,Arzt_ID,datum,dauer) ";
         $sql .= "VALUES ( '$_GET[PATIENT_ID]', '$_GET[ERKRANKUNG_ID]', '$_GET[KRANKHEITHISTORIE]', '$_GET[KRANKSCHREIBEN]',
		 '$_GET[KRANKENKASSE_ID]', '$_GET[ARZT_ID]','$datum','$_GET[UHRZEIT]')";

         $result = pg_query($db_link, $sql); //Anfrage durchfuehren und Ergebnis in $result speichern

         if (!$result)//Ist ein Fehler bei der Einfuegeoperation aufgetreten?
         {
           die ('...Konnte Datensatz nicht speichern: ');
           echo pg_last_error($result);
         }

         pg_close(); //Schließen der Verbindung zur Datenbank
   }
?>