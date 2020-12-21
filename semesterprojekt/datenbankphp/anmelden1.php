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
<form action="anmeldung1.php" method="POST">
ArztID:
<br>
<input type="text" name="ArztID"/>
<br>
PraxisID:
<br>
<input type="text" name="PraxisID"/>
<br>
Arzt Name:
<br>
<input type="text" name="ArztName"/>
<br>
Arzt Vorname:
<br>
<input type="text" name="ArztVorname"/>
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