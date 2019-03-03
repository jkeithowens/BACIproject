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

			//calls dependencies
			require_once "inc/functions.php";

			function attemptReset(&$email, &$resetPIN, &$pass, &$conpass)
			{
				//Don't return anything if nothing's been submitted yet.
				if(!isset($_POST['submit']))
					return '';
				
				//If anything's empty, return that feedback to the user.
				if(empty($email))
					return 'Please enter an email address';
				if(empty($resetPIN))
					return 'Please enter a reset PIN';
				if(empty($pass))
					return 'Please enter a password';
				if(empty($conpass))
					return 'Please enter the confirmation password';
				
				//Check if the resetPIN is invalid.
				if(strlen($resetPIN) != 6)
				{
					//if it's invalid, clear it, and return an error.
					$resetPIN = "";
					return 'Invalid Reset PIN';
				}
				//Check if the email is invalid.
				if(!filter_var($email, FILTER_VALIDATE_EMAIL))
				{
					//if it's invalid, clear it, and return an error.
					$email = "";
					return 'Invalid email address';
				}
				//Create a feedback array to use with the password validator function.
				$feedback = array();
				passwordCheck($pass, $conpass, 10, $feedback);
				//If we got feedback, something went wrong.
				if(!empty($feedback))
				{
					//Clear out the password and confirmation password if something went wrong, then return the feedback.
					$pass = $conpass = "";
					return $feedback[0];
				}
				
				//If we're here, things look good enough to attempt a database check (password is valid, reset PIN is valid, email is valid.)
				//Initialize a connection.
				$connection = dbConnect();
				if($connection === FALSE)
					return 'Error connecting to database';
				
				//Check if this email/resetPIN combination exists within the database.
				$procedure = 'call sp_count_users_by_email_resetPIN("' . $email . '","' . $resetPIN . '")';
				$procedureCall = $connection->query($procedure);
				//If the procedure call fails, return a generic query error.
				if(!$procedureCall)
					return 'Query Error 1';
				
				//Get the count of users with this email and PIN combo.  if it's not 1, something's wrong.
				$result = $procedureCall->fetch(PDO::FETCH_OBJ);
				$count = $result->c;
				$procedureCall->closeCursor();
				if($count != 1)
					return 'Email or Reset PIN incorrect.';
				
				//Otherwise, everything's good.  Attempt the reset.
				$hashedPassword = passHash($pass);
				$procedure = 'call SP_Update_Password("' . $email . '","' . $hashedPassword . '");';
				$procedureCall = $connection->query($procedure);
				//If we get a query error, return a generic query error.
				if($procedureCall === FALSE)
					return 'Query Error 2';
				
				//if we're here, everything worked.  Report a success.
				return '<b>Password changed successfully!</b>';
				
			}
			
			$email = "";
			$resetPIN = "";
			$pass = "";
			$conpass = "";
			if(isset($_POST['submit']))
			{
				$email=$_POST['vEmail'];
				$resetPIN = $_POST['resetpin'];
				$pass = $_POST['pass'];
				$conpass = $_POST['conpass'];
			}
			$message = attemptReset($email, $resetPIN, $pass, $conpass);



			?>
			            <!-- Form for login Starts Here -->
			        <div class="container containerinput" style="margin-top:75px">
			          <div>
			          <!-- Heading Of The Form -->
			            <H3>Enter your email to reset password</H3>
			            <p><?php echo $message;?></p>
			              <form action="#" id="form" method="post" name="form">
			                <!-- Form contains a field for login and password -->
			              <input name="vEmail" placeholder="Your Email" type="text" value="<?php echo $email?>">
			              <input name="resetpin" placeholder="Enter Reset PIN" type="password" value="<?php echo $resetPIN?>" >
			              <input name="pass" placeholder="Enter New Password" type="password" value ="<?php echo $pass?>">
			              <input name="conpass" placeholder="Enter Confirm Password" type="password" value="<?php echo $conpass?>">
			              <br />
			              <input id="send" name="submit" type="submit" value="submit">
			            </form>
			          </div>
			        </div>
		</div>


		<div>
			<a href="adminLogin.php">Admin Login</a>
		</div>

	</body>

</html>
