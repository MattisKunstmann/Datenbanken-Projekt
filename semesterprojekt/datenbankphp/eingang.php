<?php$db_link = pg_connect("host=127.0.0.1 port=5432 dbname=ersteDB user=postgres password=Besiktas.76");

         if (!$db_link)//Ist ein Fehler bei der Verbindungsherstellung aufgetreten?
         {
           die ('...keine Verbindung zum DB-Server möglich: ');
           echo pg_last_error($db_link);
         }
		 ?>
		 
<style type="text/css">
a.buton{
    background:#d21b00;
    background: -moz-linear-gradient(top, #d21b00, #8e0700);
    background: -webkit-gradient(linear, left top, left bottom, from(#d21b00), to(#8e0700));        
    padding:10px 15px;
    text-decoration:none;
    color:#fff;
    font:bold 26px Arial, Helvetica, sans-serif;
    -moz-border-radius: 7px;
    -webkit-border-radius: 7px;
    border-radius: 7px;
    text-shadow: 0 -1px 1px rgba(0, 0, 0, 0.75);
    border:5px solid #fff;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.75);
    -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.75);
    -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.75);    
}

a.buton:hover{
    background: -moz-linear-gradient(top, #8e0700, #d21b00);
    background: -webkit-gradient(linear, left top, left bottom, from(#8e0700), to(#d21b00));
    text-shadow: 0 1px 1px rgba(0, 0, 0, 0.75);
    box-shadow: 0 -1px 2px rgba(0, 0, 0, 0.75);
    -moz-box-shadow: 0 -1px 2px rgba(0, 0, 0, 0.75);
    -webkit-box-shadow: 0 -1px 2px rgba(0, 0, 0, 0.75);    
}

  a.buton
   {
      position: relative;

      left:600px;
	  bottom:-150px;
   }
</style>
		 
		 <!DOCTYPE html>

 <html>
<head>
<meta charset="UTF-8">
<title>Arztpraxisanalysetools</title>
</head>
<body background="arztlogo.jpg">
<br>
<br>
<br>
 <a href="anmelden.php" class="buton">Patient Registrierung</a> <a href="#"class="buton">Login</a>

<br>
<br>
<br>
 <a href="anmelden1.php" class="buton">Arzt Registrierung</a> <a href="#"class="buton">Login</a>	
<br>
<br>
<br>
 <a href="anmelden2.php" class="buton">Krankenkasse Registrierung</a> <a href="#"class="buton">Login</a>
<br>
<br>
<br>




</body>
</html>