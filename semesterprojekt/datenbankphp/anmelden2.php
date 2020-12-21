<style type="text/css">
#form input{border:1px solid #ddd;padding:5px;border-radius:10px;}
#form button{border:1px solid #ddd;padding:5px;border-radius:10px;}
</style>


<html>
<head>
<meta charset="UTF-8">
</head>
<body background="arztlogo.jpg">
<div id="form">
<form action="anmeldung2.php" method="POST">
PraxisID:
<br>
<input type="text" name="PraxisID"/>
<br>
Praxis Name:
<br>
<input type="text" name="PraxisName"/>
<br>
Adresse:
<br>
<input type="text" name="Adresse"/>
<br>
Passwort:
<br>
<input type="password" name="Passwort"/>
<br>
Passwort(bestätigen):
<br>
<input type="password" name="Passwortbestatigen"/>
<br>
<button type="submit">Register</button>
</form>
</div>
</body>
</html>