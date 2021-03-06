<?php  //this must be the very first line on the php page, to register this page to use session variables
  include "header.php";
	//if this is a page that requires login always perform this session verification
  require_once "inc/functions.php";
  $connection = dbConnect();
  $feedback = array();

if(!adminLoggedIn())
{
	$_SESSION['timeout'] = time();
	require_once "inc/sessionVerify.php";
}
?>

<!DOCTYPE html PUBLIC>
<html lang="EN" dir="ltr" xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<title>Search Users</title>

	<!--Datatables scripts-->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css"/>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
	
  <!-- Stylesheet link -->
  <link href="style.css" rel="stylesheet">

	</head>

	<body>
		<br/><br/>
<?php
//Set defaults
		$firstName = "";
		$minAge = "1";
		$maxAge = "999";
		
		if(isset($_POST['FirstName']))									$firstName = $_POST['FirstName'];
		if(isset($_POST['minAge']) and !empty($_POST['minAge']))		$minAge = $_POST['minAge'];
		if(isset($_POST['maxAge']) and !empty($_POST['minAge']))		$maxAge = $_POST['maxAge'];
?>
		
	<form action = "" method = "post">
		<input type ="text" placeholder = "First Name" name = "FirstName" value = "<?php echo $firstName;?>"/>
		<input type ="text" placeholder = "Minimum Age" name = "minAge" value ="<?php if($minAge != "1") echo $minAge;?>"/>
		<input type ="text" placeholder = "Maximum Age" name = "maxAge" value ="<?php if($maxAge != "999") echo $maxAge;?>"/>
		<button type ="submit">Submit</button>
	</form>
		
		<?php
		//Make sure the database connection was succesful.
					
		if($connection === FALSE)
			array_push($feedback, '<p style = "color: red;">Cannot connect to database.</p>');
		else
		{
			//Create a prepared statement
			// Currently, there's no user inputs, but we plan to add that
			$statementText = "SELECT * FROM READABLE_ACTIVATED_USERS WHERE FirstName LIKE CONCAT(?, '%') AND ApproxAge BETWEEN ? AND ?;";
			$statement = $connection->prepare($statementText);
			$successCheck = $statement->execute(array($firstName,$minAge,$maxAge));
			if($successCheck === FALSE)
				array_push($feedback, '<p style = "color: red;">Could not retrieve data.</p>');
			else
			{
				//Fetch all of the user's data, then close the cursor.
				$users = $statement->fetchAll(PDO::FETCH_OBJ);
				$statement->closeCursor();
				require_once("inc/build_table.php");
				echoUserTable($connection, $users, "user", $feedback);
			}
			
			
		}
		
		//Print feedback.
		foreach( $feedback as $item )
			echo $item;
			
		?>
		
		<p><a href = "HomePage.php">Return to Homepage</a></a>

		<br/><br/>
	</body>
</html>
