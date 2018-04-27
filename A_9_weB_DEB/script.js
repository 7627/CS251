function validate(){
  flag=0;
  var name= document.forms["myform"]["name"].value;
  if(name==="" || name.length>20 || /\d/.test(name)){
    text="Name not valid";
    flag=1;
  }
  else text="";
  document.getElementById("nameError").innerHTML=text;

  var email=document.forms["myform"]["email"].value;
  if(/[a-z]+@/.test(email) && /@[a-z]+\.com/.test(email)){
    text=""
  }
  else{
    text="Email not valid";
    flag=1;
  }
  document.getElementById("emailError").innerHTML=text;

  var address=document.forms["myform"]["address"].value;
  if(address.length>100 || address===""){
    text="Address too long or empty";
    flag=1;
  }
  else text="";
  document.getElementById("addressError").innerHTML=text;

  var mob=document.forms["myform"]["mob"].value;
  if(!/[1-9][0-9]{9,9}/.test(mob) || mob.length>10){
    text="Mobile number invalid";
    flag=1;
  }
  else{
    text="";
  }
  document.getElementById("mobError").innerHTML=text;

  var bank=document.forms["myform"]["bank"].value;
  if(!/[0-9]{5,5}/.test(bank) || bank.length>5){
    text="Invalid Bank Account number";
    flag=1;
  }
  else text="";
  document.getElementById("bankError").innerHTML=text;

  var pass=document.forms["myform"]["pass"].value;
  if(!/\w{6,20}/.test(pass) || pass.length>20){
    text="Password should be atleast 6 and atmost 20 character long";
    flag=1;
  }
  else text="";
  document.getElementById("passError").innerHTML=text;

  if(flag===1){
    return false;
  }
  return true;
}
