<?php
/* CODE HIDER START LINE --- REMOVE THIS LINE AND THE END LINE TO END CODE HIDING.
This code has been hidden due to security vulnerabilities.

// Database Connection
//require("db.php");
$servername = "localhost";
 
$username = "aliden";
 
$password = "aliden";
 
$db = "aliden_db";

$conn = mysqli_connect($servername, $username, $password,$db);
// Check connection
 
if (!$conn) {
 
   die("Connection failed: " . mysqli_connect_error());
 
}
$gender=$_REQUEST['gender'];
$state=$_REQUEST['state'];
$country=$_REQUEST['country'];
$degree=$_REQUEST['degree'];
$fromdate=$_REQUEST['fromdate'];
$todate=$_REQUEST['todate'];
$diff = (strtotime($todate)- strtotime($fromdate))/24/3600;
 
$query = "SELECT distinct UserID FROM USER_EDUCATION where Type='$degree'";
$res=mysqli_query($conn,$query);
$users = array();
while($row=mysqli_fetch_assoc($res))
{
	$userid=$row['UserID'];
	for($i=0;$i<=$diff;$i++)
	{
	 	$dateformat = date ("Y-m-d", strtotime ($fromdate ."+$i days"));
	 	//$getusers="SELECT * from USER where Gender='$gender' and id='$userid' and StateProvinceID='$state' and CountryID='$country' and RegisterDate='$dateformat'";
	 	$getusers="SELECT FirstName,LastName,Email,Gender from USER where id='$userid' and StateProvinceID='$state' and CountryID='$country' and RegisterDate='$dateformat'";
	 	
	 	$result=mysqli_query($conn,$getusers);
	 	$j=0;
		if($result)
	 	{
	 	while($row1=mysqli_fetch_assoc($result))
	 	{
	 		
	 		$users[] = $row1;
		 	$sex=$row1['Gender'];
		 	$email=$row1['Email'];
		 	$fname=$row1['FirstName'];
		 	$lname=$row1['LastName'];

		 
		 }
	 	}
	 	$j++;
 	}
}
	
header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename=Users.csv');
$output = fopen('php://output', 'w');
fputcsv($output, array('FirstName','LastName','Email','Gender'));
 
if (count($users) > 0) {
    foreach ($users as $row) {
        fputcsv($output, $row);
    }
}



?>

CODE HIDER END LINE --- REMOVE THIS LINE AND THE START LINE TO END CODE HIDING. */?>
