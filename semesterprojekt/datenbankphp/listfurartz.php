<?php

         $db = pg_connect("host=localhost port=5432 dbname=postgres user=postgres password=Besiktas.76");

         $query = "SELECT * FROM PATIENTAKTE";
         $result = pg_query($db, $query);

         echo pg_last_error($db);

         echo "<table border = 3>";

         while($row = pg_fetch_array($result))
         {
             echo "<tr><td>".$row[0]."</td>";
             echo "<td>".$row[1]."</td>";
             echo "<td>".$row[2]."</td>";
			 echo "<td>".$row[3]."</td>";
			 echo "<td>".$row[4]."</td>";


             echo "<td>".$row['NAME']."</td>";
             echo "<td>".$row['ERKRANKUNG_ID']."</td>";
			  echo "<td>".$row['KRANKHEITHISTORIE']."</td>";
             echo "<td>".$row['KRANKSCHREIBEN']."</td></tr>";
         }
         echo "</table>";
?>