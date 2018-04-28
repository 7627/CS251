<html>
</body>

<?php
// $user='root';
// $pass='';
// $db='registeration';
echo "connecting";

//connect to the databse at this address, or stop if unable to connect
//$db = new PDO('sqlite:db/registeration.db') or die("Uncable to connect to database");
$db = new SQLite3('db/registeration.db');
if($db)
     echo "<p>connected to database</p>";

//execute only if page is opened by post method
if($_SERVER["REQUEST_METHOD"]=="POST"){
  //get the value recieved by post
  $name = test_input($_POST["name"]);
  $email = test_input($_POST["email"]);
  $address = test_input($_POST["address"]);
  $mob = test_input($_POST["mob"]);
  $bank = test_input($_POST["bank"]);
  $pass = test_input($_POST["pass"]);
  // $db->query("INSERT INTO users VALUES('$name','$email','$address','$mob','$bank','$pass');");
  // $qry=$db->prepare("INSERT INTO users(name, email, address, mob, bank, pass) VALUES(?,?,?,?,?,?);");
  // $qry->execute(array($name,$email,$address,$mob,$bank,$pass));

  // $stmt="SELECT * FROM users WHERE email='$email' ";
  $result=$db->query("SELECT * FROM users WHERE email='$email'");
  // $count=0;
  echo "$count";
  while($qry = $result->fetchArray()){
    $count++;
  }
  // echo "$count"; //if count == 0 means email is not registered
  if($count>0){
    echo "<p>Email already registered</p>";
  }

  //check the account balance;
  $stmt="SELECT * FROM accounts WHERE bank='$bank'";
  $results=$db->query($stmt);
  $acc = $results->fetchArray();
  $bal=$acc[2];
  $suff_bal=0;
  // echo "<p>$acc[1] $pass</p>";
  if($acc[1]=="$pass"){
    if($bal>1000){
      $suff_bal=1;
    }
    else{
      echo "<p>Insufficient Balance</p>";
    }
  }
  else{
    echo "<p>Acc no/password donot match</p>";
  }
  // echo "<p>$bal $suff_bal</p>";


  if($count==0 && $suff_bal==1){
    //following two lines should insert the entry into the table
    $db->query("INSERT INTO users VALUES('$name','$email','$address','$mob','$bank','$pass')");
    $db->query("UPDATE accounts SET bal = $bal-1000 WHERE bank=$bank");
    echo "$name $email $address $mob $bank $pass ";
    echo "<p>Successfully registered</p>";
  }
  else{
    // echo "Email already registered or Insufficient Balance";
  }

}
// echo "<p>line 62</p>";


// echo "$_SERVER["PHP_SELF"]";

//edit the text to remove some secia characters
function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

// echo "<br><br><br><br><br><br>";
echo "<a href='index.html'>New Registeration</a>";
// echo "<h2>Records:</h2>";
//
// $results = $db->query("SELECT * FROM users");
// while ($row = $results->fetchArray()) {
// 	    echo "<br> $row[0] $row[1] $row[2] $row[3]";
// }
 ?>

</body>
</html>
