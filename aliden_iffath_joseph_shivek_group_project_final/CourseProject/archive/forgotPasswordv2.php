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

			function attemptResetEmail(&$email)
			{
				//If nothing's submitted, return an empty message.
				if(!isset($_POST['submit']))
					return '';
				
				//If the email field is empty, return a message saying to fill out the field.
				if(empty($email))
					return 'Please enter an email address';
				
				//If the email field is invalid, return a message saying it's not valid and clear it.
				if(!filter_var($email, FILTER_VALIDATE_EMAIL))
				{
					$email = "";
					return 'Invalid email entered';
				}
				
				//Otherwise, attempt to connect to the database.
				$connection = dbConnect();
				if($connection === FALSE)
					return 'Error connecting to database';
				
				// Call a procedure to see if this email address exists.
				$procedure = 'call sp_count_users_by_email("' . $email . '");';
				$procedureCall = $connection->query($procedure);
				//If the query doesn't execute successfully, return a generic query error.
				if(!$procedureCall)
					return 'Query Error 1';
				
				//Otherwise, get the count from the query and close the cursor.
				$result = $procedureCall->fetch(PDO::FETCH_OBJ);
				$count = $result->c;
				$procedureCall->closeCursor();
				if($count != 1)
					return 'User does not exist';
				
				//As long as the user exists, generate a PIN and try to store it on the database.
				$PIN = generatePIN();
				$procedure = 'call sp_update_resetPIN("' . $email . '","' . $PIN . '");'; 
				$procedureCall = $connection->query($procedure);
				//Return a generic query error if we get a failure.
				if($procedureCall === FALSE)
					return 'Query Error 2';
				
				//Otherwise, try to create the reset email.
				$subject = "Reset Password";
				//sets body for Mail() function
				$body = 'Please <a href="http://corsair.cs.iupui.edu:23081/CourseProject/resetPassword1.php">click here</a> to reset password using the reset PIN below. <br/>
				Reset PIN ="'.$PIN.'<br/>';
				//calls mail function to send out the activation email, shows message if successful
				$mailer = new Mail();
				if (($mailer->sendMail($email,"BACI USER", $subject, $body))==true)
					return "<b>A password reset form has successfully been sent.</b>";
				//message displays an error if email does not go through
				else 
					return "Email not sent. " . $email.' '. $subject.' '. $body;
			}
			
			//calls dependencies
			require_once "inc/functions.php";
			require_once "inc/mail/mail.class.php";
			//Get the email address.
			$email = "";
			if(isset($_POST['vEmail']))
				$email=trim($_POST['vEmail']);
			//Attempt a reset.
			$message = attemptResetEmail($email);

			?>
			            <!-- Form for login Starts Here -->
			        <div class="container containerinput" style="margin-top:75px">
			          <div>
			          <!-- Heading Of The Form -->
			            <H3>Enter your email to reset password</H3>
			            <p><?php echo $message;?></p>
			              <form action="#" id="form" method="post" name="form">
			                <!-- Form contains a field for login and password -->
			              <input name="vEmail" placeholder="Your Email" type="text" value="<?php echo $email;?>">
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
