<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8"/>
		<title>My Template</title>
		<link rel=Stylesheet href="style.css" type="text/css"/>
	</head>

	<body>
<?php include "header.php"; ?>

		<div id = "main">
			<?php
			//Call dependencies
			require_once("inc/functions.php");
			require_once("inc/adminOBJ.php");
			
			//Include pages.
			include("header.php"); 
			include("sidenav.php");
			$connectedToDatabase = FALSE;
			$connectedToDatabase = dbConnect();
			if(!$connectedToDatabase)
			{
				echo '<p>Database connection failed!</p>';
			}
			
			$username = "";
			$password = "";
			$feedback = array();
			if(isset($_POST['vUsername'])
			{
				$username = $_POST['vUsername'];
				$password = $_POST['vPassword'];
			}

			?>
			            <!-- Form for login Starts Here -->
			        <div class="container containerinput" style="margin-top:75px">
			          <div>
			          <!-- Heading Of The Form -->
			            <H1>Admin Login:</H1>
			              <form action="#" id="form" method="post" name="form">
			                <!-- Form contains a field for login and password -->
							<input name="vUsername" placeholder="Enter Username" type="text" value="">
							<input name="vPassword" placeholder="Enter Password" type="password" value="">
			              <br />
			              <input id="send" name="submit" type="submit" value="Submit">
			            </form>
			          </div>
			        </div>
		</div>

	</body>

</html>
