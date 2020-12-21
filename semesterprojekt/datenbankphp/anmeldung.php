
<?php
include "verbinden.php";

$PatientID = $_POST["PatientID"];
$PatientName =$_POST["PatientName"];
$PatientVorname =$_POST["PatientVorname"];
$Passwort =$_POST["Passwort"];
$Passwortbestatigen =$_POST["Passwortbestatigen"];

if((strcmp($PatientID,"")==0) || (strcmp($PatientName,"")==0) || (strcmp($PatientVorname,"" )==0) )
{
	echo "Bitte geben Sie alle Felder vollstandig!";
	header ('Refresh:3;url=anmelden.php');
}
else
{
	if(strcmp($Passwort,$Passwortbestatigen)!=0)
	{
		echo "Passworten nicht passt! Bitte versuchen Sie nochmal !";
		header ('Refresh:3;url=anmelden.php');
	}
	else
	{
		//$query = "INSERT INTO benutzeralspatient (patient_id,patient_name,patient_vorname,passwort,passwortbestatigen)";
		//$query .= " VALUES('$PatientID','$PatientName','$PatientVorname','$Passwort','$Passwortbestatigen')";
		echo"vor dem insert...";
		$query = "INSERT INTO benutzeralspatient (patient_id,patient_name,patient_vorname,passwort,passwortbestatigen)";
		$query .= " VALUES (4,'test3','billi','1234','1234')";
		echo"nach dem insert...";
		
		$result = pq_query($db_link, $query);

		if(!$result)
		{
			echo "Fehler! Bitte versuchen Sie nochmal !";
			echo pg_last_error($db_link);
		}
		else
		{
			echo "Anmeldung ist erfolgreich !";
		}
	}	
}

?>