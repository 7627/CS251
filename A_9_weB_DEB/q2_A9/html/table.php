<?php

$db=new SQLite3('db/registeration.db');

// echo "<h2>Records:</h2>";
// echo "<h3>Name  Email  Address  Mob.No  Ac/no.</h3>";
// $results = $db->query("SELECT * FROM users");
// while ($row = $results->fetchArray()) {
//       echo "<br> $row[0] $row[1] $row[2] $row[3] $row[4]";
// }
if($_SERVER["REQUEST_METHOD"]=="POST"){
  echo "<h2>Records:</h2>";

  $results = $db->query("SELECT * FROM users");
  while ($row = $results->fetchArray()) {
  	    echo "<br> $row[0] $row[1] $row[2] $row[3]";
  }
  echo "<br><br><br><br>";
}
echo "<a href='index.html'>New Registeration</a>";
 ?>
