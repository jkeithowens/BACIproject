<?php
/* CODE HIDER START LINE --- REMOVE THIS LINE AND THE END LINE TO END CODE HIDING.
This code has been hidden due to security vulnerabilities.


include("inc/functions.php");
include("inc/adminOBJ.php");
session_start();

$fetchSuccess = false;

//Don't try to do any of this unless an admin is logged in and they're at least a coordinator.
$run = false;
if(adminLoggedIn())
	if($_SESSION['admin']->isAtLeastCoordinator())
		$run = true;

if(!$run)
	echo '<p style = "color: red;">Insufficient privileges</p>';
else
{
	//require_once("db.php"); <-- Where does this come from?
	$servername = "localhost";
	$username = "aliden";
	$password = "aliden";
	$db = "aliden_db";

	//Why is this using mysqli when we've been using PDO the whole time for this project?
	$conn = mysqli_connect($servername, $username, $password,$db);
	// Check connection
	if (!$conn) {
		echo '<p style = "color: red;">Error connecting to database.</p>';
		die("Connection failed: " . mysqli_connect_error());
	}
	else
	{
		//Only attempt queries if the connection was successful.
		$gender=$_POST['gender'];
		$state=$_POST['state'];
		$country=$_POST['country'];
		$degree=$_POST['degree'];
		$fromdate=$_POST['fromdate'];
		$todate=$_POST['todate'];
		$diff = (strtotime($todate)- strtotime($fromdate))/24/3600;

		// To get total count
		//HUGE SECURITY FLAW.  This is begging for a SQL injection attack.  Keep this code here as an example of what NOT to do.
		//$query = "SELECT distinct UserID FROM USER_EDUCATION where Type='$degree'";
		//$res=mysqli_query($conn,$query);

		//And here's how you're supposed to do it.
		//Create the statement text.
		$statementText = "SELECT distinct UserID FROM USER_EDUCATION where Type=?;";
		//prepare the statement.
		$statement = $conn->prepare($statementText);
		//Bind a string ("s") of value $degree to the statement.
		$statement->bind_param("s", $degree);
		$statement->execute();


		$rowcount=0;
		$j=0;
		//Fetch the statement results.
		while($row=$statement->fetch_assoc())
		{
			$userid=$row['UserID'];
			for($i=0;$i<=$diff;$i++)
			{
				$dateformat = date ("Y-m-d", strtotime ($fromdate ."+$i days"));
				
				//Again, NEVER do this!  This is an SQL-injection vulnerable line of code.
				//$getusers="SELECT * from USER where Gender='$gender' and id='$userid' and StateProvinceID='$state' and CountryID='$country' and RegisterDate='$dateformat'";
				//$result=mysqli_query($conn,$getusers);
				//Store the statement text.
				$getusersText = "SELECT * from USER where Gender=? and id=? and StateProvinceID=? and CountryID=? and RegisterDate=?";
				//Prepare the statement.
				$getusers = $conn->prepare($getusersText);
				//Bind the parameters for the statement.
				$getusers->bind_param("sssss", $gender, $userid, $state, $country, $dateformat);
				//Execute the statement.				
				$getusers->execute();
				
				if($result)// eliminate duplicates records
				{
					
					
					
					$rowcount+=mysqli_num_rows($result);
					
				}
				$getusers->close();
			}
		}
		//Clsoe the statement and mark the fetching as successful.
		$fetchSuccess = true;
		$j++; //<--What does j do?

		//end <--What's the point of this comment?
		 
		 //Why is this query here?  We already have this statement from earlier!!!!!!
		$query = "SELECT distinct UserID FROM USER_EDUCATION where Type='$degree'";
		$res=mysqli_query($conn,$query);
		echo "Total count $rowcount";
	}
}
?>
<br/>
<a href="exportCSV.php?gender=<?php echo $gender?>&&state=<?php echo $state;?>&&country=<?php echo $country;?>&&degree=<?php echo $degree;?>&&fromdate=<?php echo $fromdate;?>&&todate=<?php echo $todate;?>" >Download CSV File</a>
<?php
if(!$fetchSuccess)
	echo '<p style= "color: red">An error occured while attempting to create the table!</p>';
else
{
	//this table originates from https://www.w3schools.com/css/tryit.asp?filename=trycss_table_fancy
	echo "<table id='customers'>
	<tr><th>FirstName</th><th>lastName</th><th>Email</th><th>Gender</th></tr>";
	while($row=mysqli_fetch_assoc($res))
	{
		$userid=$row['UserID'];
		for($i=0;$i<=$diff;$i++)
		{

			$dateformat = date ("Y-m-d", strtotime ($fromdate ."+$i days"));
		
			$getusers="SELECT * from USER where Gender='$gender' and id='$userid' and StateProvinceID='$state' and CountryID='$country' and RegisterDate='$dateformat'";
			//$getusers="SELECT * from USER where id='$userid' and StateProvinceID='$state' and CountryID='$country'";
		
			$result=mysqli_query($conn,$getusers);
			$j=0;
			
			if($result)
			{
			while($row1=mysqli_fetch_assoc($result))
			{
				$sex=$row1['Gender'];
				$email=$row1['Email'];
				$fname=$row1['FirstName'];
				$lname=$row1['LastName'];

				echo "<tr><td>$fname</td><td>$lname</td><td>$email</td><td>$sex</td></tr>";
			
			 }
			}
			
			
			$j++;
		}
	}
	echo "</table>";
}
	



?>
<html>
	<head>
		<style>
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #4CAF50;
    color: white;
}
</style>
	</head>
</html>


CODE HIDER END LINE --- REMOVE THIS LINE AND THE START LINE TO END CODE HIDING. */?>